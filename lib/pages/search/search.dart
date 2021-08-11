import 'package:flutter/material.dart';
import 'package:bale_shop/api/home.dart';
import 'dart:async';
import 'package:bale_shop/provide/search.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool showSearch = true; //是否显示搜索输入框
  var isShowClear = false; //是否显示输入框尾部的清除按钮
  FocusNode focusNodeSearch = new FocusNode();
  TextEditingController searchController = new TextEditingController();
  Duration durationTime = Duration(milliseconds: 200);
  Timer timer;
  String searchText = "";
  List hotWordList = [];
  List historyList = [];
  List searchList = [];
  @override
  void initState() {
    super.initState();
    //监听用户名框的输入改变
    hotWord().then((val) {
      setState(() {
        for (var i = 0; i < val.body.length; i++) {
          hotWordList.add(val.body[i]);
        }
      });
    });
    searchController.addListener(() {
      // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      if (searchController.text.length > 0) {
        isShowClear = true;
      } else {
        isShowClear = false;
      }
      setState(() {
        searchText = searchController.text;
      });
    });

    Future.delayed(Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(focusNodeSearch);
    });
  }

  @override
  void dispose() {
    // 移除焦点监听
    searchController.dispose();
    timer?.cancel();
    super.dispose();
  }

  List<Widget> box(data) => List.generate(data.length, (index) {
        return GestureDetector(
          onTap: () {
            searchController.text = data[index];
            Provide.value<SearchHistoryProvide>(context)
                .addHistory(data[index]);
            focusNodeSearch.unfocus();
            Navigator.of(context)
                .pushNamed("/searchDetail", arguments: {"text": data[index]});
          },
          child:  Container(
               padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
               margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
               decoration: BoxDecoration(
                 color: Color(0xFFF4F4F4),
                 borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              child: Text(
                   data[index],
                   style: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w400,
                     color: Color(0xFF777777)),
               ))
        );
      });

  List<Widget> box1(data) => List.generate(data.length, (index) {
        return GestureDetector(
          onTap: () {
            searchController.text = data[index].keyword;
            Provide.value<SearchHistoryProvide>(context)
                .addHistory(data[index].keyword);
            focusNodeSearch.unfocus();
            Navigator.of(context).pushNamed("/searchDetail",
                arguments: {"text": data[index].keyword});
          },
                    child: Container(
               padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
               margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
               decoration: BoxDecoration(
                 color: Color(0xFFF4F4F4),
                 borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              child: Text(
                   data[index].keyword,
                   style: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w400,
                     color: Color(0xFF777777)),
               )));
      });
  List<Widget> searchBox(data) => List.generate(data.length, (index) {
        return GestureDetector(
            onTap: () {
              searchController.text = data[index];
              Provide.value<SearchHistoryProvide>(context)
                .addHistory(data[index]);
              Navigator.of(context)
                  .pushNamed("/searchDetail", arguments: {"text": data[index]});
            },
            child: Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom:
                          BorderSide(width: 0.5, color: Colors.black12), //有边框
                    )),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        data[index],
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF777777)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                        height: 55,
                        alignment: Alignment.centerRight,
                        child: Image.asset("assets/icons/icon-back-right.png",
                            width: 6, height: 10, color: Color(0xFF777777)),
                      ),
                    )
                  ],
                )));
      });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double he = MediaQuery.of(context).size.height;
    final double jp = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(58.5),
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.black12), //有边框
              )),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
                    child: Row(),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(12, 19, 12, 19),
                            child: Image.asset(
                              'assets/icons/icon-back-light.png',
                              width: 15,
                              height: 15,
                              color: Colors.black,
                            ),
                          )),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showSearch = true;
                              });
                            },
                            child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                height: 58,
                                child: TextField(
                                  enableInteractiveSelection: false,
                                  focusNode: focusNodeSearch,
                                  controller: searchController,
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (data) {
                                     if(data.trim().length>0){
                                    Provide.value<SearchHistoryProvide>(
                                              context)
                                          .addHistory(data);
                                      Navigator.of(context).pushNamed(
                                          "/searchDetail",
                                          arguments: {"text": data});
                                }else{
                                    EasyLoading.showError("請輸入搜索內容");
                                }
                                   
                                  },
                                  onChanged: (text) {
                                    //内容改变的回调
                                    if (text.trim().length>0) {
                                      timer?.cancel();
                                      timer = new Timer(durationTime, () {
                                        //搜索函数
                                        searchWord(text).then((val) {
                                          if (searchText != "") {
                                            setState(() {
                                              searchList.clear();
                                              for (var i = 0;
                                                  i <
                                                      val.body.associateList
                                                          .length;
                                                  i++) {
                                                searchList.add(val.body
                                                    .associateList[i].name);
                                              }
                                            });
                                          }
                                        });
                                      });
                                    } else {
                                      timer?.cancel();
                                      setState(() {
                                        searchList.clear();
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFFF4F4F4),
                                    filled: true,
                                    hintText: "请輸入你想找的...",
                                    hintStyle:
                                        TextStyle(color: Color(0xFFBCBCBC)),
                                    contentPadding:
                                        new EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(21.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          color: Color(0xFFF4F4F4),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(21.0),
                                        borderSide: BorderSide(
                                          width: 0.5,
                                          color: Color(0xFFF4F4F4),
                                        )),

                                    //尾部添加清除按钮
                                    suffixIcon: (isShowClear)
                                        ? IconButton(
                                            icon: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Image.asset(
                                                'assets/icons/icon-del.png',
                                                width: 15,
                                                height: 15,
                                              ),
                                            ),
                                            onPressed: () {
                                              // 清空输入框内容
                                              searchController.clear();
                                              setState(() {
                                                searchList.clear();
                                              });
                                            },
                                          )
                                        : null,
                                  ),
                                ))),
                      ),
                      isShowClear
                          ? GestureDetector(
                              onTap: () {
                                if(searchText.trim().length>0){
                                   Provide.value<SearchHistoryProvide>(context)
                                    .addHistory(searchText);
                                    focusNodeSearch.unfocus();
                                    Navigator.of(context).pushNamed("/searchDetail",
                                    arguments: {"text": searchText});
                                }else{
                                    EasyLoading.showError("請輸入搜索內容");
                                }
                              },
                              child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                                  child: Text(
                                    "搜索",
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xFFED1B2E)),
                                  )))
                          : GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                                  child: Text(
                                    "取消",
                                    style: TextStyle(fontSize: 18),
                                  ))),
                    ],
                  )
                ],
              )),
        ),
        body: Listener(
            onPointerMove: (movePointEvent) {
              focusNodeSearch.unfocus();
            },
            child: GestureDetector(onTap: () {
              focusNodeSearch.unfocus();
            }, child: Provide<SearchHistoryProvide>(
                builder: (context, child, childCatgory) {
              Provide.value<SearchHistoryProvide>(context).getSearchHistory();
              String searchHistory =
                  Provide.value<SearchHistoryProvide>(context).searchHistory;
              List searchHistoryList = [];
              if (searchHistory != null) {
                searchHistoryList = searchHistory.split(",");
              }
              return Container(
                padding: EdgeInsets.fromLTRB(
                    searchList.length > 0 ? 0 : 12,
                    searchList.length > 0 ? 0 : 16,
                    searchList.length > 0 ? 0 : 12,
                    searchList.length > 0 ? 0 : 16),
                color: Colors.white,
                child: ListView(
                  children: searchList.length > 0
                      ? searchBox(searchList)
                      : [
                          searchHistoryList.length > 0
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                              child: Text(
                                        "搜索歷史",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w500),
                                      ))),
                                      GestureDetector(
                                          onTap: () {
                                            Provide.value<SearchHistoryProvide>(
                                                    context)
                                                .removeHistory();
                                          },
                                          child: Container(
                                            child: Image.asset(
                                                "assets/icons/icon-del1.png",
                                                width: 18,
                                                height: 18),
                                          ))
                                    ],
                                  ))
                              : Container(),
                          searchHistoryList.length > 0
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: Container(
                                      child: Wrap(
                                    spacing: 0, //主轴上子控件的间距
                                    runSpacing: 0, //交叉轴上子控件之间的间距
                                    children: box(searchHistoryList), //要显示的子控集合
                                  )))
                              : Container(),
                          hotWordList.length > 0
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, historyList.length > 0 ? 15 : 0, 0, 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "大家都在搜",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF222222),
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                  child: Wrap(
                                spacing: 0, //主轴上子控件的间距
                                runSpacing: 0, //交叉轴上子控件之间的间距
                                children: box1(hotWordList), //要显示的子控集合
                              ))),
                        ],
                ),
              );
            }))));
  }
}
