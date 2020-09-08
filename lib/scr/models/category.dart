// import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String sId;
  String sName;
  String sImage;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sName = json['_name'];
    sImage = json['_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['_name'] = this.sName;
    data['_image'] = this.sImage;
    return data;
  }
}
