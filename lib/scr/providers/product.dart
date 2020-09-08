import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_app/scr/models/product_response.dart';
import '../helpers/product.dart';
import '../models/products.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> allproducts = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productsSearched = [];

  ProductResponse response;

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() {
    _productServices.getProducts().then((resp) {
      response = resp;
      products = resp.data;
      notifyListeners();
    });
  }

  loadAllProducts() {
    _productServices.getProducts().then((resp) {
      response = resp;
      products = resp.data;
      notifyListeners();
    });
  }

  loadProductsByCategory({String categoryName}) {
    print('object ............');
    print(categoryName);
    _productServices
        .getProductsOfCategory(category: categoryName)
        .then((onValue) {
      if (onValue.code == 200) {
        productsByCategory = onValue.data;
      }
      response = onValue;
      notifyListeners();
    });
  }

  loadProductsByRestaurant({String restaurantId, String userId}) {
    _productServices
        .getProductsByRestaurant(id: restaurantId, uid: userId)
        .then((onValue) {
      if (onValue.code == 200) {
        productsByRestaurant = onValue.data;
      }
      response = onValue;
      notifyListeners();
    });
  }

  Future<bool> updateRate({String prodId, String userId, int rate}) async {
    var b =
        await _productServices.updateRate(id: prodId, uid: userId, rate: rate);
    return b.code == 200;
  }
//  likeDislikeProduct({String userId, ProductModel product, bool liked})async{
//    if(liked){
//      if(product.userLikes.remove(userId)){
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//      }else{
//        print("THE USER WA NOT REMOVED");
//      }
//    }else{
//
//      product.userLikes.add(userId);
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//
//
//      }
//  }

  search({String productName}) {
    productsSearched =
        _productServices.searchProducts(productName: productName);
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");
    print("THE NUMBER OF PRODUCTS DETECTED IS: ${productsSearched.length}");

    notifyListeners();
  }
}
