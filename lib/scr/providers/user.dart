import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/scr/helpers/order.dart';
import 'package:food_app/scr/helpers/user.dart';
import 'package:food_app/scr/helpers/user.dart';
import 'package:food_app/scr/models/auth_response.dart';
import 'package:food_app/scr/models/cart_item.dart';
import 'package:food_app/scr/models/cart_response.dart';
import 'package:food_app/scr/models/order.dart';
import 'package:food_app/scr/models/products.dart';
import 'package:food_app/scr/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:uuid/uuid.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering,
  Registered,
  Unregistered
}

class UserProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  UserServices _userServicse = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;
  AuthResponse _response = AuthResponse();

  bool islogin = false;
//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  AuthResponse get response => _response;
// setters
  set userModel(UserModel userModel) => _userModel;
  set response(AuthResponse response) => _response;
  // public variables
  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  UserProvider.initialize() {
    checkLogin();
  }
  void checkLogin() async {
    var prefs = await SharedPreferences.getInstance();
    islogin = prefs.getBool('login') ?? false;
    if (islogin) {
      _status = Status.Authenticated;
      _userModel = new UserModel();
      _userModel.email = prefs.getString('email');
      _userModel.id = prefs.getString('id');
      _userModel.name = prefs.getString('name');
    } else {
      _status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();

      var u = UserModel();
      u.email = email.text;
      u.password = password.text;
      var response = await UserServices.loginUser(u);
      _response = response;
      notifyListeners();

      if (_response.code == 200) {
        _status = Status.Authenticated;
        notifyListeners();
      }

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<AuthResponse> signUp(BuildContext context) async {
    //try {
    _status = Status.Registering;
    notifyListeners();

    var res = await UserServices.registerUser(context);

    if (res.code == 200) {
      _status = Status.Registered;
      notifyListeners();
      return res;
    } else {
      _status = Status.Unregistered;
      notifyListeners();
      return res;
    }
  }

  Future<bool> likeDisLike(String id, String uid) async {
    var res = await UserServices.likeDislike(id, uid);
    return res.code == 200;
  }

  Future<bool> checkIsLiked(String sId, String uid) async {
    var res = await UserServices.checkIsLiked(sId, uid);
    return res;
  }

  Future signOut() async {
    // _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  void reloadUserModel() {
    //_userModel =  _userServicse.getUserById(user.uid);
    //notifyListeners();
  }

  // Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
  //   if (firebaseUser == null) {
  //     _status = Status.Unauthenticated;
  //   } else {
  //     _user = firebaseUser;
  //     _status = Status.Authenticated;
  //     _userModel = await _userServicse.getUserById(user.uid);
  //   }
  //   notifyListeners();
  // }

  Future<String> addToCard(
      {ProductModel product, int quantity, String userId}) async {
    print("THE PRODUC IS: ${product.toString()}");
    print("THE qty IS: ${quantity.toString()}");

    try {
      //List cart = _userModel.cart;
      Map<String, dynamic> cartItem = {
        "_id": product.sId,
        "_uid": userId,
        "_name": product.sName,
        "_image": product.sImage,
        "_restaurant_id": product.sRestaurantId,
        "_total_restaurant_sale": product.iPrice * quantity,
        // "productId": product.sId,
        "_price": product.iPrice,
        "_quantity": quantity
      };
      CartItemModel item = CartItemModel.fromJson(cartItem);
      var res = await _userServicse.addToCart(cartItem: item);
      if (res.code == 200) {
        return "";
      }
      return res.message;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return e.toString();
    }
  }

  getOrders() {
    //orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({String id, String uid}) async {
    try {
      var res = await _userServicse.removeFromCart(uid: uid, id: id);
      if (res.code == 200) {
        res = await getCart(id: id, uid: uid);
      }
      return res.code == 200;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<CartResponse> getCart({String id, String uid}) async {
    try {
      var r = await _userServicse.getCart(id, uid);
      _userModel.cart = r.data;
      _userModel.totalCartPrice = calculatePrice(_userModel.cart);
      notifyListeners();
      return r;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return CartResponse();
    }
  }

  int calculatePrice(List<CartItemModel> cart) {
    int r = 0;
    for (var i = 0; i < cart.length; i++) {
      r += cart[i].iPrice;
    }
    return r;
  }
}
