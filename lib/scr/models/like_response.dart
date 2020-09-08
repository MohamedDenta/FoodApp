import 'package:food_app/scr/models/user.dart';

class LikeResponse {
  List<UserModel> data;
  String message;
  String type;
  int code;
  LikeResponse({this.data, this.message, this.type});

  LikeResponse.fromJson(Map<String, dynamic> json, int code) {
    if (json['data'] != null) {
      data = new List<UserModel>();
      json['data'].forEach((v) {
        data.add(new UserModel.fromJson(v));
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
