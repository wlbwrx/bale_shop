import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvide with ChangeNotifier {
  String dataTel= "";
  String dataPhoto = "";
  String dataNickname = "";
  save(id,scopeId,tel,token,nickname,photo) async {
    print('開始執行----------------------------');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', id);
    prefs.setInt('scopeId', scopeId);
    prefs.setString('tel', tel);
    prefs.setString('token', token);
    prefs.setString('photo', photo);
    prefs.setString('nickname', nickname);
    
  
    prefs.setString('tokenTime', "${new DateTime.now()}");
    dataTel = tel;
    dataPhoto = photo;
    dataNickname = nickname;
    
    print('执行完成-----------');
    notifyListeners();
  }

  changeUser(id,scopeId,tel,nickname,photo ) async {
    print('開始執行----------------------------');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', id);
    prefs.setInt('scopeId', scopeId);
    prefs.setString('tel', tel);
    prefs.setString('photo', photo);
    prefs.setString('nickname', nickname);
    dataTel = tel;
    dataPhoto = photo;
    dataNickname = nickname;
    print('执行完成-----------');
    notifyListeners();
  }

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("我getdata了");
    dataTel = "";
    dataPhoto = "";
    dataNickname = "";
    dataTel = prefs.getString("tel");
    dataPhoto = prefs.getString("photo");
    dataNickname = prefs.getString("nickname");
    notifyListeners();
  }

  changePhoto(photo)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('photo', photo);
    dataPhoto = photo;
    notifyListeners();
  }

  removeUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataTel = "";
    dataPhoto = "";
    dataNickname= "";
    prefs.remove('phone');
    prefs.remove('scopeId');
    prefs.remove('tel');
    prefs.remove('token');
    prefs.remove('photo');
    prefs.remove('nickname');
    print('清空完成----------------------------');
    notifyListeners();
  }
}