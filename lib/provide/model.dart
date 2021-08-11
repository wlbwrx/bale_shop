import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:bale_shop/apiModel/home_model.dart';
class ModelProvide with ChangeNotifier {
  var data = {};
  getModelList(id) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String moderListString = prefs.getString('model${id}');
     if (moderListString != null) {
       List moderList = [];
       final jsonResponse = json.decode(moderListString);
       home_model model = home_model.fromJson(jsonResponse);
       model.body.forEach((item) {
         moderList.add(item);
      });
      data['${id}'] = moderList;
    }
    notifyListeners();
  }
}
