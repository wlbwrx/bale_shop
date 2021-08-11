import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/api/home.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:url_launcher/url_launcher.dart';

class AfterSalesList extends StatefulWidget {
  AfterSalesList({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _AfterSalesListState createState() => _AfterSalesListState();
}

class _AfterSalesListState extends State<AfterSalesList> {
  bool dataLock = true;
  bool dataLast = true;
  List dataList = [];
  int pageIndex = 0;
  Map arguments;
  void initState() {
    arguments = widget.arguments;
    if (arguments["id"] != null) {
      saleserviceOrderList(arguments["id"]).then((val) {
        setState(() {
          for (var i = 0; i < val.body.length; i++) {
            dataList.add(val.body[i]);
          }
          dataLast = true;
          dataLock = true;
        });
      });
    } else {
      saleserviceList(0).then((val) {
        setState(() {
          for (var i = 0; i < val.body.content.length; i++) {
            dataList.add(val.body.content[i]);
          }
          pageIndex++;
          dataLast = val.body.last;
          dataLock = true;
        });
      });
    }

    super.initState();
  }

  void _fb() async {
    String url = "https://m.facebook.com/messages/thread/963546037190008";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('不能访问');
    }
  }

  handleStatus(status) {
    if (status == 10) {
      return ["審核中", 0xFFFF9300];
    }
    if (status == -20) {
      return ["已撤銷", 0xFFBCBCBC];
    }
    if (status == 20) {
      return ["成功", 0xFF3DAB2D];
    }
    if (status == -10) {
      return ["失敗", 0xFFF12C20];
    }
  }

  Widget noOrder(context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Image.asset(
              "assets/images/null-order.png",
              width: 100,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Text(
              "您尚未進行過售後操作喔",
              style: TextStyle(fontSize: 14, color: Color(0xFF777777)),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> renderList(data) {
    List<Widget> imgList = [];

    for (var i = 0; i < data.length; i++) {
      imgList.add(Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 5),
            width: 90,
            height: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  'assets/icons/placeholder.png',
                  fit: BoxFit.cover,
                ),
                imageUrl: "http:" + data[i].sourceProductSkuImage,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/icons/placeholder.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          data[i].quantity != 1
              ? Positioned(
                  top: 60,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                    decoration: BoxDecoration(
                      color: Color(0x80000000),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      "${data[i].quantity}件",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                )
              : Container()
        ],
      ));
    }

    return imgList;
  }

  Widget orderList(context, data) {
    return Container(
      color: Color(0xFFF4F4F4),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed("/afterSales", arguments: {
                        "id": data.id,
                      });
                    },
                    child: Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(12, 16, 0, 0),
                                    child: Row(children: [
                                      Text(
                                        "訂單號：${data.deliveryCode}",
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      data.serviceType == 20
                                          ? Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  6, 4, 6, 4),
                                              margin: EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF22AB39),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6))),
                                              child: Text(
                                                "換貨",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    height: 1),
                                              ))
                                          : Container(),
                                      data.serviceType == 10
                                          ? Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  6, 4, 6, 4),
                                              margin: EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFF12C20),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6))),
                                              child: Text(
                                                "退貨退款",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    height: 1),
                                              ))
                                          : Container(),
                                    ])),
                                Container(
                                  padding: EdgeInsets.fromLTRB(12, 8, 0, 0),
                                  child: Text(
                                    "申請時間：${data.createdAt.substring(0, 19)}",
                                    style: TextStyle(
                                        color: Color(0xFF777777),
                                        fontSize: 13,
                                        height: 1),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    color: Colors.white,
                                    child: Text(
                                        handleStatus(data.handleStatus)[0],
                                        style: TextStyle(
                                            color: Color(handleStatus(
                                                data.handleStatus)[1]),
                                            fontSize: 13,
                                            height: 1))),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  padding: EdgeInsets.fromLTRB(4, 0, 12, 0),
                                  color: Colors.white,
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    "assets/icons/icon-back-right.png",
                                    width: 6,
                                    height: 10,
                                    color: Color(0xFF777777),
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ))),
                Container(
                  height: 0.5,
                  color: Color(0xFFEDEDED),
                  margin: EdgeInsets.fromLTRB(12, 10.5, 12, 0),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: new ListView(
                    scrollDirection: Axis.horizontal,
                    children: renderList(data.afterSaleServiceProducts),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget order(context, data, lock, last) {
    return lock
        ? data.length > 0
            ? EasyRefresh.custom(
                header: BallPulseHeader(color: Color(0xFF777777)),
                footer: BallPulseFooter(color: Color(0xFF777777)),
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1), () {
                    if (mounted) {
                      setState(() {
                        dataList.clear();
                        dataLock = false;
                      });
                      if (arguments["id"] != null) {
                        saleserviceOrderList(arguments["id"]).then((val) {
                          setState(() {
                            for (var i = 0; i < val.body.length; i++) {
                              dataList.add(val.body[i]);
                            }
                            dataLast = true;
                            dataLock = true;
                          });
                        });
                      } else {
                        saleserviceList(0).then((val) {
                          setState(() {
                            for (var i = 0; i < val.body.content.length; i++) {
                              dataList.add(val.body.content[i]);
                            }
                            pageIndex++;
                            dataLast = val.body.last;
                            dataLock = true;
                          });
                        });
                      }
                    }
                  });
                },
                onLoad: !last
                    ? () async {
                        await Future.delayed(Duration(seconds: 1), () {
                          if (mounted) {
                            saleserviceList(pageIndex).then((val) {
                              setState(() {
                                for (var i = 0;
                                    i < val.body.content.length;
                                    i++) {
                                  dataList.add(val.body.content[i]);
                                }
                                pageIndex++;
                                dataLast = val.body.last;
                              });
                            });
                          }
                        });
                      }
                    : null,
                slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return orderList(context, data[index]);
                        },
                        childCount: data.length,
                      ),
                    ),
                  ])
            : noOrder(context)
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
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            '退換/售後',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  _fb();
                },
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Image.asset(
                    'assets/icons/customer-service.png',
                    width: 24,
                    height: 24,
                  ),
                )),
          ],
        ),
        body: order(context, dataList, dataLock, dataLast));
  }
}
