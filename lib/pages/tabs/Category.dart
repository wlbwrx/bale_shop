import 'package:flutter/material.dart';
import 'package:bale_shop/api/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/home.dart';
import 'package:bale_shop/provide/currentIndex.dart';
import 'package:bale_shop/pages/tabs.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List dataList = [];

  int checkIndex = 1;
  var lockObj = {};
  @override
  void initState() {
    super.initState();
    //初始化时即进行数据请求
    loadJSDataModel().then((val) {
      setState(() {
        for (var i = 0; i < val.body.length; i++) {
          dataList.add(val.body[i]);
        }
      });
    });
  }

  Widget _leftInkWell(int index, list) {
    if (checkIndex == index) {
      return InkWell(
          child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(
              list[index].name,
              style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFED1B2E),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Positioned(
            left: 0,
            top: 18,
            child: Container(
              height: 20,
              width: 4,
              decoration: BoxDecoration(color: Color(0xFFED1B2E)),
            ),
          ),
        ],
      ));
    } else {
      return InkWell(
        onTap: () {
          var lock = false;
          for (var x = 0; x < list[index].childrens.length; x++) {
            if (list[index].childrens[x].isShow) {
              lock = true;
            }
          }
          if (lock) {
            setState(() {
              this.checkIndex = index;
            });
          } else {
            Provide.value<CurrentIndexProvide>(context).changeIndex(0);
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color: Color(0xFFF4F4F4), border: Border()),
          child: Text(
            list[index].name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
      );
    }
  }

  Future<String> _getNavInfo(BuildContext context) async {
    await Provide.value<HomeProvide>(context).getNavigationList();
    return 'end';
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(58.5),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/search");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom:
                          BorderSide(width: 0.5, color: Colors.black12), //有边框
                    )),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
                    child: Row(),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.all(Radius.circular(21)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: Image.asset(
                              "assets/icons/search.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          Text(
                            "搜索",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFFBCBCBC)),
                          )
                        ],
                      ),
                    ),
                  ),
                ])),
          ),
        ),
        body: FutureBuilder(
            future: _getNavInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provide<HomeProvide>(
                    builder: (context, child, childCatgory) {
                  List navigationList = dataList.length > 0
                      ? dataList
                      : Provide.value<HomeProvide>(context).navigationList;
                  List list = [];
                  List cList = [];
                  for (var i = 0; i < navigationList.length; i++) {
                    var data = navigationList[i];
                    var arr = [];
                    for (var x = 0; x < data.childrens.length; x++) {
                      if (data.childrens[x].isShow) {
                        arr.add(data.childrens[x]);
                      }
                    }
                    if (data.isLeftNavigation) {
                      list.add(data);
                      cList.add(arr);
                    }
                  }
                  return Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F4F4),
                            // border: Border(
                            //   right: BorderSide(width: 1.0, color: Colors.black12), //有边框
                            // )
                          ),
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (contex, index) {
                              return _leftInkWell(index, list);
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                            child: GridView.builder(
                              itemCount: list.length > 0
                                  ? cList[checkIndex].length
                                  : 0,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, //横轴三个子widget
                                      childAspectRatio: 0.85),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed("/classify", arguments: {
                                        "data": cList[checkIndex][index].id,
                                        "type": index,
                                        "checkIndex": checkIndex
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Column(
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/icons/placeholder.png',
                                              fit: BoxFit.cover,
                                            ),
                                            imageUrl: cList[checkIndex][index]
                                                        .thumb !=
                                                    null
                                                ? "http:" +
                                                    cList[checkIndex][index]
                                                        .thumb
                                                : 'assets/icons/placeholder.png',
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/icons/placeholder.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(cList[checkIndex][index].name,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400))
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              } else {
                return Container();
              }
            }));
  }
}
