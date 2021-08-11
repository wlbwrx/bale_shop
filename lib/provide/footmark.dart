import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:bale_shop/apiModel/footmark.dart';

class FootMarkProvide with ChangeNotifier {

  String footMarkString = "[]";
  List<FootMarkModel> footMarkList = [];
  save(id,date,img,price,originalPrice) async {
    //print('開始執行----footmark--------');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    footMarkString = prefs.getString('footMarkInfo');
    var temp = footMarkString == null ? [] : json.decode(footMarkString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
  tempList.forEach((item) {
      if (item['id'] == id &&
          (item['date']) == date) {
        isHave = true;
      }
    });
    if (!isHave) {
      Map<String, dynamic> newAddress = {
        "id": id,
        "date": date,
        "img": img,
        "price": price,
        "originalPrice": originalPrice,
      };
      tempList.add(newAddress);
      footMarkList.add(FootMarkModel.formJson(newAddress));
    }
    footMarkString = json.encode(tempList).toString();
    // print('字符串》》》》》》》${footMarkString}');
    // print('数据模型》》》》》》${footMarkList}');
    prefs.setString('footMarkInfo', footMarkString);
    notifyListeners();
  }




  getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('開始执行foot----------------------------');
   
    footMarkString = prefs.getString('footMarkInfo');
    footMarkList = [];
    if (footMarkString != null) {
      List<Map> tempList = (json.decode(footMarkString.toString()) as List).cast();
      for(var i=0;i<tempList.length;i++){
        var item = tempList[i];
        footMarkList.add(FootMarkModel.formJson(item));
      }
    }
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('footMarkInfo');
    footMarkList = [];
    print('清空完成----------------------------');
    notifyListeners();
  }
}
