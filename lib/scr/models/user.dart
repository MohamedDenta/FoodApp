// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/scr/models/cart_item.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String name;
  String email;
  String id;
  String stripeId;
  String password;
  int _priceSum = 0;
  int _quantitySum = 0;

//  getters
  // String get name => _name;
  // String get email => _email;
  // String get id => _id;
  // String get stripeId => _stripeId;
  // String get password => _password;

// setters
  // set name(String name) => _name;
  // set email(String email) => _email;
  // set id(String id) => _id;
  // set stripeId(String stripId) => _stripeId;
  // set password(String password) => _password;
//  public variable
  List<CartItemModel> cart;
  int totalCartPrice;
  // UserModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   _name = snapshot.data[NAME];
  //   _email = snapshot.data[EMAIL];
  //   _id = snapshot.data[ID];
  //   _stripeId = snapshot.data[STRIPE_ID];
  //   cart = _convertCartItems(snapshot.data[CART]) ?? [];
  //   totalCartPrice = snapshot.data[CART] == null
  //       ? 0
  //       : getTotalPrice(cart: snapshot.data[CART]);
  // }
  UserModel({this.name, this.email, this.password, this.stripeId});

  Map<String, dynamic> toLoginJson() => {
        '_email': email,
        '_password': password,
      };
  Map<String, dynamic> toSignupJson() => {
        '_name': name,
        '_email': email,
        '_password': password,
        '_strip_id': stripeId,
      };
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['_name'];
    email = json['_email'];
    password = json['_password'];
    stripeId = json['_strip_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['_name'] = this.name;
    data['_email'] = this.email;
    data['_password'] = this.password;
    data['_strip_id'] = this.stripeId;
    return data;
  }

  int getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }

    int total = _priceSum;

    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");

    return total;
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
