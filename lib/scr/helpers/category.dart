import 'dart:convert';
import 'dart:io';

import 'package:food_app/scr/models/category_response.dart';

import 'package:http/http.dart' as http;

import 'app.dart';

class CategoryServices {
  String api = App.API;

  Future<CategoryResponse> getCategories() async {
    var url = api + "/get-categories";
    try {
      var response = await http.get(url);
      Map<String, dynamic> json = jsonDecode(response.body);
      CategoryResponse ret =
          CategoryResponse.fromJson(json, response.statusCode);

      return ret;
    } on Exception catch (e) {
      print(e.toString());
      return CategoryResponse();
    }
  }
}
