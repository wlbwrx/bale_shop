import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:bale_shop/widgets/goods/GoodsMouldOne.dart';
import 'package:bale_shop/api/home.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bale_shop/apiModel/home_model.dart';
import 'package:bale_shop/apiModel/product_list.dart';
import 'dart:convert';
import 'package:facebook_app_events/facebook_app_events.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, this.data, this.list, this.subId}) : super(key: key);
  final int data;
  final List list;
  final int subId;
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ///see AutomaticKeepAliveClientMixin

  int _index = -1;
  int modelIndex = 1;

  int data;
  int index = 1;
  List list = [];
  final List modelList = [];
  final List pageList = [];
  ScrollController _controller = new ScrollController();
  ScrollController _controllerTop = new ScrollController();
  static final facebookAppEvents = FacebookAppEvents();
  double scrollIndex = 0;
  int height = 0; //当前高度
  int num = 2;
  bool show = true;
  bool isShow = false;
  bool noData = false;
  @override
  void initState() {
    data = widget.data;
    var _subIndex = 0;
    for (var i = 0; i < widget.list.length; i++) {
      if (widget.list[i].isShow) {
        isShow = true;
        list.add(widget.list[i]);
        if (widget.list[i].id == widget.subId) {
          _subIndex = i;
        }
      }
    }

    super.initState();
    //组装本地数据
    // getAllData(data);
    // getAllModel(data);
    // for (var i = 0; i < list.length; i++) {
    //   getAllModel(list[i].id);
    // }

    //添加监听
    _controllerTop.addListener(() {});
    _controller.addListener(() {
      int isTop = _controller.offset.toInt();
      if (isTop >= 0 && isShow) {
        if (num % 2 == 0) {
          if (isTop - height < 0) {
            setState(() {
              show = true;
            });
            if (_controllerTop.hasClients) {
              _controllerTop.animateTo(scrollIndex,
                  duration: Duration(milliseconds: 100), curve: Curves.ease);
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

    if (widget.subId == 0) {
      facebookAppEvents.logEvent(
          name: "fb_mobile_content_view",
          parameters: {"fb_content_type": '首页', "fb_content_id": '${data}'});
      getCache(data, "int", _index);
    } else {
      facebookAppEvents.logEvent(name: "fb_mobile_content_view", parameters: {
        "fb_content_type": 'home',
        "fb_content_id": '${widget.subId}'
      });
      getCache(widget.subId, "index", _subIndex);
    }

    Future.delayed(Duration(milliseconds: 500), () {
      getModel(widget.subId == 0 ? data : widget.subId);
    });
  }

  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    _controllerTop.dispose();
    super.dispose();
  }

  getCache(f, type, index) async {
    setState(() {
      modelList.clear();
      pageList.clear();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
      String moderListString = prefs.getString('model${f}');
      if (moderListString != null) {
        final jsonResponse = json.decode(moderListString);
        home_model model = home_model.fromJson(jsonResponse);
        for (var i = 0; i < model.body.length; i++) {
          setState(() {
            modelList.add(model.body[i]);
          });
          if (i == 0) {
            String productListString = prefs.getString('product${model.body[0].aggregateModuleId}');
            if (productListString != null) {
              //更新存储
              final productResponse = json.decode(productListString);
              product_list productModel =
                  product_list.fromJson(productResponse);
              if (productModel.body.length > 0) {
                setState(() {
                  for (var x = 0;
                      x < productModel.body[0].products.length;
                      x++) {
                    pageList.add(productModel.body[0].products[x]);
                  }
                });
              }
            }
          }
        }
      }
    
    if (type == "index") {
      setState(() {
        _index = index;
        scrollIndex = _controllerTop.offset;
      });
    }
  }

  getModel(data) {
   
    moduleIdsInfo(data).then((val) {
      setState(() {
        index=1;
        modelList.clear();
      });
      Future.delayed(Duration(milliseconds: 20), () {
        for (var i = 0; i < val.body.length; i++) {
          setState(() {
            modelList.add(val.body[i]);
          });
        }
        if(val.body.length>0){
           getProduct(val.body[0].aggregateModuleId);
        }else{
            setState(() {
            pageList.clear();
        });
        }
       
      });
    });
  }

  getProduct(data) {
    productList(data).then((val) {
      var list = val.body;
      setState(() {
        pageList.clear();
      });
      Future.delayed(Duration(milliseconds: 20), () {
        if (val.body[0] != null) {
          setState(() {
            for (var x = 0; x < list[0].products.length; x++) {
              pageList.add(list[0].products[x]);
            }
          });
        } else {
          setState(() {
            noData = true;
          });
        }
      });
    });
  }

  getDataNext() {
    if (index < modelList.length) {
      productList(modelList[index].aggregateModuleId).then((onVal) {
        var list = onVal.body;
        setState(() {
          for (var x = 0; x < list[0].products.length; x++) {
            pageList.add(list[0].products[x]);
          }
          index++;
        });
      });
    }
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

  Widget renderBanner() {
    return Column(
      children: <Widget>[
        Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 12, 10, 11),
            height: 50,
            child: new ListView.builder(
              controller: _controllerTop,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      if (_index != index) {
                        getModel(list[index].id);
                        setState(() {
                          _index = index;
                          scrollIndex = _controllerTop.offset;
                        });
                      }
                    },
                    child: renderType(list[index].name, index, _index));
              },
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        color: Color(0xFFF4F4F4),
        child: Scrollbar(
            child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: show && isShow ? 50 : 0),
                child: pageList.length > 0 || noData
                    ? Container(
                        child: EasyRefresh.custom(
                        scrollController: _controller,
                        header: BallPulseHeader(color: Color(0xFF777777)),
                        footer: BallPulseFooter(color: Color(0xFF777777)),
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                              pageList.clear();
                              modelList.clear();
                            });
                            getModel(_index >= 0 ? list[_index].id : data);
                          });
                        },
                        onLoad: index == modelList.length
                            ? null
                            : () async {
                                if (modelList.length > 0) {
                                  await Future.delayed(Duration(seconds: 1),
                                      () {
                                    getDataNext();
                                  });
                                }
                              },
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(9.0),
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
                                      Navigator.of(context).pushNamed("/detail",
                                          arguments: {
                                            "id": pageList[index].id
                                          });
                                    },
                                    child:
                                        GoodsMouldOne(data: [pageList[index]]));
                              }, childCount: pageList.length),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: index == modelList.length
                                ? Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    height: 40,
                                    child: Text(
                                      "沒有更多數據了",
                                      style:
                                          TextStyle(color: Color(0xFF777777)),
                                    ),
                                  )
                                : Container(),
                          )
                        ],
                      ))
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
            show && isShow ? renderBanner() : Container(),
          ],
        )));
  }
}
