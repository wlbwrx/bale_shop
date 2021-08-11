import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryProvide with ChangeNotifier {
  String searchHistory;
  getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String historyString = prefs.getString('searchHistory');
    if (prefs.getString('searchHistory') != null) {
      searchHistory = historyString;
      notifyListeners();
    }
  }

  addHistory(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String historyString = prefs.getString('searchHistory');
    if (historyString != null) {
      List arr = historyString.split(',');
      bool lock = true;
      String text = "";
      for (var i = 0; i < arr.length; i++) {
        if (i < 10) {
          if (data == arr[i]) {
            lock = false;
            text = "${data},${text}";
            if (i == 0) {
              text = "${data}";
            }
          } else {
            text = "${text},${arr[i]}";
            if (i == 0) {
              text = "${arr[i]}";
            }
          }
        }
      }
      if (lock) {
        text = "${data},${text}";
      }
      prefs.setString('searchHistory', text);
    } else {
      print("第一次添加");
      prefs.setString('searchHistory', data);
    }

    getSearchHistory();
  }

  removeHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('searchHistory');
    searchHistory = null;
    print('清空完成----------------------------');
    notifyListeners();
  }
}
