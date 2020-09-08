// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:ffi';

import 'package:food_app/scr/models/auth_response.dart';
import 'package:food_app/scr/models/like_response.dart';
import 'package:food_app/scr/models/product_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/products.dart';
import 'package:http/http.dart' as http;

import 'app.dart';

class ProductServices {
  String api = App.API;

  Future<ProductResponse> getProducts() async {
    String uid;
    var prefs = await SharedPreferences.getInstance();
    uid = prefs.getString("id");
    var url = api + "/get-featured-products";
    try {
      var body = {"_uid": uid};
      var response = await http.post(url, body: jsonEncode(body));
      Map<String, dynamic> json = jsonDecode(response.body);
      ProductResponse ret = ProductResponse.fromJson(json, response.statusCode);
      print(ret.message);

      return ret;
    } on Exception catch (e) {
      print(e.toString());
      return ProductResponse();
    }
  }

  Future<ProductResponse> getAllProducts() async {
    var url = api + "/get-all-products";
    try {
      var response = await http.get(url);
      Map<String, dynamic> json = jsonDecode(response.body);
      ProductResponse ret = ProductResponse.fromJson(json, response.statusCode);
      print(ret.message);
      return ret;
    } on Exception catch (e) {
      print(e.toString());
      return ProductResponse();
    }
  }

// TODO : make this function with the users table
  void likeOrDislikeProduct({String id, List<String> userLikes}) {}

  Future<ProductResponse> getProductsByRestaurant(
      {String id, String uid}) async {
    var url = api + "/get-products-by-restaurant";
    try {
      var body = {"_restaurant_id": id, "_uid": uid};
      var response = await http.post(url, body: jsonEncode(body));
      Map<String, dynamic> json = jsonDecode(response.body);

      ProductResponse ret = ProductResponse.fromJson(json, response.statusCode);
      print(ret.message);
      return ret;
    } on Exception catch (e) {
      print(e.toString());
      return ProductResponse();
    }
  }

  Future<LikeResponse> updateRate({String id, String uid, int rate}) async {
    var url = api + "/rate-product";
    try {
      var body = {"_id": id, "_uid": uid, "_data": rate};
      var response = await http.post(url, body: jsonEncode(body));
      Map<String, dynamic> json = jsonDecode(response.body);

      LikeResponse ret = LikeResponse.fromJson(json, response.statusCode);
      print(ret.message);
      return ret;
    } on Exception catch (e) {
      print(e.toString());
      return LikeResponse();
    }
  }

  Future<ProductResponse> getProductsOfCategory({String category}) async {
    var url = api + "/get-products-by-category";
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var uid = prefs.getString("id");
      print(uid);
      var body = {"_category": category, "_uid": uid};

      var response = await http.post(url, body: jsonEncode(body));
      Map<String, dynamic> json = jsonDecode(response.body);
      ProductResponse ret = ProductResponse.fromJson(json, response.statusCode);

      return ret;
    } on Exception catch (e) {
      print(e.toString());
      return ProductResponse();
    }
  }

  List<ProductModel> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return [];
    // return _firestore
    //     .collection(collection)
    //     .orderBy("name")
    //     .startAt([searchKey])
    //     .endAt([searchKey + '\uf8ff'])
    //     .getDocuments()
    //     .then((result) {
    //       List<ProductModel> products = [];
    //       for (DocumentSnapshot product in result.documents) {
    //         products.add(ProductModel.fromSnapshot(product));
    //       }
    //       return products;
    //     });
  }
}
