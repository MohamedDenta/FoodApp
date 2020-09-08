import 'package:food_app/scr/models/restaurant.dart';

class RestaurantResponse {
  List<RestaurantModel> data;
  String message;
  String type;
  int code;
  RestaurantResponse({this.data, this.message, this.type, this.code});

  RestaurantResponse.fromJson(Map<String, dynamic> json, int code) {
    if (json['data'] != null) {
      data = new List<RestaurantModel>();
      json['data'].forEach((v) {
        var o = new RestaurantModel.fromJson(v);

        data.add(o);
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
