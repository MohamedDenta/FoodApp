// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:food_app/scr/helpers/app.dart';
import 'package:food_app/scr/models/restaurant_response.dart';
import 'package:http/http.dart';

import '../models/restaurant.dart';
import 'package:http/http.dart' as http;

class RestaurantServices {
  String collection = "restaurants";
  // Firestore _firestore = Firestore.instance;

  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      var url = Uri.encodeFull(App.API + "/get-restaurants");
      Response response = await http.get(url);
      var e = jsonDecode(response.body);
      // print(e['data'].length);
      // jsonDecode(jsonEncode(e['data']));
      // print(RestaurantModel.fromJson());
      var resp = RestaurantResponse.fromJson(e, response.statusCode);
      return resp.data;
    } on Exception catch (e) {
      print(e.toString());
      return List<RestaurantModel>();
    }
  }

  Future<List<RestaurantModel>> getPopularRestaurants() async {
    try {
      var url = Uri.encodeFull(App.API + "/get-popular-restaurants");
      Response response = await http.get(url);
      print(response.statusCode);
      var resp = RestaurantResponse.fromJson(
          jsonDecode(response.body), response.statusCode);
      return resp.data;
    } on Exception catch (e) {
      return List<RestaurantModel>();
    }
  }

  Future<RestaurantModel> getRestaurantById({String id, String uid}) async {
    try {
      var url = Uri.encodeFull(App.API + "/find-restaurant");
      var body = jsonEncode({"_id": id});

      var response = await http.post(url, body: body);

      var resp = RestaurantResponse.fromJson(
          jsonDecode(response.body), response.statusCode);
      return resp.data == null ? null : resp.data[0];
    } on Exception catch (e) {
      print(e.toString());
      return RestaurantModel();
    }
  }

  List<RestaurantModel> searchRestaurant({String restaurantName}) {
    // code to convert the first character to uppercase
    String searchKey =
        restaurantName[0].toUpperCase() + restaurantName.substring(1);
    return [];
    // return _firestore
    //     .collection(collection)
    //     .orderBy("name")
    //     .startAt([searchKey])
    //     .endAt([searchKey + '\uf8ff'])
    //     .getDocuments()
    //     .then((result) {
    //       List<RestaurantModel> restaurants = [];
    //       for (DocumentSnapshot product in result.documents) {
    //         restaurants.add(RestaurantModel.fromSnapshot(product));
    //       }
    //       return restaurants;
    //     });
  }
}
