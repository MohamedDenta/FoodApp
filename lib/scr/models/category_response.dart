import 'package:flutter/foundation.dart';

import 'category.dart';

class CategoryResponse {
  List<CategoryModel> data;
  String message;
  String type;
  int code;
  CategoryResponse({this.data, this.message, this.type});

  CategoryResponse.fromJson(Map<String, dynamic> json, int code) {
    if (json['data'] != null) {
      data = new List<CategoryModel>();
      json['data'].forEach((v) {
        data.add(new CategoryModel.fromJson(v));
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
