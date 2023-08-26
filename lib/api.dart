import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingapp/category.dart';
import 'package:shoppingapp/product_model.dart';

class API {
  static Future<List<Product>?> getProducts() async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));

    List<Map<String, dynamic>> jsonList = [];
    for (int i = 0; i < jsonDecode(response.body).length; i++) {
      jsonList.add(jsonDecode(response.body)[i]);
    }

    return Product.getProductList(jsonList);
  }

  static Future<List<Categories>?> getCategories() async {
    final cResponse = await http
        .get(Uri.parse("https://fakestoreapi.com/products/categories"));

    List<String> jsonCList = [];
    for (int i = 0; i < jsonDecode(cResponse.body).length; i++) {
      jsonCList.add(jsonDecode(cResponse.body)[i]);
    }
    return Categories.getCategoryList(jsonCList);
  }
}
