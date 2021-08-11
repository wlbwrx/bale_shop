import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:bale_shop/apiModel/product_list.dart';
class ProductProvide with ChangeNotifier {
  List productList = [];
  getProductList(id) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String productString = prefs.getString('product${id}');
     if (productString != null) {
       final jsonResponse = json.decode(productString);
       product_list model = product_list.fromJson(jsonResponse);
       model.body.forEach((item) {
        productList.add(item);
      });
    }
    notifyListeners();
  }
}
