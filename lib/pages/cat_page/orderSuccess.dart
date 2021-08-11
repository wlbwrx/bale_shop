import 'package:bale_shop/widgets/goods/goodsMouldTwo.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/currentIndex.dart';
import 'package:bale_shop/api/home.dart';
import 'package:flutter/services.dart';
import 'package:bale_shop/widgets/cart/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'dart:convert';
class OrderSuccessPage extends StatefulWidget {
  OrderSuccessPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccessPage> {
  Map arguments;
  List likeList = [];
  List imgLit = [];
  String code = "";
  String date = "";
  String address ="";
  static final facebookAppEvents = FacebookAppEvents();
  void initState() {
    arguments = widget.arguments;
    super.initState();
    List productItems = [];
    orderQuerys(arguments["id"]).then((val) {
      setState(() {
        code = val.body[0].code;
        date = val.body[0].createdAt;
        address = val.body[0].orderAddress.city + val.body[0].orderAddress.district + val.body[0].orderAddress.detail;
      });
      for (var i = 0; i < val.body[0].packageInfos[0].skuInfos.length; i++) {
        setState(() {
          code = val.body[0].code;
          imgLit.add(val.body[0].packageInfos[0].skuInfos[i]);
        });
      }
      print(JsonEncoder().convert(productItems));
     
    });
    recommendSimilar(arguments["id"]).then((val) {
      setState(() {
        for (var i = 0; i < val.body.length; i++) {
          likeList.add(val.body[i]);
        }
      });
    });
  }

  getList() {
    Iterable<Widget> listTitles = imgLit.map((index) {
      return Stack(
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
            placeholder: (context, url) => Image.asset('assets/icons/placeholder.png',fit: BoxFit.cover,),
            imageUrl:"http:" + index.productImageUrl,
            errorWidget: (context, url, error) => Image.asset('assets/icons/placeholder.png',fit: BoxFit.cover,),
          ),
            ),
          ),
          index.quantity!="1"?Positioned(
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
            child: Text("${index.quantity}件",style: TextStyle(
              fontSize: 12,
              color: Colors.white
            ),),
          ),
          ):Container()
          
        ],
      );
    });
    return listTitles.toList();
  }

  Widget build(BuildContext context) {
    var today = DateTime.now(); // 2019-11-08 02:54:53.218443
    var fiftyDaysFromNow = today.add(new Duration(days: 10));
    var nowText =
        "${fiftyDaysFromNow.year}.${fiftyDaysFromNow.month}.${fiftyDaysFromNow.day}";
    var fiftyDaysFromEnd = today.add(new Duration(days: 15));
    var endText =
        "${fiftyDaysFromEnd.year}.${fiftyDaysFromEnd.month}.${fiftyDaysFromEnd.day}";
    var date1 = date.split("G")[0];
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "訂購完成",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(shrinkWrap: true, children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            color: Color(0xFF22AB39),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(15, 0, 16, 0),
                        child: Image.asset(
                          "assets/images/order-success.png",
                          width: 60,
                          height: 60,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '下單成功',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          Text(
                            '預計${nowText}~${endText}到達',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "訂單號：${code}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                           GestureDetector(
                             onTap: (){
                               Clipboard.setData(ClipboardData(text: code));
                               Toast.toast(context,
                                  msg: "複製成功", position: ToastPostion.center);
                             },
                             child: Container(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              margin: EdgeInsets.fromLTRB(8, 0, 4, 0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                border: new Border.all(
                                    width: 1, color: Color(0xFFED1B2E)),
                              ),
                              child: Text(
                                '複製',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFED1B2E),
                                ),
                              ),
                            ),
                           ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 12),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "共${imgLit.length}件商品  ${date1}",
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF777777)),
                            )
                          ],
                        ),
                      ),
                      MySeparator(height: 1, color: Color(0xFFEDEDED)),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 12, 0, 9),
                        padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                        decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0XFFFFFCEE),
                              border:
                                  new Border.all(width: 1, color: Color(0XFFECE2C8)),
                            ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "送至：${address}",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFFBAA269)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        child: new ListView(
                          scrollDirection: Axis.horizontal,
                          children: this.getList(),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Provide.value<CurrentIndexProvide>(context)
                                .changeIndex(0);
                                              Navigator.popUntil(context, ModalRoute.withName('/home')); 

                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 38.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25.0),
                              border:
                                  new Border.all(width: 1, color: Colors.white),
                            ),
                            child: Text(
                              '返回首頁',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/orderDetail",arguments: {
                          "id": code,
                        });
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                            alignment: Alignment.center,
                            width: 100.0,
                            height: 38.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25.0),
                              border:
                                  new Border.all(width: 1, color: Colors.white),
                            ),
                            child: Text(
                              '查看訂單',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child:Text("如果您有任何售後問題，可以通過以下方式聯繫我們",style: TextStyle(
                    fontSize: 14,
                    color:Color(0xFF222222)
                  )),
                ),
                Table(
                                  border: TableBorder.all(
                                    color: Color(0xFFEDEDED),
                                  ),
                                  columnWidths: <int, TableColumnWidth>{
                                    0:FixedColumnWidth(130),
                                    1:FixedColumnWidth(150),
                                  },
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFBFBFB),
                                        ),
                                        children: [
                                          new TableCell(
                                              child: Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: new Text(
                                              '方式',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                          new TableCell(
                                              child: Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: new Text(
                                              '賬號ID/號碼',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                          new TableCell(
                                              child: Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: new Text(
                                              '操作',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                        ]),
                                    TableRow(children: [
                                      new TableCell(
                                        child: new Center(
                                            child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 14, 0, 14),
                                          child: new Text('Messenger'),
                                        )),
                                      ),
                                      new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: new Text('阿噗特賣'),
                                        ),
                                      ),
                                      new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                             onTap: (){
                               Clipboard.setData(ClipboardData(text: "阿噗特賣"));
                               Toast.toast(context,
                                  msg: "複製成功", position: ToastPostion.center);
                             },
                             child: Container(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              margin: EdgeInsets.fromLTRB(8, 0, 4, 0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                border: new Border.all(
                                    width: 1, color: Color(0xFFED1B2E)),
                              ),
                              child: Text(
                                '複製',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFED1B2E),
                                ),
                              ),
                            ),
                           ),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      new TableCell(
                                        child: new Center(
                                            child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 13, 0, 13),
                                          child:
                                              new Text('Line'),
                                        )),
                                      ),
                                      new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: new Text('@841dxfwu'),
                                        ),
                                        ),
                                        new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                             onTap: (){
                               Clipboard.setData(ClipboardData(text: "@841dxfwu"));
                               Toast.toast(context,
                                  msg: "複製成功", position: ToastPostion.center);
                             },
                             child: Container(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              margin: EdgeInsets.fromLTRB(8, 0, 4, 0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                border: new Border.all(
                                    width: 1, color: Color(0xFFED1B2E)),
                              ),
                              child: Text(
                                '複製',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFED1B2E),
                                ),
                              ),
                            ),
                           ),
                                        ),
                                      ),
                                      
                                    ]),
                                    TableRow(children: [
                                      new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: new Text('客服電話'),
                                        ),
                                      ),
                                      new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: new Text('+852 51013032'),
                                        ),
                                      ),
                                      new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                             onTap: (){
                               Clipboard.setData(ClipboardData(text: "+852 51013032"));
                               Toast.toast(context,
                                  msg: "複製成功", position: ToastPostion.center);
                             },
                             child: Container(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              margin: EdgeInsets.fromLTRB(8, 0, 4, 0),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                border: new Border.all(
                                    width: 1, color: Color(0xFFED1B2E)),
                              ),
                              child: Text(
                                '複製',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFED1B2E),
                                ),
                              ),
                            ),
                           ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
              ],
            ),

          ),
          Container(
              color: Color(0xFFF4F4F4),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(12, 12, 0, 12),
              child: Text(
                "更多推荐",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )),
          Container(
            color: Color(0xFFF4F4F4),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: GridView.builder(
                itemCount: likeList.length,
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //Grid按两列显示
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: sizeHeight2(size.height),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/detail", arguments: {
                          "id": likeList[index].id,
                          "isIndex": 2
                        });
                      },
                      child: GoodsMouldTwo(data: [likeList[index]]));
                }),
          ),
        ]));
  }
}


class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

