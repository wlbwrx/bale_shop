import 'package:bale_shop/apiModel/address.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddressProvide with ChangeNotifier {

  String addressString = "[]";
  List<AddressInfoModel> addressList = [];
  save(name, phone, city, district,address) async {
    remove();
    print('開始執行address----------------------------');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addressString = prefs.getString('addressInfo');
    var temp =
        addressString == null ? [] : json.decode(addressString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      ival++;
    });
    if (!isHave) {
      Map<String, dynamic> newAddress = {
        "id": ival,
        "name": name,
        "phone": phone,
        "city": city,
        "address": address,
        "district":district
      };
      tempList.add(newAddress);
      addressList.add(AddressInfoModel.formJson(newAddress));
    }
    addressString = json.encode(tempList).toString();
    // print('字符串》》》》》》》${addressString}');
    // print('数据模型》》》》》》${addressList}');
    prefs.setString('addressInfo', addressString);
    notifyListeners();
  }




  getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print('開始执行address----------------------------'); 
    addressString = prefs.getString('addressInfo');
    addressList = [];
    if (addressString != null) {
      List<Map> tempList = (json.decode(addressString.toString()) as List).cast();

      tempList.forEach((item) {
        addressList.add(AddressInfoModel.formJson(item));
      });
    }
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('addressInfo');
    addressList = [];
    print('清空完成----------------------------');
    notifyListeners();
  }
}
