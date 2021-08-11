import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currentIndex = 0;
  int catNum = 0;

  changeIndex(int newIndex){
    currentIndex = newIndex;
    notifyListeners();
  }

  changeCatNum(int newIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    catNum = newIndex;
    prefs.setInt('catNum',newIndex);
    notifyListeners();
  }

  getCatNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getInt('catNum')!=null){
      catNum = prefs.getInt('catNum');
    }
     notifyListeners();
  }
}