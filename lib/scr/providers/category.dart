import 'package:flutter/material.dart';
import 'package:food_app/scr/models/category.dart';
import 'package:food_app/scr/models/category_response.dart';
import '../helpers/category.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> lstOfCategories = List();
  CategoryResponse response;

  CategoryProvider.initialize() {
    response = new CategoryResponse();
    response.data = List();
    loadCategories();
  }

  loadCategories() {
    _categoryServices.getCategories().then((response) {
      // if (response.code == 200) {

      if (response.code == 200) {
        lstOfCategories = response.data;
      }
      this.response = response;
      notifyListeners();
      // }
    });
  }
}
