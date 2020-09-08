// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_app/scr/models/auth_response.dart';
import 'package:food_app/scr/models/cart_item.dart';
import 'package:food_app/scr/models/like_response.dart';
import 'package:food_app/scr/models/user.dart';
import 'package:food_app/scr/providers/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'app.dart';

class UserServices {
  String collection = "users";
  // Firestore _firestore = Firestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    // _firestore.collection(collection).document(id).setData(values);
  }

  static Future<AuthResponse> registerUser(BuildContext context) async {
    final String url = App.API + "/register";
    final bloc = Provider.of<UserProvider>(context, listen: false);
    print(url);
    var userModel = UserModel();
    userModel.name = bloc.name.text;
    userModel.email = bloc.email.text;
    userModel.password = bloc.password.text;
    final body = jsonEncode(userModel.toSignupJson());
    print(body);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    print("${response.body} ^^^^^^^^^^");
    var res =
        AuthResponse.fromJson(jsonDecode(response.body), response.statusCode);
    return res;
  }

  static Future<AuthResponse> loginUser(UserModel userModel) async {
    //userModel.email = "zwert1436@gmail.com";
    //userModel.password = "9df29067-a74c-4ee6-9224-13607f286dc8";
    // user to json
    var body =
        //userModel.toLoginJson();
        {
      '_email': "zwert1436@gmail.com",
      '_password': "9df29067-a74c-4ee6-9224-13607f286dc8",
    };

    var e = json.encode(body);
    //print(e);
    // post user json
    var response = await http.post(
      Uri.encodeFull(App.API + "/login"),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: e,
    );
    //print(response.body);

    var res =
        AuthResponse.fromJson(jsonDecode(response.body), response.statusCode);
    // res.code = response.statusCode;
    print("${res.code} &&&");
    return res;
  }

  static Future<LikeResponse> likeDislike(String id, String uid) async {
    // id = "87ac3936aef043f68053a3508902410a";
    // uid = "1364c746-ae62-43e4-b7ca-02ec71e8e478";
    var url = Uri.encodeFull(App.API + "/like-product");
    var e = jsonEncode({"_id": id, "_uid": uid});
    Response response = await http.post(url, body: e);
    print(response.statusCode);
    var res =
        LikeResponse.fromJson(jsonDecode(response.body), response.statusCode);
    return res;
  }

  static Future<bool> checkIsLiked(String sId, String uid) async {
    var url = Uri.encodeFull(App.API + "/check-like-product");
    var e = jsonEncode({"_id": sId, "_uid": uid});
    Response response = await http.post(url, body: e);
    print(response.statusCode);
    var m = jsonDecode(response.body);
    return m["data"];
  }

  void updateUserData(Map<String, dynamic> values) {
    String id = values['id'];
    // _firestore.collection(collection).document(id).updateData(values);
  }

  void addToCart({String userId, CartItemModel cartItem}) {
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    // _firestore.collection(collection).document(userId).updateData({
    //   "cart": FieldValue.arrayUnion([cartItem.toMap()])
    // });
  }

  void removeFromCart({String userId, CartItemModel cartItem}) {
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    // _firestore.collection(collection).document(userId).updateData({
    //   "cart": FieldValue.arrayRemove([cartItem.toMap()])
    // });
  }

  UserModel getUserById(String id) {
    return null;
    //   _firestore.collection(collection).document(id).get().then((doc) {
    //   return UserModel.fromSnapshot(doc);
    // });
  }
}
