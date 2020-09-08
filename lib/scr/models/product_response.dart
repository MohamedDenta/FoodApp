import 'package:flutter/foundation.dart';
import 'package:food_app/scr/models/products.dart';

import 'category.dart';

class ProductResponse {
  List<ProductModel> data;
  String message;
  String type;
  int code;
  ProductResponse({this.data, this.message, this.type});

  ProductResponse.fromJson(Map<String, dynamic> json, int code) {
    if (json['data'] != null) {
      data = new List<ProductModel>();
      // print("-------------------------------------");
      // print(json['data']);
      json['data'].forEach((v) {
        data.add(new ProductModel.fromJson(v));
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
