import 'package:flutter/material.dart';
import 'package:bale_shop/provide/cart.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/api/home.dart';
import 'package:bale_shop/widgets/loadingDialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:bale_shop/widgets/cart/toast.dart';
import 'package:bale_shop/provide/currentIndex.dart';
import 'package:bale_shop/pages/tabs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:bale_shop/provide/footmark.dart';
class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetailPage> {
  Map arguments;
  List data = [];
  int num = 0;
  void initState() {
    arguments = widget.arguments;
    super.initState();
    orderQuerys(arguments["id"]).then((val) {
      var _num = 0;
      if (val.body.length > 0) {
        for (var x = 0; x < val.body[0].packageInfos.length; x++) {
          for (var i = 0;
              i < val.body[0].packageInfos[x].skuInfos.length;
              i++) {
            _num += int.parse(val.body[0].packageInfos[x].skuInfos[i].quantity);
          }
        }

        setState(() {
          data.add(val.body[0]);
          num = _num;
        });
      }
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

  payType(num) {
    String paymentTypeVal = "";
    switch (num) {
      case 1:
        paymentTypeVal = '貨到付款';
        break;
      case 2:
        paymentTypeVal = 'PayPal';
        break;
      case 3:
        paymentTypeVal = '信用卡支付';
        break;
    }
    return paymentTypeVal;
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    int catNum = Provide.value<CurrentIndexProvide>(context).catNum;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
            '订单详情',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: data.length > 0
            ? Stack(children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 40.5 + bottomPadding),
                    color: Color(0xFFF4F4F4),
                    child: ListView(children: <Widget>[
                      Column(children: <Widget>[
                        Container(
                            height: 82,
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
                              data.length > 0
                                  ? addressText(context, data[0].orderAddress)
                                  : Container(),
                              Image.asset(
                                "assets/images/address-bottom.png",
                                fit: BoxFit.cover,
                              ),
                            ])),
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
                                children: renderGoods(data[0].packageInfos))),
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
                                            "共${num}件商品，原價合計",
                                            style: TextStyle(
                                                fontSize: 13,
                                                height: 1,
                                                color: Color(0xFF777777)),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerRight,
                                          color: Colors.white,
                                          child: Text(
                                              "\$${doubleText(data[0].originalTotalPrice)}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  height: 1,
                                                  color: Color(0xFF777777))),
                                        ))
                                      ],
                                    )),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "運費",
                                            style: TextStyle(
                                                fontSize: 13,
                                                height: 1,
                                                color: Color(0xFF777777)),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerRight,
                                          color: Colors.white,
                                          child: Text("\$${doubleText(data[0].freight)}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  height: 1,
                                                  color: Color(0xFF777777))),
                                        ))
                                      ],
                                    )),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 11),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "優惠",
                                            style: TextStyle(
                                                fontSize: 13,
                                                height: 1,
                                                color: Color(0xFF777777)),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerRight,
                                          color: Colors.white,
                                          child: Text(
                                              "\$${doubleText(data[0].originalTotalPrice - data[0].discountTotalPrice - data[0].randomReductionPrice)}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  height: 1,
                                                  color: Color(0xFF777777))),
                                        ))
                                      ],
                                    )),
                                data[0].randomReductionPrice > 0
                                    ? Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 8, 0, 11),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                "隨機立減",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    height: 1,
                                                    color: Color(0xFF777777)),
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.centerRight,
                                              color: Colors.white,
                                              child: Text(
                                                  "\$${data[0].randomReductionPrice}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      height: 1,
                                                      color:
                                                          Color(0xFF777777))),
                                            ))
                                          ],
                                        ))
                                    : Container(),
                                MySeparator(
                                    height: 1, color: Color(0xFFEDEDED)),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerLeft,
                                          color: Colors.white,
                                          child: Text(
                                            "實際應付",
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1,
                                                color: Color(0xFF000000)),
                                          ),
                                        )),
                                        Container(
                                          child: Text("\$",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1,
                                                  color: Color(0xFFED1B2E))),
                                        ),
                                        Container(
                                          child: Text("${doubleText(data[0].totalPrice)}",
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  height: 1,
                                                  color: Color(0xFFED1B2E))),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
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
                                            "下單時間",
                                            style: TextStyle(
                                                fontSize: 13,
                                                height: 1,
                                                color: Color(0xFF777777)),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerRight,
                                          color: Colors.white,
                                          child: Text(
                                              data[0].createdAt.split(" G")[0],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  height: 1,
                                                  color: Color(0xFF777777))),
                                        ))
                                      ],
                                    )),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "付款方式",
                                            style: TextStyle(
                                                fontSize: 13,
                                                height: 1,
                                                color: Color(0xFF777777)),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerRight,
                                          color: Colors.white,
                                          child: Text(
                                              payType(data[0].paymentType),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  height: 1,
                                                  color: Color(0xFF777777))),
                                        ))
                                      ],
                                    )),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 14),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          child: Text(
                                            "訂單編號",
                                            style: TextStyle(
                                                fontSize: 13,
                                                height: 1,
                                                color: Color(0xFF777777)),
                                          ),
                                        )),
                                        GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: data[0].code));
                                              Toast.toast(context,
                                                  msg: "複製成功",
                                                  position:
                                                      ToastPostion.center);
                                            },
                                            child: Container(
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("複製 ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            height: 1,
                                                            color: Color(
                                                                0xFFED1B2E))),
                                                    Text(data[0].code,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            height: 1,
                                                            color: Color(
                                                                0xFF777777))),
                                                  ],
                                                )))
                                      ],
                                    )),
                              ],
                            )),
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
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50.5 + bottomPadding,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                              width: 0.5, color: Color(0xFFDFDEDB)), //有边框
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
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
                               String  cartInfoLast = Provide.value<CartProvide>(context).cartInfoLast;
                                List footList = Provide.value<FootMarkProvide>(context).footMarkList;
                              for (var x = 0;
                                  x < data[0].packageInfos.length;
                                  x++) {
                                for (var i = 0;
                                    i < data[0].packageInfos[x].skuInfos.length;
                                    i++) {
                                  var newGoods = {
                                    'productId': data[0]
                                        .packageInfos[x]
                                        .skuInfos[i]
                                        .productId,
                                    'productTitle': data[0]
                                        .packageInfos[x]
                                        .skuInfos[i]
                                        .productTitle,
                                    'quantity': data[0]
                                        .packageInfos[x]
                                        .skuInfos[i]
                                        .quantity,
                                    'productSkuId': data[0]
                                        .packageInfos[x]
                                        .skuInfos[i]
                                        .productSkuId,
                                    'productSkuBarcode': data[0]
                                        .packageInfos[x]
                                        .skuInfos[i]
                                        .productSkuBarcode,
                                    'productSkuName': data[0]
                                        .packageInfos[x]
                                        .skuInfos[i]
                                        .productSkuName,
                                    'productImageUrl': data[0]
                                        .packageInfos[x]
                                        .skuInfos[i]
                                        .productImageUrl,
                                    'isSelect': true,
                                    "discountPrice": data[0]
                                        .packageInfos[x]
                                        .skuInfos[i]
                                        .discountPrice,
                                    "shoppingType": 4
                                  };
                                  goodList.add(newGoods);
                                }
                              }
                              orderPrice({"orderProducts": goodList})
                                  .then((val) {
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
                                for (var i = 0;
                                    i < val.body.products.length;
                                    i++) {
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
                                  num += val.body.products[i].quantity;
                                }
                                Provide.value<CurrentIndexProvide>(context).changeCatNum(catNum + num);
                              
                                Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                                    Navigator.popUntil(context, ModalRoute.withName('/home')); 
                                }
                                

                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 6, 10, 6),
                              alignment: Alignment.center,
                              width: 100.0,
                              height: 38.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(25.0),
                                border: new Border.all(
                                    width: 1, color: Color(0xFFED1B2E)),
                              ),
                              child: Text(
                                '再次購買',
                                style: TextStyle(
                                    color: Color(0xFFED1B2E), fontSize: 16),
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ])
            : Container());
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

  List<Widget> renderGoods(goodData) {

    List dataList = [];

    for(var x=0;x<goodData.length;x++){
       if (goodData[x].skuInfos != null) {
        for (var i = 0; i < goodData[x].skuInfos.length; i++) {
          bool dataLock = true;
          for(var y=0;y<dataList.length;y++){
            if(dataList[y].productId == goodData[x].skuInfos[i].productId && dataList[y].productSkuId == goodData[x].skuInfos[i].productSkuId  && dataList[y].discountPrice == goodData[x].skuInfos[i].discountPrice){
              dataLock = false;
              dataList[y].cancelProductCount = (int.parse(dataList[y].cancelProductCount) + int.parse(goodData[x].skuInfos[i].cancelProductCount)).toString();
              dataList[y].quantity = (int.parse(dataList[y].quantity) + int.parse(goodData[x].skuInfos[i].quantity)).toString();
            }
          }
          if(dataLock){
            dataList.add(goodData[x].skuInfos[i]);
          }
        }
       }
    }

    List<Widget> goods = [];
    for (var x = 0; x < dataList.length; x++) {
          goods.add(Container(
              margin: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 12),
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/detail",
                              arguments: {
                                "id": dataList[x].productId
                              });
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
                              imageUrl: "http:" +
                                  dataList[x].productImageUrl,
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
                                      dataList[x].productTitle,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    child: Text(
                                        dataList[x].productSkuName),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 22, 0, 0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 80,
                                          child: Text(
                                              "\$${doubleText(double.parse(dataList[x].discountPrice))}",
                                              style: TextStyle(
                                                  height: 1,
                                                  color: Color(0xFFED1B2E),
                                                  fontSize: 14)),
                                        ),
                                        Expanded(
                                          child: Container(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "x${dataList[x].quantity}",
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
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  (dataList[x].saleServiceIn != "0" ||
                          dataList[x].saleServicePass != "0" ||
                          dataList[x].saleServiceReject != "0")
                      ? Container(
                          padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color:
                                  dataList[x].saleServiceIn != "0"
                                      ? Color(0xFFFF9300)
                                      : Color(0xFF22AB39),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("/afterSalesList", arguments: {
                                "id": data[0].code,
                              });
                            },
                            child: Row(children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                      dataList[x].saleServiceIn !=
                                              "0"
                                          ? "售後審核中"
                                          : "售後已完成",
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 13,
                                          height: 1))),
                              Container(
                                margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  "assets/icons/icon-back-right.png",
                                  width: 6,
                                  height: 10,
                                  color: Color(0xFFFFFFFF),
                                ),
                              )
                            ]),
                          ))
                      : Container(),
                 int.parse( dataList[x].cancelProductCount) != 0
                      ? Container(
                          padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                          decoration: BoxDecoration(
                              color: Color(0xFF777777),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Text(
                              dataList[x].cancelProductCount == dataList[x].quantity
                                  ? "已取消"
                                  : "${dataList[x].cancelProductCount}件已取消",
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 13,
                                  height: 1)))
                      : Container(),
                ]),
                   dataList[x].isLimitProduct != null &&  dataList[x].isLimitProduct == "true"
                      ? Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                              child: Image.asset(
                                "assets/icons/icon-heed.png",
                                width: 12,
                                height: 12,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(4, 12, 0, 0),
                              child: Text(
                                '限量出清，不可退換',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFED1B2E),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
              ])));
       
    }

    return goods;
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
