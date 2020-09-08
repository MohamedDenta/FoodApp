//import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

class RestaurantModel {
  String sId;
  String sName;
  String sImage;
  String sUserlikes;
  int iRating;
  int iAvgPrice;
  int iRates;
  bool bPopular;
  bool bLiked;

  RestaurantModel(
      {this.sId,
      this.sName,
      this.sImage,
      this.sUserlikes,
      this.iRating,
      this.iAvgPrice,
      this.iRates,
      this.bPopular,
      this.bLiked});

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sName = json['_name'];
    sImage = json['_image'];
    // // if (json['_userlikes'] != null) {
    // sUserlikes = jsonDecode(json['_userlikes'].toString());
    // // }
    sUserlikes = json['_userlikes'];
    iRating = json['_rating'];
    iAvgPrice = json['_avg_price'];
    iRates = json['_rates'];
    bPopular = json['_popular'];
    bLiked = json['_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['_name'] = this.sName;
    data['_image'] = this.sImage;
    data['_userlikes'] = jsonEncode(this.sUserlikes);
    data['_rating'] = this.iRating;
    data['_avg_price'] = this.iAvgPrice;
    data['_rates'] = this.iRates;
    data['_popular'] = this.bPopular;
    data['_liked'] = this.bLiked;
    return data;
  }
}
