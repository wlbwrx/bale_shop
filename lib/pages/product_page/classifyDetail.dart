import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:bale_shop/widgets/goods/GoodsMouldOne.dart';
import 'package:bale_shop/api/home.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bale_shop/apiModel/home_banner.dart';
import 'package:bale_shop/apiModel/classify.dart';
import 'dart:convert';

class ClassifyDetail extends StatefulWidget {
  ClassifyDetail({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _ClassifyDetailState createState() => _ClassifyDetailState();
}

class _ClassifyDetailState extends State<ClassifyDetail> {
  int _index = 0; //分类index
  int _index1 = 0; //排序index
  List type = []; //分类
  List type2 = ['综合排序', '价格升序', '价格降序'];
  String title = '';

  final List pageList = []; //商品列表
  Map arguments;
  ScrollController _controller = new ScrollController();
  ScrollController _controllerTop = new ScrollController();
  int height = 0; //当前高度
  int num = 2;
  double scrollIndex = 0;
  bool show = true;
  void initState() {
    arguments = widget.arguments;
    super.initState();
     _controllerTop.addListener((){});
    _controller.addListener(() {
      int isTop = _controller.offset.toInt();
      if (isTop >= 0) {
        if (num % 2 == 0) {
          if (isTop - height < 0) {
            setState(() {
              show = true;
            });
             if (_controllerTop.hasClients) {
                _controllerTop.animateTo(scrollIndex,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.ease);
            }
          }

          if (isTop - height > 0) {
            setState(() {
              show = false;
            });
          }
        }
        setState(() {
          num++;
          height = isTop;
        });
      }
    });
    getModel();
    getData(arguments["data"]);
  }

  Future<String> getModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String moderListString = prefs.getString('homeNavigation');
    if (moderListString != null) {
      final jsonResponse = json.decode(moderListString);
      home_banner model = home_banner.fromJson(jsonResponse);
      List arr = [];
      int checkIndex = arguments["checkIndex"];
      int isIndex = arguments["type"];
      int num = 0;
      int num1 = 0;
      for(var i =0;i<model.body.length;i++){
        if(model.body[i].isLeftNavigation){
          if(model.body[i].id == arguments["parentId"]){
              checkIndex = num;
          }
          arr.add(model.body[i]);
          num++;
        }
      }
      setState(() {
        for (var i = 0;i < arr[checkIndex].childrens.length; i++) {
          if (arr[checkIndex].childrens[i].isShow) {
            var body = arr[checkIndex].childrens[i];
            type.add(body);
            if(body.id == arguments["data"]){
               isIndex = num1;
            }
          }
          num1++;
        }
        _index = isIndex;
        title = arr[checkIndex].name;
      });
      loadJSDataModel().then((val) {});
    } else {
      loadJSDataModel().then((val) {
        List arr = [];
        for(var i =0;i<val.body.length;i++){
          if(val.body[i].isLeftNavigation){
            arr.add(val.body[i]);
          }
          
        }
        setState(() {
          for (var i = 0;
              i < arr[arguments["checkIndex"]].childrens.length;i++) {
            if (arr[arguments["checkIndex"]].childrens[i].isShow) {
              var body = arr[arguments["checkIndex"]].childrens[i];
              type.add(body);
            }
            _index = arguments["type"];
            title = arr[arguments["checkIndex"]].name;
          }
        });
      });
    }
    return 'end';
  }

  void getProduct(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('productSub${data}');
    if (jsonString != null) {
      final jsonResponse = json.decode(jsonString);
      classify model = classify.fromJson(jsonResponse);
      setState(() {
        for (var i = 0; i < model.body.length; i++) {
          pageList.add(model.body[i]);
        }
      });
      producSub(data).then((val) {});
    } else {
      producSub(data).then((val) {
        setState(() {
          for (var i = 0; i < val.body.length; i++) {
            pageList.add(val.body[i]);
          }
        });
      });
    }
  }

  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    _controllerTop.dispose();
    super.dispose();
  }

  getData(f) async {
    await Future.delayed(Duration(milliseconds: 50), () {
      getProduct(f);
    });
  }

  Widget renderType(String text, int index, int _index) {
    if (index != _index) {
      return Container(
        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: new Border.all(width: 0.5, color: Color(0xFFBCBCBC)),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF777777)),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFFFEF2F3),
          border: new Border.all(width: 0.5, color: Color(0xFFFEF2F3)),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFFED1B2E)),
        ),
      );
    }
  }

  Widget renderScreen() {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
            height: 40,
            color: Colors.white,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _controllerTop,
              itemCount: type.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {

                      setState(() {
                        pageList.clear();
                        _index = index;
                      });
                      String text = '';
                      if (_index1 == 1) {
                        text = '?name=minPrice&sort=asc';
                      }
                      if (_index1 == 2) {
                        text = '?name=minPrice&sort=desc';
                      }
                      getData('${type[index].id}' + text);
                      scrollIndex = _controllerTop.offset;
                    },
                    child: renderType(type[index].name, index, _index));
              },
            )),
        Container(
            padding: EdgeInsets.fromLTRB(10, 12, 10, 11),
            color: Colors.white,
            height: 50,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: type2.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        pageList.clear();
                        _index1 = index;
                      });
                      String text = '';
                      if (index == 1) {
                        text = '?name=minPrice&sort=asc';
                      }
                      if (index == 2) {
                        text = '?name=minPrice&sort=desc';
                      }
                      getData('${type[_index].id}' + text);
                    },
                    child: renderType(type2[index], index, _index1));
              },
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Image.asset(
                  'assets/icons/icon-back-light.png',
                  width: 20,
                  height: 20,
                  color: Colors.black,
                ),
              )),
          title: Text(
            "${title}",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Scrollbar(
          child: Stack(children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: show ? 90 : 0),
                color: Color(0xFFF4F4F4),
                child: pageList.length > 0
                    ? Container(
                        child: EasyRefresh.custom(
                          scrollController: _controller,
                          header: BallPulseHeader(color: Color(0xFF777777)),
                          footer: BallPulseFooter(color: Color(0xFF777777)),
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.all(8.0),
                              sliver: new SliverGrid(
                                //Grid
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, //Grid按两列显示
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 9,
                                  childAspectRatio: sizeHeight(size.height),
                                ),
                                delegate: new SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    //创建子widget
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed("/detail", arguments: {
                                            "id": pageList[index].id,
                                            "isIndex": 2
                                          });
                                        },
                                        child: GoodsMouldOne(
                                            data: [pageList[index]]));
                                  },
                                  childCount: pageList.length,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpinKitFadingCircle(
                            color: Colors.black26,
                            size: 25.0,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text("正在載入...."),
                          )
                        ],
                      )),
            show ? renderScreen() : Container(),
          ]),
        ));
  }
}
