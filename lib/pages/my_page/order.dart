import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'dart:io';
import 'package:bale_shop/provide/currentIndex.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/api/home.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:bale_shop/widgets/cart/toast.dart';
import 'package:bale_shop/widgets/loadingDialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:bale_shop/pages/tabs.dart';
import 'package:bale_shop/provide/cart.dart';
import 'package:bale_shop/provide/footmark.dart';
class Order extends StatefulWidget {
  Order({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Map arguments;
  List dataList = [];
  List dataList1 = [];
  List dataList2 = [];
  List dataList3 = [];
  bool check = true;

  bool data1 = false;
  bool data2 = false;
  bool data3 = false;
  bool data4 = false;

  int index1 = 1;
  int index2 = 1;
  int index3 = 1;
  int index4 = 1;

  bool last1 = true;
  bool last2 = true;
  bool last3 = true;
  bool last4 = true;
  var detail;

  List causeText = ["尺碼/顏色/數量選錯了", "地址填寫錯誤", "價格有點貴", "訂購重複了", "不想要了", "其他"];
  int checkCause = 0;

  void initState() {
    arguments = widget.arguments;
    super.initState();
    getData();
  }

  getData() {
    getOrderList(0, 0).then((val) {
      setState(() {
        data1 = true;
        last1 = val.body.last;
        for (var i = 0; i < val.body.content.length; i++) {
          dataList.add(val.body.content[i]);
        }
      });
    });
    getOrderList(1, 0).then((val) {
      setState(() {
        data2 = true;
        last2 = val.body.last;
        for (var i = 0; i < val.body.content.length; i++) {
          dataList1.add(val.body.content[i]);
        }
      });
    });
    getOrderList(2, 0).then((val) {
      setState(() {
        data3 = true;
        last3 = val.body.last;
        for (var i = 0; i < val.body.content.length; i++) {
          dataList2.add(val.body.content[i]);
        }
      });
    });
    getOrderList(3, 0).then((val) {
      setState(() {
        data4 = true;
        last4 = val.body.last;
        for (var i = 0; i < val.body.content.length; i++) {
          dataList3.add(val.body.content[i]);
        }
      });
    });
  }

  void _fb() async {
    String url = "https://m.facebook.com/messages/thread/963546037190008";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('不能访问');
    }
  }

  List<Widget> renderGoodsTwo(data) {
    List<Widget> goods = [];

    if (data.skuInfos != null) {
      for (var i = 0; i < data.skuInfos.length; i++) {
        goods.add(Container(
          margin: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 12),
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                    imageUrl: "http:" + data.skuInfos[i].productImageUrl,
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/icons/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                data.skuInfos[i].productTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 12,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            )),
                            Container(
                              padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF9F9F9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Text(data.skuInfos[i].productSkuName),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 22, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                        "\$${data.skuInfos[i].discountPrice}",
                                        style: TextStyle(
                                            height: 1,
                                            color: Color(0xFFED1B2E),
                                            fontSize: 14)),
                                  ),
                                  Expanded(
                                    child: Container(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        (data.skuInfos[i].saleServiceIn !=
                                                    "0" ||
                                                data.skuInfos[i]
                                                        .saleServicePass !=
                                                    "0" ||
                                                data.skuInfos[i]
                                                        .saleServiceReject !=
                                                    "0")
                                            ? Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    6, 3, 6, 3),
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                decoration: BoxDecoration(
                                                    color: data.skuInfos[i]
                                                                .saleServiceIn !=
                                                            "0"
                                                        ? Color(0xFFFF9300)
                                                        : Color(0xFF22AB39),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                child: data.skuInfos[i]
                                                            .saleServiceIn !=
                                                        "0"
                                                    ? Row(children: [
                                                        Container(
                                                            margin:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                                data.skuInfos[i]
                                                                            .saleServiceIn >
                                                                        0
                                                                    ? "售後審核中"
                                                                    : "售後已完成",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFFFFFFFF),
                                                                    fontSize:
                                                                        13,
                                                                    height:
                                                                        1))),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  3, 0, 0, 0),
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Image.asset(
                                                            "assets/icons/icon-back-right.png",
                                                            width: 6,
                                                            height: 10,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                          ),
                                                        )
                                                      ])
                                                    : Container(),
                                              )
                                            : Container(),
                                        Text(
                                          "x${data.skuInfos[i].quantity}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                            color: Color(0xFF777777),
                                          ),
                                        ),
                                      ],
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ])))
            ],
          ),
        ));
      }
    }
    return goods;
  }

  List<Widget> renderCause(index, state) {
    List<Widget> causeList = [];
    for (int i = 0; i < causeText.length; i++) {
      causeList.add(
        GestureDetector(
            onTap: () {
              state(() {
                checkCause = i;
              });
            },
            child: Container(
                margin: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 12),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 12),
                        child: i == index
                            ? Image.asset(
                                "assets/icons/icon_check.png",
                                width: 20,
                                height: 20,
                              )
                            : Image.asset(
                                "assets/icons/icon_no_check.png",
                                width: 20,
                                height: 20,
                              )),
                    Container(
                        child: Text(
                      causeText[i],
                      style: TextStyle(fontSize: 16),
                    ))
                  ],
                ))),
      );
    }

    return causeList;
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
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
          '我的訂單',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: DefaultTabController(
        length: 4,
        initialIndex: arguments["type"],
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.black12))),
              child: TabBar(
                unselectedLabelColor: Color(0xFF222222),
                indicatorColor: Color(0xFFED1B2E),
                labelColor: Color(0xFFED1B2E),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 5.0),
                indicatorWeight: 4,
                tabs: <Widget>[
                  Tab(text: "全部訂單"),
                  Tab(text: '待發貨'),
                  Tab(text: '已發貨'),
                  Tab(text: '已完成'),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: TabBarView(
                    children: <Widget>[
                      order(context, dataList, data1, 0, last1,topPadding,bottomPadding),
                      order(context, dataList1, data2, 1, last2,topPadding,bottomPadding),
                      order(context, dataList2, data3, 2, last3,topPadding,bottomPadding),
                      order(context, dataList3, data4, 3, last4,topPadding,bottomPadding),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  getList(data, size) {
    List<Widget> listOrder = [];
    for (var i = 0; i < data.length; i++) {
      listOrder.add(Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
            width: size,
            height: size,
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
                imageUrl: "http:" + data[i].productImageUrl,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/icons/placeholder.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          int.parse(data[i].quantity) > 1
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
    return listOrder;
  }

  btnModel(text) {
    return Container(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 12, 5, 16),
        padding: EdgeInsets.fromLTRB(8, 9, 8, 9),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6.0),
          border: new Border.all(width: 1, color: Color(0xFFBCBCBC)),
        ),
        child: Text(
          text,
          style: TextStyle(color: Color(0xFF222222), fontSize: 13),
        ),
      ),
    );
  }

  text(text) {
    var val = '';
    switch (text) {
      case '订单包裹发出':
        val = '您的包裹清關中';
        break;
      case '订单商品打包':
        val = '您的訂單打包完成，已出庫';
        break;
      default:
        val = text;
    }
    return val;
  }

  icon(text) {
    var icon = '';
    switch (text) {
      case '訂單創建成功':
        icon = 'assets/icons/1.png';
        break;
      case '訂單準備打包':
        icon = 'assets/icons/2.png';
        break;
      case '订单包裹发出':
        icon = 'assets/icons/3.png';
        break;
      case 'delivered':
        icon = 'assets/icons/6.png';
        break;
      case 'exception':
        icon = 'assets/icons/7.png';
        break;
    }
    return icon;
  }

  List<Widget> renderStepper(context, data, product, index) {
    List<Widget> stepper = [];
    if (product != null) {
      stepper.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 27),
              height: 90,
              color: Color(0xFFFFFCEE),
              child: new ListView(
                scrollDirection: Axis.horizontal,
                children:
                    this.getList(product.packageInfos[index].skuInfos, 80.0),
              ),
            ),
          ],
        ),
      );
    }

    for (var i = data.body.eventInfos.length - 1; i >= 0; i--) {
      if (i != data.body.eventInfos.length - 1) {
        stepper.add(
          Row(children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(95.5, 0, 0, 0),
              height: 24,
              width: 1,
              color: Color(0xFFBCBCBC),
            )
          ]),
        );
      }
      stepper.add(
        icon(data.body.eventInfos[i].eventName) != ''
            ? Row(children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 41,
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        data.body.eventInfos[i].createdAt.substring(5, 10),
                        style: TextStyle(),
                      ),
                    ),
                    Container(
                      width: 41,
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                          data.body.eventInfos[i].createdAt.substring(11, 16),
                          style: TextStyle()),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        child: Image.asset(
                          icon(data.body.eventInfos[i].eventName),
                          width: 25,
                          height: 25,
                          color: i == data.body.eventInfos.length - 1
                              ? Color(0xFF1B7EED)
                              : Color(0xFFBCBCBC),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16),
                            border: new Border.all(
                                width: 1,
                                color: i == data.body.eventInfos.length - 1
                                    ? Color(0xFF1B7EED)
                                    : Color(0xFFBCBCBC))),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                    child: Text(text(data.body.eventInfos[i].eventName)))
              ])
            : Row(children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 41,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        data.body.eventInfos[i].createdAt.substring(5, 10),
                        style: TextStyle(),
                      ),
                    ),
                    Container(
                      width: 41,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                          data.body.eventInfos[i].createdAt.substring(11, 16),
                          style: TextStyle()),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(32, 0, 10, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 14,
                        width: 1,
                        color: Color(0xFFBCBCBC),
                      ),
                      Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xFFBCBCBC)),
                      ),
                      Container(
                        height: 14,
                        width: 1,
                        color: Color(0xFFBCBCBC),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(17, 0, 0, 0),
                    child: Text(text(data.body.eventInfos[i].eventName)))
              ]),
      );
    }
    return stepper;
  }

  btn(context, data, index,topPadding,bottomPadding) {
    if (data.packageInfos[index].status == 10 ||
        data.packageInfos[index].status == 17) {
      return Row(children: <Widget>[
        trackingPackages(context, data, index, '追蹤包裹'),
        viewPackages(context, data, index)
      ]);
    } else if (data.packageInfos[index].status == 20) {
      return Row(children: <Widget>[
        trackingPackages(context, data, index, '追蹤物流'),
        viewPackages(context, data, index)
      ]);
    } else if (data.packageInfos[index].status == 40) {
      return Row(children: <Widget>[
        viewPackages(context, data, index),
        onceMoreButton(context, data.packageInfos[index]),
      ]);
    } else if (data.packageInfos[index].status == 30) {
      return Row(children: <Widget>[
        viewPackages(context, data, index),
        onceMoreButton(context, data.packageInfos[index]),
        afterSalesButton(context, data, index,topPadding,bottomPadding)
      ]);
    } else if (data.packageInfos[index].status == -5) {
      return Row(children: <Widget>[
        viewPackages(context, data, index),
        onceMoreButton(context, data.packageInfos[index]),
      ]);
    } else {
      return Row(children: <Widget>[
        viewMerchandise(context, data, index),
        GestureDetector(
          onTap: () {
            if (check) {
              setState(() {
                check = false;
              });
              Toast.toast(context, msg: "提醒成功", position: ToastPostion.bottom);
            } else {
              Toast.toast(context, msg: "提醒過了喲", position: ToastPostion.bottom);
            }
          },
          child: btnModel("提醒發貨"),
        ),
        data.packageInfos[index].userCanCancel
            ? cancelOrderButton(context, data.packageInfos[index], "取消訂單",
                index, data.paymentType,topPadding,bottomPadding)
            : Container(),
      ]);
    }
  }

  onceMoreButton(context, data) {
    int catNum = Provide.value<CurrentIndexProvide>(context).catNum;
    List footList = Provide.value<FootMarkProvide>(context).footMarkList;
    String  cartInfoLast = Provide.value<CartProvide>(context).cartInfoLast;
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new LoadingDialog(
                text: null,
              );
            });
        List goodList = [];

        for (var i = 0; i < data.skuInfos.length; i++) {
          var newGoods = {
            'productId': data.skuInfos[i].productId,
            'productTitle': data.skuInfos[i].productTitle,
            'quantity': data.skuInfos[i].quantity,
            'productSkuId': data.skuInfos[i].productSkuId,
            'productSkuBarcode': data.skuInfos[i].productSkuBarcode,
            'productSkuName': data.skuInfos[i].productSkuName,
            'productImageUrl': data.skuInfos[i].productImageUrl,
            'isSelect': true,
            "discountPrice": data.skuInfos[i].discountPrice,
            "shoppingType": 4
          };
          goodList.add(newGoods);
        }

        orderPrice({"orderProducts": goodList}).then((val) {
          var cartText = ""; 
            var footText = "";
            int footIndex = 0;          
            for(var i=0;i<val.body.products.length;i++){
              if(i==0){
                cartText+= "${val.body.products[i].productId}";
              }else{
                cartText+=",${val.body.products[i].productId}";
              }
            }
            for(var i=footList.length-1;i>=0;i--){
              footIndex++;
              if(footIndex<19){
                if(i==footList.length-1){
                  if(val.body.products.length>0){
                    footText+="${val.body.products[val.body.products.length-1].productId},${footList[i].id}";
                  }else{
                      if(cartInfoLast!=""){
                        footText+="${cartInfoLast},${footList[i].id}";
                      }else{
                        footText+="${footList[i].id}";
                      }
                  }
                }else{
                  footText+=",${footList[i].id}";
                }
              }
            }
            cartRecommend("productIds=${cartText}&carProductIds=${footText}").then((value) {
              Provide.value<CartProvide>(context).saveList(value);
            });
           Navigator.pop(context);
           if(val!=500){
                int num = 0;
          for (var i = 0; i < val.body.products.length; i++) {
            Provide.value<CartProvide>(context).save(
                val.body.products[i].productId,
                val.body.products[i].productTitle,
                val.body.products[i].quantity,
                val.body.products[i].productSkuId,
                val.body.products[i].productSkuBarcode,
                val.body.products[i].productSkuName,
                val.body.products[i].productImageUrl,
                true,
                val.body.products[i].price,
                val.body.products[i].originalPrice,
                val.body.products[i].discountPrice,
                val.body.products[i].shoppingType,
                val.body.products[i].isLimitProduct!=null?val.body.products[i].isLimitProduct:false
                );
          }
          Provide.value<CurrentIndexProvide>(context)
              .changeCatNum(catNum + num);
          Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                            Navigator.popUntil(context, ModalRoute.withName('/home'));
           }
       
        });
      },
      child: btnModel("再次購買"),
    );
  }

  afterSalesButton(context, data, index,topPadding,bottomPadding) {
    return GestureDetector(
      onTap: () {
        DateTime time01 = DateTime.now();
        DateTime time02 = DateTime.parse(data.packageInfos[index].trackerUpdatedAt);
        Duration duration = time01.difference(time02);
        if (data.packageInfos[index].status == 30 && data.packageInfos[index].trackerUpdatedAt != null && duration.inDays.toInt() > 30) {
          showDialog(
              context: context,
              builder: (context) {
                return new AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  titlePadding: EdgeInsets.fromLTRB(0, 16, 0, 24),
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )),
                  title: Container(
                    alignment: Alignment.center,
                    child: new Text(
                      "無法在線申請退換貨",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF222222),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  content: Container(
                      height: 150,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 0, bottom: 20),
                            child: Text("很抱歉，自您簽收此包裹時間已超過30天，無法進行線上退換貨",
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 0, bottom: 20),
                            child: Text("如有疑問，請聯繫客服進行人工處理。",
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 38.0,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color(0xFFED1B2E),
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: new Border.all(
                                        width: 1, color: Color(0xFFED1B2E)),
                                  ),
                                  child: Text(
                                    '知道了',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                );
              });
          return;
        }
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    title: Text(
                      "退換/售後",
                      style: TextStyle(color: Colors.black),
                    ),
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
                  body: Column(
                    children: <Widget>[
                      Container(
                          height: 82,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFEFCEF),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Column(children: <Widget>[
                            addressText(context, data.orderAddress),
                            Image.asset(
                              "assets/images/address-bottom.png",
                              fit: BoxFit.cover,
                            ),
                          ])),
                      //"11111111111"
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Container(
                            height: 90,
                            child: new ListView(
                              scrollDirection: Axis.horizontal,
                              children: this.getList(
                                  data.packageInfos[index].skuInfos, 90.0),
                            ),
                          )),
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
                                      "order": data,
                                      "data": data.packageInfos[index],
                                      "code": data.code,
                                      "type": 10
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        padding:
                                            EdgeInsets.fromLTRB(15, 17, 16, 17),
                                        child: Image.asset(
                                          "assets/icons/icon-after_sales-return.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '退貨退款',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          color: Colors.white,
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          alignment: Alignment.centerRight,
                                          child: Image.asset(
                                            "assets/icons/icon-back-right.png",
                                            width: 6,
                                            height: 10,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                height: 0.5,
                                color: Color(0xFFEDEDED),
                                margin: EdgeInsets.fromLTRB(52, 0, 0, 0),
                                child: Row(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/afterSales",
                                      arguments: {
                                        "order": data,
                                        "data": data.packageInfos[index],
                                        "code": data.code,
                                        "type": 20
                                      });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.fromLTRB(15, 17, 17, 16),
                                      child: Image.asset(
                                        "assets/icons/icon-after_sales-exchange.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '換貨',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        color: Colors.white,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          "assets/icons/icon-back-right.png",
                                          width: 6,
                                          height: 10,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ));
          },
        );
      },
      child: btnModel("退換貨"),
    );
  }

  Widget addressText(context, address) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(15, 15, 10, 10),
              child: Text("${address.consignee}  ${address.tel}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            Container(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 10),
                child: Text(
                    "${address.detail}  (${address.city} ${address.district})",
                    style: TextStyle(fontSize: 14, color: Colors.black45))),
          ],
        ),
      ],
    );
  }

  cancelOrderButton(context, data, text, index, payType,topPadding,bottomPadding) {

    return GestureDetector(
        onTap: () {
          setState(() {
            checkCause = 0;
          });
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context1, state) {
                  return Container( 
                    color: Colors.white,
                 
                padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),child:Scaffold(
                      appBar: AppBar(
                        elevation: 0,
                        title: Text(
                          "取消订单(包裹${index + 1})",
                          style: TextStyle(color: Colors.black),
                        ),
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
                        backgroundColor: Colors.white,
                      ),
                      body: Stack(children: <Widget>[
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            margin: EdgeInsets.fromLTRB(
                                0, 0, 0, 40.5 + bottomPadding),
                            color: Color(0xFFF4F4F4),
                            child: ListView(children: <Widget>[
                              Column(children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(12, 16, 12, 10),
                                  child: Text("請選擇取消原因",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    padding: EdgeInsets.fromLTRB(17, 10, 12, 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Column(
                                        children:
                                            renderCause(checkCause, state))),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(12, 16, 12, 10),
                                  child: Text(
                                      "取消的商品(共${data.skuInfos.length}件)",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    padding: EdgeInsets.fromLTRB(12, 10, 12, 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Column(children: renderGoods(data))),
                              ])
                            ])),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 50.5 + bottomPadding,
                            padding:
                                EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 0.5,
                                      color: Color(0xFFDFDEDB)), //有边框
                                )),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(12, 6, 6, 6),
                                        alignment: Alignment.center,
                                        height: 38.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          border: new Border.all(
                                              width: 1,
                                              color: Color(0xFFED1B2E)),
                                        ),
                                        child: Text(
                                          '暫不取消',
                                          style: TextStyle(
                                              color: Color(0xFFED1B2E),
                                              fontSize: 16),
                                        ),
                                      )),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return new LoadingDialog(
                                                text: "取消中…",
                                              );
                                            });
                                        cancelOrder({
                                          "orderCode": data.orderCode,
                                          "userCancelReason":
                                              causeText[checkCause]
                                        }).then((val) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          if(val!=500){
                                             setState(() {
                                            dataList = [];
                                            dataList1 = [];
                                            dataList2 = [];
                                            dataList3 = [];
                                            data1 = false;
                                            data2 = false;
                                            data3 = false;
                                            data4 = false;
                                          });
                                          getData();
                                          if (payType == 1) {
                                            Toast.toast(context,
                                                msg:
                                                    "包裹${index + 1},共${val.body.cancelProductCount}件商品已成功取消",
                                                position: ToastPostion.bottom);
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return new AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 0, 15, 0),
                                                    titlePadding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 16, 0, 24),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(8),
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              bottomLeft: Radius
                                                                  .circular(8),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8),
                                                            )),
                                                    title: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: new Text(
                                                        "商品取消成功",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Color(
                                                                0xFF222222),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    content: Container(
                                                        height: 180,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      text:
                                                                          '訂單',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Color(
                                                                              0xFF222222)),
                                                                      children: <
                                                                          TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            '${val.body.orderCode}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Color(0xFF007AFF))),
                                                                    TextSpan(
                                                                        text:
                                                                            '包裹${index + 1}，共${val.body.cancelProductCount}件商品，已成功取消。',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Color(0xFF222222))),
                                                                  ])),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 10,
                                                                      bottom:
                                                                          20),
                                                              child: Text(
                                                                  "商品退款将在20天左右返回您的原支付帐簿，请注意查收。",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                  )),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    height:
                                                                        38.0,
                                                                    width: 150,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      color: Color(
                                                                          0xFFED1B2E),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              25.0),
                                                                      border: new Border
                                                                              .all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Color(0xFFED1B2E)),
                                                                    ),
                                                                    child: Text(
                                                                      '知道了',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                  );
                                                });
                                          }
                                        }
                                          });
                                         
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(6, 6, 12, 6),
                                        alignment: Alignment.center,
                                        height: 38.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Color(0xFFED1B2E),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: Text(
                                          '確定取消',
                                          style: TextStyle(
                                              color: Color(0xFFFFFFFFF),
                                              fontSize: 16),
                                        ),
                                      )),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        )
                      ])));
                });
              });
        },
        child: btnModel(text));
  }

  trackingPackages(context, data, index, text) {
    return GestureDetector(
      onTap: () {
        final size = MediaQuery.of(context).size;
        final _height = size.height;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new LoadingDialog(
                text: null,
              );
            });
        getLogistics(data.code, data.packageInfos[index].deliveryCode)
            .then((val) {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )),
            builder: (BuildContext context) {
              return Container(
                  height: _height * 0.7,
                  child: Stack(children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 60, 0, 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: ListView(
                        children: <Widget>[
                          Container(
                              child: Column(
                                  children: renderStepper(
                                      context, val, data, index))),
                        ],
                      ),
                    ),
                    Positioned(
                        child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(12, 4, 12, 0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "追蹤物流",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF222222)),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 12, 0, 0),
                                            width: 30,
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Image.asset(
                                                'assets/icons/icon-close.png',
                                                width: 15,
                                                height: 15,
                                                color: Color(0xFF222222),
                                              ),
                                            )))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '订单：${data.code}(包裹${index + 1})',
                                      style:
                                          TextStyle(color: Color(0xFF777777)),
                                    )
                                  ],
                                )
                              ],
                            ))),
                  ]));
            },
          );
        });
      },
      child: btnModel(text),
    );
  }

  isNum(d) {
    int num = 0;
    double price = 0;
    for (var i = 0; i < d.length; i++) {
      num += int.parse(d[i].quantity);
      price += doubleText(
          int.parse(d[i].quantity) * double.parse(d[i].discountPrice));
    }
    return [num, price];
  }

  viewMerchandise(context, data, index) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    List num = isNum(data.packageInfos[index].skuInfos);
    return GestureDetector(
      onTap: () {
        final size = MediaQuery.of(context).size;
        final _height = size.height;

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
          builder: (BuildContext context) {
            return Container(
                height: _height * 0.7,
                child: Stack(children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 25),
                      height: size.height * 0.7,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(12, 30, 12, 40),
                        color: Color(0xFFFFFCEE),
                        child: _showNomalWid(
                            context, data.packageInfos[index].skuInfos),
                      )),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: new Container(
                                      margin: EdgeInsets.only(
                                          left: 0,
                                          right: 0,
                                          top: size.height * 0.7 -
                                              (58 + bottomPadding)),
                                      padding: EdgeInsets.fromLTRB(
                                          12, 10, 12, 10 + bottomPadding),
                                      height: 58.0 + bottomPadding,
                                      color: Colors.white,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Text("共${num[0]}件商品，总计:"),
                                          ),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text("\$${num[1]}",
                                                style: TextStyle(
                                                    color: Color(0xFFED1B2E),
                                                    fontSize: 26)),
                                          ))
                                        ],
                                      )

                                      // 设置按钮圆角
                                      ))))
                    ],
                  ),
                  Positioned(
                      child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(12, 4, 12, 0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "待發貨商品",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222)),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 12, 0, 0),
                                          width: 30,
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Image.asset(
                                              'assets/icons/icon-close.png',
                                              width: 15,
                                              height: 15,
                                              color: Color(0xFF222222),
                                            ),
                                          )))
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    '订单：${data.code}(包裹${index + 1})',
                                    style: TextStyle(color: Color(0xFF777777)),
                                  )
                                ],
                              ),
                            ],
                          ))),
                ]));
          },
        );
      },
      child: btnModel("查看商品"),
    );
  }

  viewPackages(context, data, index) {
    final double topPadding = MediaQuery.of(context).padding.top;
    List num = isNum(data.packageInfos[index].skuInfos);
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new LoadingDialog(
                text: null,
              );
            });
        getLogistics(data.code, data.packageInfos[index].deliveryCode)
            .then((val) {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )),
            builder: (BuildContext context) {
              return Container(
                  child: Stack(children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(10, 62 + topPadding, 10, 10),
                    color: Color(0xFFF4F4F4),
                    child: ListView(children: <Widget>[
                      Column(children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.fromLTRB(12, 10, 12, 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Column(
                                children:
                                    renderGoods(data.packageInfos[index]))),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.fromLTRB(12, 6, 12, 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "實際應付",
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1,
                                                color: Color(0xFF222222)),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 2, 0, 0),
                                          child: Text(
                                            " (共${num[0]}件商品)",
                                            style: TextStyle(
                                                fontSize: 12,
                                                height: 1,
                                                color: Color(0xFF777777)),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerRight,
                                          color: Colors.white,
                                          child: Text("\$${num[1]}",
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  height: 1,
                                                  color: Color(0xFFED1B2E))),
                                        ))
                                      ],
                                    )),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: EdgeInsets.fromLTRB(12, 21, 12, 21),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Column(
                                children:
                                    renderStepper(context, val, null, null))),
                        GestureDetector(
                            onTap: () {
                              _fb();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.fromLTRB(15, 14, 14, 16),
                                    child: Image.asset(
                                      "assets/icons/customer-service.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: Text('聯繫客服',
                                          style: TextStyle(fontSize: 16))),
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      color: Colors.white,
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        "assets/icons/icon-back-right.png",
                                        width: 6,
                                        height: 10,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ])
                    ])),
                Positioned(
                    child: Container(
                        height: 62 + topPadding,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(12, 14 + topPadding, 12, 0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    width: 30,
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.asset(
                                        'assets/icons/icon-close.png',
                                        width: 15,
                                        height: 15,
                                        color: Color(0xFF222222),
                                      ),
                                    )),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 12, 30, 0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "查看包裹",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))),
              ]));
            },
          );
        });
      },
      child: btnModel("查看包裹"),
    );
  }

  List<Widget> renderGoods(data) {
    List<Widget> goods = [];
    if (data.skuInfos != null) {
      for (var i = 0; i < data.skuInfos.length; i++) {
        goods.add(Container(
          margin: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 12),
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/detail",
                        arguments: {"id": data.skuInfos[i].productId});
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                        imageUrl: "http:" + data.skuInfos[i].productImageUrl,
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/icons/placeholder.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                data.skuInfos[i].productTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 14,
                                  color: Color(0xFF222222),
                                ),
                              ),
                            )),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              child: Text(
                                data.skuInfos[i].productSkuName,
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFF777777)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 22, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                        "\$${data.skuInfos[i].discountPrice}",
                                        style: TextStyle(
                                            height: 1,
                                            color: Color(0xFFED1B2E),
                                            fontSize: 14)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "x${data.skuInfos[i].quantity}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          height: 1,
                                          color: Color(0xFF777777),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ])))
            ],
          ),
        ));
      }
    }
    return goods;
  }

  Widget _showNomalWid(BuildContext context, cartList) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 90,
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 73,
                  width: 73,
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                      imageUrl: "http:" + cartList[index].productImageUrl,
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/icons/placeholder.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        height: 81,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                  height: 20,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      cartList[index].productTitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF363636),
                                      ),
                                    ),
                                  )),
                              Container(
                                //width: 80,
                                // margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                padding: EdgeInsets.fromLTRB(0, 6, 6, 6),

                                child: Text(
                                  cartList[index].productSkuName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF777777),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Text(
                                          "\$${doubleText(double.parse(cartList[index].discountPrice))}",
                                          style: TextStyle(
                                              color: Color(0xFFED1B2E),
                                              fontSize: 14)),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "x${cartList[index].quantity}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF777777),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ])))
              ],
            ),
          );
        },
        itemCount: cartList.length);
  }

  getText(i) {
    if (i == 10 || i == 17) {
      return '已發貨';
    } else if (i == 20) {
      return "運輸中";
    } else if (i == 30) {
      return "已簽收";
    } else if (i == 40) {
      return "已拒收";
    } else if (i == -5) {
      return "已取消";
    } else {
      return "待發貨";
    }
  }

  getColor(data) {
    if (data == 10 || data == 17) {
      return 0xFFF28F2D;
    } else if (data == 20) {
      return 0xFFF28F2D;
    } else if (data == 30) {
      return 0xFF36ACA0;
    } else if (data == 40) {
      return 0xFFFF0000;
    } else if (data == -5) {
      return 0xFF777777;
    } else {
      return 0xFFC5221A;
    }
  }

  package(context, data,topPadding,bottomPadding) {
    final size = MediaQuery.of(context).size;
    final _width = size.width;
    List<Widget> listOrder = [];
    for (var i = 0; i < data.packageInfos.length; i++) {
      listOrder.add(Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFF4F4F4)),
                    child: Text(
                      "包裹${i + 1}",
                      style: TextStyle(fontSize: 12, color: Color(0xFF222222)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Text(
                      getText(data.packageInfos[i].status),
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(getColor(data.packageInfos[i].status))),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 90,
                    width: _width - 86,
                    child: new ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          this.getList(data.packageInfos[i].skuInfos, 90.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
          data.packageInfos[i].status == 20
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 66, top: 8),
                    child: Text(data.packageInfos[i].lastUpdateTime,
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF777777))),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 66, top: 5),
                    child: Text(
                      data.packageInfos[i].lastEvent,
                      style: TextStyle(fontSize: 14, color: Color(0xFF1B7EED)),
                    ),
                  )
                ])
              : Container(),
          Container(
              padding: EdgeInsets.only(left: 66), child: btn(context, data, i,topPadding,bottomPadding))
        ],
      ));
    }

    return listOrder;
  }

  Widget order(context, data, lock, type, last,topPadding,bottomPadding) {
    return lock
        ? data.length > 0
            ? EasyRefresh.custom(
                header: BallPulseHeader(color: Color(0xFF777777)),
                footer: BallPulseFooter(color: Color(0xFF777777)),
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2), () {
                    if (mounted) {
                      setState(() {
                        if (type == 0) {
                          dataList = [];
                          data1 = false;
                        } else if (type == 1) {
                          dataList1 = [];
                          data2 = false;
                        } else if (type == 2) {
                          dataList2 = [];
                          data3 = false;
                        } else if (type == 3) {
                          dataList3 = [];
                          data4 = false;
                        }
                      });
                      getOrderList(type, 0).then((val) {
                        setState(() {
                          for (var i = 0; i < val.body.content.length; i++) {
                            if (type == 0) {
                              data1 = true;
                              dataList.add(val.body.content[i]);
                            } else if (type == 1) {
                              data2 = true;
                              dataList1.add(val.body.content[i]);
                            } else if (type == 2) {
                              data3 = true;
                              dataList2.add(val.body.content[i]);
                            } else if (type == 3) {
                              data4 = true;
                              dataList3.add(val.body.content[i]);
                            }
                          }
                        });
                      });
                    }
                  });
                },
                onLoad: !last
                    ? () async {
                        await Future.delayed(Duration(seconds: 4), () {
                          if (mounted) {
                            getOrderList(type, index1).then((val) {
                              setState(() {
                                for (var i = 0;
                                    i < val.body.content.length;
                                    i++) {
                                  if (type == 0) {
                                    dataList.add(val.body.content[i]);
                                  } else if (type == 1) {
                                    dataList1.add(val.body.content[i]);
                                  } else if (type == 2) {
                                    dataList2.add(val.body.content[i]);
                                  } else if (type == 3) {
                                    dataList3.add(val.body.content[i]);
                                  }
                                }
                                if (type == 0) {
                                  index1++;
                                  last1 = val.body.last;
                                } else if (type == 1) {
                                  index2++;
                                  last2 = val.body.last;
                                } else if (type == 2) {
                                  index3++;
                                  last3 = val.body.last;
                                } else if (type == 3) {
                                  index4++;
                                  last4 = val.body.last;
                                }
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
                          return orderList(context, data[index],topPadding,bottomPadding);
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

  quantity(data) {
    int num = 0;
    for (var i = 0; i < data.packageInfos[0].skuInfos.length; i++) {
      num += int.parse(data.packageInfos[0].skuInfos[i].quantity);
    }
    return num;
  }

  Widget orderList(context, data,topPadding,bottomPadding) {
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
                          .pushNamed("/orderDetail", arguments: {
                        "id": data.code,
                      });
                    },
                    child: Container(
                        child: Row(
                      children: <Widget>[
                       
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 16, 0, 0),
                              child: Text(
                                "訂單號：${data.code}",
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 8, 0, 0),
                              child: Text(
                                "共${quantity(data)}件商品   ${data.createdAt.split("G")[0]}",
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
                                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Text("訂單詳情",
                                    style: TextStyle(
                                        color: Color(0xFF777777),
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
                    child: Row()),
                Column(children: package(context, data,topPadding,bottomPadding))
              ],
            ),
          )
        ],
      ),
    );
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
              "您還沒有相關訂單",
              style: TextStyle(fontSize: 14, color: Color(0xFF777777)),
            ),
          ),
          GestureDetector(
              onTap: () {
                Provide.value<CurrentIndexProvide>(context).changeIndex(0);
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                alignment: Alignment.center,
                width: 180.0,
                height: 38.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25.0),
                  border: new Border.all(width: 1, color: Colors.red),
                ),
                child: Text(
                  '去逛逛',
                  style: TextStyle(color: Color(0xFFED1B2E), fontSize: 16),
                ),
              ))
        ],
      ),
    );
  }
}
