import 'package:food_app/scr/models/cart_item.dart';

class CartResponse {
  List<CartItemModel> data;
  String message;
  String type;
  int code;
  CartResponse({this.data, this.message, this.type});

  CartResponse.fromJson(Map<String, dynamic> json, int code) {
    if (json['data'] != null) {
      data = new List<CartItemModel>();
      json['data'].forEach((v) {
        data.add(new CartItemModel.fromJson(v));
      });
    }
    message = json['message'];
    type = json['type'];
    this.code = code;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['type'] = this.type;
    return data;
  }
}
