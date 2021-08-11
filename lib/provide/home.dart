import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:bale_shop/apiModel/home_banner.dart';

class HomeProvide with ChangeNotifier {
  //String navigationString = "[]";
  List navigationList = [];
  getNavigationList() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String navigationString = prefs.getString('homeNavigation');
     if (navigationString != null) {
       final jsonResponse = json.decode(navigationString);
       home_banner model = home_banner.fromJson(jsonResponse);
       model.body.forEach((item) {
        navigationList.add(item);
      });
    }
    notifyListeners();
  }
}
