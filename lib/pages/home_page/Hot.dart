import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:bale_shop/widgets/goods/GoodsMouldOne.dart';
import 'package:bale_shop/api/home.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bale_shop/apiModel/home_model.dart';
import 'package:bale_shop/apiModel/product_list.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
class HotPage extends StatefulWidget {
  HotPage({Key key, this.data, this.editFunction}) : super(key: key);
  final int data;
  final editFunction;
  @override
  _HotPageState createState() => _HotPageState();
}

class _HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int data;
  int index = 2;
  List modelList = [];
  List bannerList = [];
  List bannerListAct = [];
  List pageList = [];
  String digest1 = "";
  String digest2 = "";
  String digest3 = "";
  String digest4 = "";
  static final facebookAppEvents = FacebookAppEvents();
  StreamSubscription _sub;
  @override
  void initState() {
    data = widget.data;
    super.initState();
    getModel(data);
    Future.delayed(Duration(milliseconds: 500), () {
      getData(1);
      facebookAppEvents.logEvent(
       name:"fb_mobile_content_view",
       parameters: {
         "fb_content_type":'首页',
         "fb_content_id":'${data}'
       }
    );
    print("发起一次监听");
    });
    initUniLinks();
  }

   Future<Null> initUniLinks() async {
    // ... check initialLink

    // Attach a listener to the stream
    _sub = getLinksStream().listen((String link) {
      // Parse the link and warn the user, if it is not correct
      Uri u = Uri.parse(link);
      String detail = u.queryParameters['detail'];
      String home = u.queryParameters['home'];
       Future.delayed(Duration(milliseconds: 2000), (){
        if(detail!=null){
          Navigator.of(context).pushNamed("/detail", arguments: {"id":detail});
          return false;
        }
        if(home!=null){
          setState(() {
            widget.editFunction(home); // 调用父级组件方法
          });
        }
      });
    
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }


  void _url(data) async {
    String url = data;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('不能访问');
    }
  }

  Future<String> getModel(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String moderListString = prefs.getString('model${data}');
    if (moderListString != null) {
      final jsonResponse = json.decode(moderListString);
      home_model model = home_model.fromJson(jsonResponse);
      getBanner(model.body[0].aggregateModuleId);
      getProduct(model.body);
      for (var i = 0; i < model.body.length; i++) {
        setState(() {
          modelList.add(model.body[i]);
        });
      }
      if (model.headers.digest != null) {
        setState(() {
          digest1 = model.headers.digest[0];
        });
      }
    }
    return 'end';
  }

  Future<String> getProduct(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('product${data[0].aggregateModuleId}');
    if (jsonString != null) {
      final jsonResponse = json.decode(jsonString);
      product_list model = product_list.fromJson(jsonResponse);
      if (model.body[0].products.length > 0) {
        setState(() {
          for (var i = 0; i < model.body[0].products.length; i++) {
            pageList.add(model.body[0].products[i]);
          }
          if (model.headers.digest != null) {
            setState(() {
              digest2 = model.headers.digest[0];
            });
          }
        });
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String jsonString =
            prefs.getString('product${data[1].aggregateModuleId}');
        print(data[1].aggregateModuleId);
        print("-------------");
        if (jsonString != null) {
          final jsonResponse = json.decode(jsonString);
          product_list model = product_list.fromJson(jsonResponse);
          setState(() {
            for (var i = 0; i < model.body[0].products.length; i++) {
              pageList.add(model.body[0].products[i]);
            }
            if (model.headers.digest != null) {
              setState(() {
                digest4 = model.headers.digest[0];
              });
            }
          });
        }
      }
      return 'end';
    }
  }

  Future<String> getBanner(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('product${data}');

    if (jsonString != null) {
      final jsonResponse = json.decode(jsonString);
      product_list model = product_list.fromJson(jsonResponse);
      setState(() {
        for (var x = 0; x < model.body[0].banners.length; x++) {
          bannerList.add(model.body[0].banners[x].imageUrl);
          if (model.body[0].banners[x].appLocationUrl != null) {
            bannerListAct.add(model.body[0].banners[x].appLocationUrl);
          } else {
            bannerListAct.add(0);
          }
        }
      });
      if (model.headers.digest != null) {
        setState(() {
          digest3 = model.headers.digest[0];
        });
      }
    }
    return 'end';
  }

  getData(type) {
    moduleIdsInfo(data).then((val) {
      if (val.headers.digest[0] != digest1) {
          setState(() {
            modelList.clear();
            digest1 = val.headers.digest[0];
          });
          Future.delayed(Duration(milliseconds: 20), () {
            for (var i = 0; i < val.body.length; i++) {
              setState(() {
                modelList.add(val.body[i]);
              });
            }
          });
        }
        productList(val.body[0].aggregateModuleId).then((onVal) {
          var list = onVal.body;
          if (onVal.headers.digest[0] != digest3) {
            setState(() {
              bannerList.clear();
              bannerListAct.clear();
              digest3 = onVal.headers.digest[0];
              if (list[0].products.length > 0) {
                pageList.clear();
              }
            });
            Future.delayed(Duration(milliseconds: 20), () {
              for (var x = 0; x < list[0].banners.length; x++) {
                setState(() {
                  bannerList.add(list[0].banners[x].imageUrl);
                  if (list[0].banners[x].appLocationUrl != null) {
                    bannerListAct.add(list[0].banners[x].appLocationUrl);
                  } else {
                    bannerListAct.add(0);
                  }
                });
              }
              if (onVal.headers.digest[0] != digest2 &&
                  list[0].products.length > 0) {
                for (var x = 0; x < list[0].products.length; x++) {
                  setState(() {
                    digest2 = onVal.headers.digest[0];
                    pageList.add(list[0].products[x]);
                  });
                }
              }
            });
          }
          if (list[0].products.length < 6 && val.body.length >= 2) {
            productList(val.body[1].aggregateModuleId).then((onVal1) {
              var listTwo = onVal1.body;
              print(onVal1.headers.digest[0]);
              print(digest4);

              if (onVal1.headers.digest[0] != digest4) {
                index = 2;
                setState(() {
                  digest4 = onVal1.headers.digest[0];
                  if (list[0].products.length == 0) {
                    pageList.clear();
                  }
                });
                Future.delayed(Duration(milliseconds: 5), () {
                  for (var y = 0; y < listTwo[0].products.length; y++) {
                    setState(() {
                      pageList.add(listTwo[0].products[y]);
                    });
                  }
                });
              }
            });
          }
        });
    
    });
  }

  getData1() {
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

  Widget renderBanner() {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Container(
              child: AspectRatio(
                  aspectRatio: 15 / 7,
                  child: bannerList.length > 0
                      ? Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return CachedNetworkImage(
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                'assets/icons/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                              imageUrl: "http:${bannerList[index]}",
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/icons/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          onTap: (int index) {
                            var url = bannerListAct[index];

                            if (url != 0) {
                              List data = url.split('@');
                              String type = data[0];
                              String text = data[1];
                              if (type == "1") {
                                setState(() {
                                  widget.editFunction(text); // 调用父级组件方法
                                });
                              }
                              if (type == "2") {
                                Navigator.of(context).pushNamed("/detail",arguments: {"id": text});
                              }
                              if (type == "3") {
                                _url(text);
                              }
                            }
                          },
                          itemCount: bannerList.length,
                          pagination: new SwiperPagination(
                              margin: EdgeInsets.only(bottom: 4),
                              builder: DotSwiperPaginationBuilder(
                                color: Color(0x40000000),
                                activeColor: Color(0xFFED1B2E),
                              )),
                          autoplay: true)
                      : Text(''))),
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 4),
                          child: Image.asset(
                            "assets/icons/icon-check-circle.png",
                            width: 12,
                            height: 12,
                          ),
                        ),
                        Text("全站滿\$699免運",
                            style: TextStyle(
                                color: Color(0xFF222222), fontSize: 12))
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 4),
                          child: Image.asset(
                            "assets/icons/icon-check-circle.png",
                            width: 12,
                            height: 12,
                          ),
                        ),
                        Text("支持貨到付款",
                            style: TextStyle(
                                color: Color(0xFF222222), fontSize: 12))
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 4),
                          child: Image.asset(
                            "assets/icons/icon-check-circle.png",
                            width: 12,
                            height: 12,
                          ),
                        ),
                        Text("7天無憂退換貨",
                            style: TextStyle(
                                color: Color(0xFF222222), fontSize: 12))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderList(data, size) {
    return EasyRefresh.custom(
      header: BallPulseHeader(color: Color(0xFF777777)),
      footer: BallPulseFooter(color: Color(0xFF777777)),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1), () {
          getData(2);
        });
      },
      onLoad: index == modelList.length
          ? null
          : () async {
              print(modelList.length);
              if (modelList.length > 0) {
                await Future.delayed(Duration(seconds: 1), () {
                  getData1();
                });
              }
            },
      slivers: <Widget>[
        (bannerList.length > 0)
            ? renderBanner()
            : SliverToBoxAdapter(child: Container()),
        SliverPadding(
          padding: const EdgeInsets.all(9.0),
          sliver: new SliverGrid(
            //Grid
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
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
                        arguments: {"id": data[index].id});
                  },
                  child: GoodsMouldOne(data: [data[index]]));
            }, childCount: data.length),
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
                    style: TextStyle(color: Color(0xFF777777)),
                  ),
                )
              : Container(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        color: Color(0xFFF4F4F4),
        child: pageList.length > 0
            ? renderList(pageList, size)
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
              ));
  }
}
