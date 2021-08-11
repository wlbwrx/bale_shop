import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bale_shop/api/home.dart';
import 'package:bale_shop/widgets/cart/toast.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:bale_shop/pages/product_page/productType.dart';
import 'package:bale_shop/widgets/loadingDialog.dart';
import 'package:image_picker/image_picker.dart';

import 'package:city_pickers/city_pickers.dart';
import 'package:bale_shop/widgets/pick/province.dart' as province;

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class AfterSales extends StatefulWidget {
  AfterSales({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _AfterSalesState createState() => _AfterSalesState();
}

class _AfterSalesState extends State<AfterSales> {
  int stepIndex = 1;
  Map arguments;
  List optionalList = [];
  List noOptionalList = [];
  List numList = [];
  List checkList = [];
  List messageList = [];
  List imgList = [];
  List cardImgList = [];
  List question = [];
  FocusNode blankNode = FocusNode();

  String accountName = "";
  String accountBank = "";
  String accountNumber = "";
  String accountInfo = "";

  List serviceList = [];

  List reasonListText = [
    ["尺碼太大", "尺碼太小"],
    ["色差太大", "與圖片不符合"],
    ["材質/質量太差", "有瑕疵/髒污/有異味", "穿著不適", "商品損壞"],
    ["包裹破損", "漏發/錯發", "簽錯包裹"],
    ["不喜歡", "效果差", "等待時間久"]
  ];

  List reasonListCheckAll = [];
  List reasonListCheckOne = [];

  void initState() {
    arguments = widget.arguments;

    if (arguments["id"] != null) {
      saleservice(arguments["id"]).then((val) {
        print(val.body.handleStatus);
        setState(() {
          if (val.body.handleStatus == 20 || val.body.handleStatus == -10) {
            stepIndex = 5;
          } else {
            stepIndex = 4;
          }
          serviceList.add(val.body);
        });
      });
    } else {
      saleserviceDelivery(
              "${widget.arguments["data"].deliveryCode}/${widget.arguments["code"]}")
          .then((val) {
        List serviceData = [];
        List noServiceData = [];
        val.body.saleServiceModules.forEach((e) {
          e.afterSaleServiceProducts.forEach((_e) {
            if (_e.handleStatus != -20 && _e.handleStatus != -10) {
              serviceData.add(_e);
            }
          });
        });
        serviceData.forEach((serviceSku) {
          for (var i = 0; i < val.body.deliveryProducts.length; i++) {
            if (serviceSku.sourceProductSkuId ==
                val.body.deliveryProducts[i].productSkuId) {
              if (val.body.deliveryProducts[i].deliveryQuantity ==
                  serviceSku.quantity) {
                noServiceData.add({
                  "createdAt": val.body.deliveryProducts[i].createdAt,
                  "createdBy": val.body.deliveryProducts[i].createdBy,
                  "deliveryCode": val.body.deliveryProducts[i].deliveryCode,
                  "deliveryId": val.body.deliveryProducts[i].deliveryId,
                  "deliveryQuantity":
                      val.body.deliveryProducts[i].deliveryQuantity,
                  "id": val.body.deliveryProducts[i].id,
                  "orderCode": val.body.deliveryProducts[i].orderCode,
                  "orderId": val.body.deliveryProducts[i].orderId,
                  "orderProductId": val.body.deliveryProducts[i].orderProductId,
                  "productId": val.body.deliveryProducts[i].productId,
                  "productSkuBarcode":
                      val.body.deliveryProducts[i].productSkuBarcode,
                  "productSkuId": val.body.deliveryProducts[i].productSkuId,
                  "productSkuName": val.body.deliveryProducts[i].productSkuName,
                  "productSkuPrice":
                      val.body.deliveryProducts[i].productSkuPrice,
                  "productTitle": val.body.deliveryProducts[i].productTitle,
                  "status": val.body.deliveryProducts[i].status,
                  "updatedAt": val.body.deliveryProducts[i].updatedAt,
                  "updatedBy": val.body.deliveryProducts[i].updatedBy,
                  "productSkuImage":
                      val.body.deliveryProducts[i].productSkuImage,
                  "productStatus": val.body.deliveryProducts[i].productStatus
                });
                val.body.deliveryProducts.removeAt(i);
              } else {
                noServiceData.add({
                  "createdAt": val.body.deliveryProducts[i].createdAt,
                  "createdBy": val.body.deliveryProducts[i].createdBy,
                  "deliveryCode": val.body.deliveryProducts[i].deliveryCode,
                  "deliveryId": val.body.deliveryProducts[i].deliveryId,
                  "deliveryQuantity": serviceSku.quantity,
                  "id": val.body.deliveryProducts[i].id,
                  "orderCode": val.body.deliveryProducts[i].orderCode,
                  "orderId": val.body.deliveryProducts[i].orderId,
                  "orderProductId": val.body.deliveryProducts[i].orderProductId,
                  "productId": val.body.deliveryProducts[i].productId,
                  "productSkuBarcode":
                      val.body.deliveryProducts[i].productSkuBarcode,
                  "productSkuId": val.body.deliveryProducts[i].productSkuId,
                  "productSkuName": val.body.deliveryProducts[i].productSkuName,
                  "productSkuPrice":
                      val.body.deliveryProducts[i].productSkuPrice,
                  "productTitle": val.body.deliveryProducts[i].productTitle,
                  "status": val.body.deliveryProducts[i].status,
                  "updatedAt": val.body.deliveryProducts[i].updatedAt,
                  "updatedBy": val.body.deliveryProducts[i].updatedBy,
                  "productSkuImage":
                      val.body.deliveryProducts[i].productSkuImage,
                  "productStatus": val.body.deliveryProducts[i].productStatus
                });
                val.body.deliveryProducts[i].deliveryQuantity =
                    val.body.deliveryProducts[i].deliveryQuantity -
                        serviceSku.quantity;
              }
            }
          }
        });
        for (var i = 0; i < val.body.deliveryProducts.length; i++) {
          val.body.deliveryProducts[i].sourceProductSkuId =
              val.body.deliveryProducts[i].productSkuId;
        }
        setState(() {
          optionalList = val.body.deliveryProducts;
          for (var i = 0; i < val.body.deliveryProducts.length; i++) {
            numList.add(val.body.deliveryProducts[i].deliveryQuantity);
            checkList.add(false);
            imgList.add([]);
            question.add("");
            messageList.add("");
            reasonListCheckAll.add([]);
            reasonListCheckOne.add("");
          }
          noOptionalList = noServiceData;
          print(noOptionalList);
        });
      });
    }

    super.initState();
  }

  showIndex(context, index) async {
    Result temp = await CityPickers.showCityPicker(
      context: context,
      showType: ShowType.p,
      provincesData: province.questionData,
      citiesData: province.questionData1,
      height: 200,
    );
    if (temp != null) {
      province.questionData.forEach((String key, String value) {
        if (value == temp.provinceName) {
          setState(() {
            reasonListCheckAll[index] = reasonListText[int.parse(key)];
          });
        }
      });
      setState(() {
        question[index] = temp.provinceName;
      });
    }
  }

  Future getImage(index) async {
    FocusScope.of(context).requestFocus(blankNode);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _upLoadImage(image, index);
    }
  }

  _upLoadImage(File image, index) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: "正在上傳中…",
          );
        });
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);

    FormData formData = FormData.fromMap({"images": await MultipartFile.fromFile(path, filename: name)});

    upImgSaleservice(formData).then((val) {
      Navigator.pop(context);
      if (index == 10000) {
        setState(() {
          cardImgList.add(val);
        });
      } else {
        setState(() {
          imgList[index].add(val);
        });
      }
    });
  }

  List<Widget> renderGoods(data) {
    List<Widget> goods = [];

    for (var i = 0; i < data.length; i++) {
      goods.add(Container(
        margin: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 12),
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Row(
          children: <Widget>[
            arguments["type"] == 20 && data[i].productStatus != 10
                ? Column(
                    children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                          decoration: BoxDecoration(
                            color: Color(0xFFBCBCBC),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Text("已下架",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white))),
                      Container(
                          child: Text("不可換",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFFED1B2E)))),
                      Container(
                          child: Text("可退款",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFFED1B2E)))),
                    ],
                  )
                : Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: _cartCheckBt(context, checkList[i], i)),
            Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  imageUrl: "http:" + data[i].productSkuImage,
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
                              data[i].productTitle,
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
                            child: Text(data[i].productSkuName),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: Text("\$${data[i].productSkuPrice}",
                                      style:
                                          TextStyle(height: 1, fontSize: 14)),
                                )),
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black12),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        _reduceBtn(context, data[i], i),
                                        _countArea(data[i].deliveryQuantity),
                                        _addBtn(context, data[i], i)
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ])))
          ],
        ),
      ));
    }

    return goods;
  }

  productNum(data) {
    int num = 0;
    for (var i = 0; i < data.afterSaleServiceProducts.length; i++) {
      num += data.afterSaleServiceProducts[i].quantity;
    }
    return num;
  }

  Widget rederSaleserviceText(state_data) {
    List<Widget> widgetList = [];
    List<Widget> widgetList1 = [];
    String serviceTypeText = "退貨退款";
    String firstText = "";
    String firstImg = "";
    String secondText = "";

    var today = DateTime.parse(
        state_data.updatedAt.substring(0, 19).replaceAll(" ", "T"));
    var fiftyDaysFromNow = today.add(new Duration(days: 10));
    var nowText =
        "${fiftyDaysFromNow.year}.${fiftyDaysFromNow.month}.${fiftyDaysFromNow.day}";
    var fiftyDaysFromEnd = today.add(new Duration(days: 15));
    var endText =
        "${fiftyDaysFromEnd.year}.${fiftyDaysFromEnd.month}.${fiftyDaysFromEnd.day}";

    if (state_data.serviceType == 20) {
      serviceTypeText = "換貨";
    }
    if (state_data.handleStatus == 10) {
      firstImg = "assets/icons/icon-after_sale-application-success.png";
      firstText = "申請提交成功";
      secondText = "申請已成功提交，客服MM將盡快幫您處理，請耐心等待";
    } else if (state_data.handleStatus == 20) {
      firstImg = "assets/icons/icon-after_sale-application-success.png";
      firstText = serviceTypeText + "申請通過";
      secondText = "申請已成功受理。";
    } else if (state_data.handleStatus == -10) {
      firstImg = "assets/icons/icon-after_sale-application-failure.png";
      firstText = "申請未通過審核。";
    } else if (state_data.handleStatus == -20) {
      firstImg = "assets/icons/icon-after_sale-application-cancel.png";
      firstText = "撤銷申請成功";
      secondText = "申請已成功撤銷";
    }

    widgetList.add(Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: Row(
          children: [
            Container(
              child: Image.asset(
                firstImg,
                fit: BoxFit.cover,
                width: 20,
                height: 20,
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                child: Text(firstText,
                    style: TextStyle(fontSize: 18, color: Color(0xFF222222))))
          ],
        )));

    widgetList.add(Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(12, 16, 12, 8),
        child: Text(
          "${state_data.createdAt.substring(0, 19)}",
          style: TextStyle(fontSize: 12, color: Color(0xFF777777)),
        )));

    if (state_data.handleStatus == -10) {
      widgetList.add(Container(
          color: Colors.white,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(12, 0, 12, 18),
          child: Text(
            "很抱歉，您以下商品的${serviceTypeText}${secondText}",
            style: TextStyle(fontSize: 14, color: Color(0xFF222222)),
          )));

      widgetList.add(Container(
          color: Colors.white,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(12, 0, 12, 18),
          child: Column(children: [
            Row(children: [Container(child: Text("理由如下:"))]),
            state_data.serviceCustomerMsgs != null &&
                    state_data.serviceCustomerMsgs != ''
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text("${state_data.serviceCustomerMsgs}"))
                : Container(),
            state_data.serviceCustomerImgs != null &&
                    state_data.serviceCustomerImgs != ''
                ? Column(
                    children: renderImgs(state_data.serviceCustomerImgs),
                  )
                : Container(),
            Row(children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("如有疑問請聯繫客服"))
            ]),
          ])));
    } else {
      widgetList.add(Container(
          color: Colors.white,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(12, 0, 12, 18),
          child: Text(
            "您以下商品的${serviceTypeText}${secondText}",
            style: TextStyle(fontSize: 14, color: Color(0xFF222222)),
          )));
    }

    if (state_data.serviceType == 10) {
      if (state_data.handleStatus == 10) {
        widgetList.add(Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        text: TextSpan(
                            text: '共${productNum(state_data)}件商品，预计退款',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF222222)),
                            children: <TextSpan>[
                          TextSpan(
                              text: ' \$${state_data.saleServiceTotalPrice}',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFFED1B2E))),
                        ]))),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Text(
                      "實際退款以官方最終審核結果為準",
                      style: TextStyle(fontSize: 12, color: Color(0xFF777777)),
                    )),
              ],
            )));
      }

      if (state_data.handleStatus == 20) {
        widgetList.add(Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 20),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        text: TextSpan(
                            text: '商品退款',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF222222)),
                            children: <TextSpan>[
                          TextSpan(
                              text: ' \$${state_data.saleServiceTotalPrice}',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFFED1B2E))),
                          state_data.paymentType == 1
                              ? TextSpan(
                                  text: '將在10天左右退回您的預留銀行賬戶，請注意查收',
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF222222)))
                              : TextSpan(
                                  text: '將在20天左右返回您的原支付賬薄，請注意查收',
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF222222))),
                        ]))),
                state_data.paymentType == 1
                    ? Container(
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F4F4),
                          border: new Border.all(
                              width: 1, color: Color(0xFFDFDEDB)),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          children: [
                            Container(child: Text(state_data.accountName)),
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(24, 0, 0, 0),
                                    child: Text(state_data.accountBank))),
                            Container(child: Text(state_data.accountInfo)),
                          ],
                        ))
                    : Container()
              ],
            )));
      }
    }

    if (state_data.handleStatus == 10) {
      widgetList.add(Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return new AlertDialog(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                              "確定要撤銷此申請吗?",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF222222),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          content: Container(
                              height: 80,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return new LoadingDialog(
                                                      text: "申請撤銷中…",
                                                    );
                                                  });
                                              var cancelData = {
                                                "id": state_data.id,
                                                "serviceSource": 40,
                                                "deliveryCode":
                                                    state_data.deliveryCode
                                              };
                                              saleserviceCancel(cancelData)
                                                  .then((val) {
                                                Navigator.pop(context);
                                                setState(() {
                                                  serviceList.clear();
                                                });
                                                saleservice(state_data.id)
                                                    .then((v) {
                                                  setState(() {
                                                    if (v.body.handleStatus ==
                                                            20 ||
                                                        v.body.handleStatus ==
                                                            -10) {
                                                      stepIndex = 5;
                                                    } else {
                                                      stepIndex = 4;
                                                    }
                                                    serviceList.add(v.body);
                                                  });
                                                });
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 26, 5, 0),
                                              alignment: Alignment.center,
                                              width: 120.0,
                                              height: 38.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                border: new Border.all(
                                                    width: 1,
                                                    color: Colors.red),
                                              ),
                                              child: Text(
                                                '確定撤銷',
                                                style: TextStyle(
                                                    color: Color(0xFFED1B2E),
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          flex: 1),
                                      Expanded(
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 26, 0, 0),
                                                    alignment: Alignment.center,
                                                    width: 120.0,
                                                    height: 38.0,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: Color(0xFFED1B2E),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      border: new Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xFFED1B2E)),
                                                    ),
                                                    child: Text(
                                                      '再考慮一下',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ))),
                                          flex: 1),
                                    ],
                                  )
                                ],
                              )),
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(width: 1, color: Color(0xFFDFDEDB)),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text("撤銷申請"),
                ),
              )
            ],
          )));
    }

    if (state_data.serviceType == 10) {
      widgetList1.add(Container(
        child: Column(
            children: renderGoods0(serviceList.length > 0
                ? serviceList[0].afterSaleServiceProducts
                : [])),
      ));
    }

    if (state_data.serviceType == 20) {
      if (state_data.newOrderCode != null && state_data.newOrderCode != "") {
        widgetList.add(Container(
            padding: EdgeInsets.fromLTRB(12, 15, 0, 0),
            color: Colors.white,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        child: Text("新的換貨訂單號：${state_data.newOrderCode}")),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: state_data.newOrderCode));
                        Toast.toast(context,
                            msg: "複製成功", position: ToastPostion.center);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                        margin: EdgeInsets.fromLTRB(8, 0, 4, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
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
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                        child: Text("預計送達時間${nowText}-${endText}"))
                  ],
                )
              ],
            )));
      }

      widgetList1.add(Container(
        child: Column(
            children: renderGoods6(serviceList.length > 0
                ? serviceList[0].afterSaleServiceProducts
                : [])),
      ));
    }
    return Column(children: [
      ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          child: Column(children: widgetList)),
      state_data.serviceType == 20
          ? Container(
              padding: EdgeInsets.fromLTRB(12, 15, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                "更换商品列表",
                style: TextStyle(fontSize: 18, color: Color(0xFF222222)),
              ))
          : Container(),
      Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Column(children: widgetList1))),
    ]);
  }

  List<Widget> renderImgs(data) {
    List<Widget> imgList = [];

    for (var i = 0; i < data.split(',').length; i++) {
      imgList.add(
        Container(
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
              imageUrl: "http:" + data.split(',')[i],
              errorWidget: (context, url, error) => Image.asset(
                'assets/icons/placeholder.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }

    return imgList;
  }

  List<Widget> renderGoods6(data) {
    List<Widget> goods = [];
    for (var i = 0; i < data.length; i++) {
      goods.add(
        Container(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            color: Colors.white,
            child: Column(children: <Widget>[
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                      child: Text("商品名：${data[i].sourceProductTitle}",
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF777777))))
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: <Widget>[
                          Container(
                            height: 120,
                            width: 120,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                imageUrl:
                                    "http:" + data[i].sourceProductSkuImage,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/icons/placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          data[i].quantity != 1
                              ? Positioned(
                                  top: 90,
                                  right: 0,
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
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container()
                        ]),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 120,
                          color: Color(0xFFF9F9F9),
                          margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          padding: EdgeInsets.fromLTRB(0, 6, 6, 6),
                          child: Text(data[i].sourceProductSkuName,
                              style: TextStyle(color: Color(0xFF222222))),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Text("\$${data[i].sourceDiscountPrice}"))
                      ]),
                  Expanded(
                      child: Container(
                          height: 120,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Image.asset(
                                      'assets/icons/icon-sku_exchange.png',
                                      fit: BoxFit.cover,
                                      color: Color(0xFFBCBCBC),
                                      width: 27,
                                      height: 24,
                                    )),
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: Text("更換為",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFFBCBCBC))))
                              ]))),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: <Widget>[
                          Container(
                            height: 120,
                            width: 120,
                            margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
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
                                imageUrl: "http:" + data[i].productSkuImage,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/icons/placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          data[i].quantity != 1
                              ? Positioned(
                                  top: 90,
                                  right: 12,
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
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container()
                        ]),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 120,
                          color: Color(0xFFF9F9F9),
                          margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          padding: EdgeInsets.fromLTRB(0, 6, 6, 6),
                          child: Text(data[i].productSkuName,
                              style: TextStyle(color: Color(0xFF222222))),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Text("\$${data[i].discountPrice}"))
                      ]),
                ],
              ),
            ])),
      );
    }
    return goods;
  }

  List<Widget> renderGoods0(data) {
    List<Widget> goods = [];
    goods.add(Container(
        padding: EdgeInsets.fromLTRB(12, 15, 0, 0),
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Text(
          "退貨商品列表",
          style: TextStyle(fontSize: 18, color: Color(0xFF222222)),
        )));
    for (var i = 0; i < data.length; i++) {
      goods.add(
        Container(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
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
                                data[i].sourceProductTitle,
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
                              padding: EdgeInsets.fromLTRB(0, 6, 6, 6),
                              child: Text(data[i].sourceProductSkuName,
                                  style: TextStyle(color: Color(0xFF222222))),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    child: Text(
                                        "\$${data[i].sourceDiscountPrice}",
                                        style: TextStyle(
                                            height: 1,
                                            color: Color(0xFF222222),
                                            fontSize: 14)),
                                  )),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: Text(
                                      "x${data[i].quantity}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: Color(0xFF777777),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ])))
            ],
          ),
        ),
      );
    }
    return goods;
  }

  List<Widget> reasonList(data, checkIndex) =>
      List.generate(data.length, (index) {
        return data[index] != reasonListCheckOne[checkIndex]
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    reasonListCheckOne[checkIndex] = data[index];
                  });
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                    ),
                    child: Text(
                      data[index],
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF222222)),
                    )))
            : GestureDetector(
                onTap: () {
                  setState(() {
                    reasonListCheckOne[checkIndex] = "";
                  });
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(11, 5, 11, 5),
                    margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
                    decoration: BoxDecoration(
                        color: Color(0xFFFDE8EA),
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        border:
                            new Border.all(width: 1, color: Color(0xFFED1B2E))),
                    child: Text(
                      data[index],
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFED1B2E)),
                    )));
      });

  List<Widget> renderGoods1(data) {
    List<Widget> goods = [];
    goods.add(Container(
        padding: EdgeInsets.fromLTRB(12, 15, 0, 13),
        color: Color(0xFFFFFCEE),
        alignment: Alignment.centerLeft,
        child: Text(
          "以下商品正在售後處理中，無法重複操作",
          style: TextStyle(fontSize: 12, color: Color(0xFFA59672)),
        )));
    for (var i = 0; i < data.length; i++) {
      goods.add(Container(
        margin: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Row(
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
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
                  imageUrl: data[i]["productSkuImage"] != null
                      ? "http:" + data[i]["productSkuImage"]
                      : data[i].productSkuImage,
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
                              data[i]["productTitle"] != null
                                  ? data[i]["productTitle"]
                                  : data[i].productTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1,
                                fontSize: 12,
                                color: Color(0x80777777),
                              ),
                            ),
                          )),
                          Container(
                            padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                            decoration: BoxDecoration(
                                color: Color(0x80F9F9F9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            child: Text(
                                data[i]["productSkuName"] != null
                                    ? data[i]["productSkuName"]
                                    : data[i].productSkuName,
                                style: TextStyle(color: Color(0x80222222))),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: Text(
                                      "\$${data[i]["productSkuPrice"] != null ? data[i]["productSkuPrice"] : data[i].productSkuPrice}",
                                      style: TextStyle(
                                          height: 1,
                                          color: Color(0x80222222),
                                          fontSize: 14)),
                                )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                  child: Text(
                                    "x${data[i]["deliveryQuantity"] != null ? data[i]["deliveryQuantity"] : data[i].deliveryQuantity}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1,
                                      color: Color(0x80777777),
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

    return goods;
  }

  List<Widget> renderGoods2(context, data) {
    List<Widget> goods = [];

    for (var i = 0; i < data.length; i++) {
      if (checkList[i]) {
        goods.add(Container(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              color: Color(0xFFFFFCEE),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
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
                        imageUrl: "http:" + data[i].productSkuImage,
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
                                    data[i].productTitle,
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
                                  padding: EdgeInsets.fromLTRB(0, 6, 6, 6),
                                  child: Text(data[i].productSkuName,
                                      style:
                                          TextStyle(color: Color(0xFF222222))),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 12, 0, 0),
                                        child: Text(
                                            "\$${data[i].productSkuPrice}",
                                            style: TextStyle(
                                                height: 1,
                                                color: Color(0xFF222222),
                                                fontSize: 14)),
                                      )),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 16, 0, 0),
                                        child: Text(
                                          "x${data[i].deliveryQuantity}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                            color: Color(0xFF777777),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ])))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showIndex(context, i);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
                padding: EdgeInsets.only(left: 12),
                height: 40,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Color(0xFFBCBCBC)),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        question[i] != "" ? question[i] : "请选择售后原因",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF222222)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Image.asset(
                        'assets/icons/icon-page-arrow-down-detail-grey.png',
                        fit: BoxFit.cover,
                        width: 10,
                        height: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            question[i] != ""
                ? Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text("請選擇準確理由"))
                : Container(),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Container(
                    child: Wrap(
                  spacing: 2, //主轴上子控件的间距
                  runSpacing: 5, //交叉轴上子控件之间的间距
                  children: reasonList(reasonListCheckAll[i], i), //要显示的子控件集合
                ))),
            Container(
                margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Container(
                  height: 110,
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border.all(width: 1, color: Color(0xFFBCBCBC)),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        enableInteractiveSelection: false,
                        maxLength: 100,
                        onChanged: (v) {
                          setState(() {
                            messageList[i] = v;
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: "",
                        ),
                        maxLines: 3,
                      )
                    ],
                  ),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(12, 6, 12, 12),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: Text(
                        "上傳商品展開實拍圖(最多8張)",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF222222)),
                      ),
                    )),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed("/examples", arguments: {"type": 1});
                        },
                        child: Container(
                          child: Row(children: [
                            Container(
                                child: Text(
                              "示例圖片",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF007AFF)),
                            )),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'assets/icons/icon-page-arrow-detail-blue.png',
                                fit: BoxFit.cover,
                                width: 6,
                                height: 10,
                              ),
                            ),
                          ]),
                        ))
                  ],
                )),
            getBBWidget(context, i)
          ],
        )));
      }
    }
    return goods;
  }

  List<Widget> renderProductImg(index) {
    List<Widget> productImg = [];
    if (index == 10000) {
      for (var i = 0; i < cardImgList.length; i++) {
        productImg.add(Container(
            child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  imageUrl: "https:" + cardImgList[i],
                )),
          ),
          Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    cardImgList.removeAt(i);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    'assets/icons/icon-after_sale-application-failure.png',
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                ),
              ))
        ])));
      }
      if (cardImgList.length < 2) {
        productImg.add(GestureDetector(
          onTap: () {
            getImage(index);
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Image.asset(
                'assets/icons/icon-upload.png',
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              )),
        ));
      }
    } else {
      for (var i = 0; i < imgList[index].length; i++) {
        productImg.add(Container(
            child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  imageUrl: "https:" + imgList[index][i],
                )),
          ),
          Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    imgList[index].removeAt(i);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    'assets/icons/icon-after_sale-application-failure.png',
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                ),
              ))
        ])));
      }
      if (imgList[index].length < 8) {
        productImg.add(GestureDetector(
          onTap: () {
            getImage(index);
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Image.asset(
                'assets/icons/icon-upload.png',
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              )),
        ));
      }
    }

    return productImg;
  }

  void onChangProductSku(val, index) {
    setState(() {
      optionalList[index].productSkuId = val["productSkuId"];
      optionalList[index].productSkuBarcode = val["productSkuBarcode"];
      optionalList[index].productSkuName = val["productSkuName"];
      optionalList[index].productSkuImage = val["productSkuImage"];
      optionalList[index].productSkuPrice = val["productSkuPrice"];
      optionalList[index].discountPrice = val["discountPrice"];
      optionalList[index].originalPrice = val["originalPrice"];
    });
  }

  List<Widget> renderGoods3(context, data) {
    List<Widget> goods = [];
    goods.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
      child: Text("請選擇要更換的商品規格",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
    ));
    for (var i = 0; i < data.length; i++) {
      if (checkList[i]) {
        goods.add(Container(
          color: Colors.white,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl: "https:" + data[i].productSkuImage,
                    )),
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return new LoadingDialog(
                                        text: "商品加載中…",
                                      );
                                    });
                                productSku(data[i].productId).then((val) {
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
                                      return ProductType(
                                          data: [val.body],
                                          type: '0',
                                          isLimitProduct: false,
                                          callBack: (value) =>
                                              onChangProductSku(value, i));
                                    },
                                  );
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4F4F4),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    topLeft: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data[i].productSkuName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF222222)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 12),
                                      child: Image.asset(
                                        'assets/icons/icon-page-arrow-down-detail-grey.png',
                                        fit: BoxFit.cover,
                                        width: 10,
                                        height: 6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    child: Text("\$${data[i].productSkuPrice}",
                                        style: TextStyle(
                                            height: 1,
                                            color: Color(0xFF222222),
                                            fontSize: 14)),
                                  )),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: Text(
                                      "x${data[i].deliveryQuantity}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: Color(0xFF777777),
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

  void _fb() async {
    String url = "https://m.facebook.com/messages/thread/963546037190008";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('不能访问');
    }
  }

  Widget getBBWidget(context, index) {
    var screenW = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      width: screenW,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Wrap(
                spacing: 10.0, // 主轴(水平)方向间距
                runSpacing: 10.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.start, //模式
                children: renderProductImg(index)),
          )
        ],
      ),
    );
  }

  Widget _cartCheckBt(context, item, index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checkList[index] = !item;
        });
      },
      child: Container(
          child: item
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
    );
  }

  //减少按钮
  Widget _reduceBtn(context, item, index) {
    return InkWell(
      onTap: () {
        if (item.deliveryQuantity > 1) {
          setState(() {
            optionalList[index].deliveryQuantity--;
          });
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(32),
        height: ScreenUtil().setHeight(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          '-',
          style: TextStyle(
              color: item.deliveryQuantity <= 1 ? Colors.black12 : Colors.black,
              fontSize: 24),
        ),
      ),
    );
  }

  //加号按钮
  Widget _addBtn(context, item, index) {
    return InkWell(
      onTap: () {
        if (item.deliveryQuantity < numList[index]) {
          setState(() {
            optionalList[index].deliveryQuantity++;
          });
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(32),
        height: ScreenUtil().setHeight(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          '+',
          style: TextStyle(
              color: item.deliveryQuantity == numList[index]
                  ? Colors.black12
                  : Colors.black,
              fontSize: 20),
        ),
      ),
    );
  }

  //中间数量显示区域

  Widget _countArea(quantity) {
    return Container(
      width: ScreenUtil().setWidth(54),
      height: ScreenUtil().setHeight(32),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '${quantity}',
        style: TextStyle(fontSize: 17),
      ),
    );
  }

  checkNum() {
    var isNum = 0;
    for (var i = 0; i < optionalList.length; i++) {
      if (checkList[i]) {
        isNum += optionalList[i].deliveryQuantity;
      }
    }
    return isNum;
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(20, 24, 20, 10),
                        child: Image.asset(
                          'assets/icons/icon-back-light.png',
                          width: 20,
                          height: 20,
                          color: Colors.black,
                        ),
                      )),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                stepIndex >= 1
                                    ? Container(
                                        width: 16,
                                        height: 16,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFED1B2E),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            Container(
                                width: stepIndex == 5
                                    ? 69
                                    : stepIndex == 4
                                        ? 69
                                        : 72,
                                height: 3,
                                color: stepIndex > 3
                                    ? Color(0xFFED1B2E)
                                    : Color(0xFFFDE8EA)),
                            Column(
                              children: [
                                stepIndex >= 4
                                    ? Container(
                                        width: 16,
                                        height: 16,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFED1B2E),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        child: Text(
                                          "2",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                      )
                                    : Container(
                                        width: 10,
                                        height: 10,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFDE8EA),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                              ],
                            ),
                            Container(
                                width: stepIndex == 5
                                    ? 69
                                    : stepIndex == 4
                                        ? 75
                                        : 80,
                                height: 3,
                                color: stepIndex > 4
                                    ? Color(0xFFED1B2E)
                                    : Color(0xFFFDE8EA)),
                            Column(
                              children: [
                                stepIndex >= 5
                                    ? Container(
                                        width: 16,
                                        height: 16,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFED1B2E),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        child: Text(
                                          "3",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                      )
                                    : Container(
                                        width: 10,
                                        height: 10,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFDE8EA),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                              ],
                            )
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 3),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: 60,
                                    child: Text(
                                      "提交申請",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF777777)),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: stepIndex == 3
                                        ? 91
                                        : stepIndex == 2
                                            ? 91
                                            : 95,
                                    child: Text(
                                      "官方審核",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF777777)),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: 60,
                                    child: Text(
                                      arguments["type"] == 10 ? "完成退貨" : "完成換貨",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF777777)),
                                    ),
                                  ),
                                ]))
                      ],
                    ),
                  )),
                  GestureDetector(
                      onTap: () {
                        _fb();
                      },
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.fromLTRB(20, 24, 20, 10),
                        child: Image.asset(
                          'assets/icons/customer-service.png',
                          width: 24,
                          height: 24,
                        ),
                      )),
                ],
              ),
            )),
        body: GestureDetector(
            onTap: () {
              // 点击空白页面关闭键盘
              FocusScope.of(context).requestFocus(blankNode);
            },
            child: Stack(children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  margin: EdgeInsets.fromLTRB(0, 0, 0,
                      optionalList.length > 0 ? 40.5 + bottomPadding : 0),
                  color: Color(0xFFF4F4F4),
                  child: stepIndex == 1
                      ? ListView(children: <Widget>[
                          optionalList.length > 0
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
                                  child: Text(
                                      "選擇要${arguments["type"] == 10 ? "退" : "換"}的商品和數量",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500)),
                                )
                              : Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top:50),
                                child: Text("没有可以${arguments["type"] == 10 ? "退" : "換"}的商品"),
                              ),
                          optionalList.length > 0
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                      children: renderGoods(optionalList)))
                              : Container(),
                          noOptionalList.length > 0
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(0,
                                      optionalList.length > 0 ? 10 : 0, 0, 20),
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
                                      children: renderGoods1(noOptionalList)))
                              : Container()
                        ])
                      : stepIndex == 2
                          ? ListView(children: <Widget>[
                              optionalList.length > 0
                                  ? Container(
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
                                          children: renderGoods2(
                                              context, optionalList)))
                                  : Container(),
                            ])
                          : stepIndex == 3 && arguments["type"] == 10
                              ? ListView(children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
                                    child: Text("填写接收退款的银行账簿",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      padding:
                                          EdgeInsets.fromLTRB(12, 0, 12, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: Column(children: [
                                        new TextFormField(
                                            enableInteractiveSelection: false,
                                            onChanged: (v) {
                                              setState(() {
                                                accountName = v;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: "戶名",
                                              hintText: "請輸入您的戶名，如：張xx",
                                              hasFloatingPlaceholder: false,
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color:
                                                              Color(0xFFBCBCBC),
                                                          style: BorderStyle
                                                              .solid)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color:
                                                              Color(0xFFBCBCBC),
                                                          style: BorderStyle
                                                              .solid)),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 0,
                                                      color: Color(0xFFED1B2E),
                                                      style:
                                                          BorderStyle.solid)),
                                            )),
                                        new TextFormField(
                                            //设置键盘类型
                                            enableInteractiveSelection: false,
                                            onChanged: (v) {
                                              setState(() {
                                                accountBank = v;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: "開戶行及分行",
                                              hintText: "開戶行及分行名稱，如：xx銀行 xx分行",
                                              hasFloatingPlaceholder: false,
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color:
                                                              Color(0xFFBCBCBC),
                                                          style: BorderStyle
                                                              .solid)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color:
                                                              Color(0xFFBCBCBC),
                                                          style: BorderStyle
                                                              .solid)),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 0,
                                                      color: Color(0xFFED1B2E),
                                                      style:
                                                          BorderStyle.solid)),
                                            )),
                                        new TextFormField(
                                            enableInteractiveSelection: false,
                                            onChanged: (v) {
                                              setState(() {
                                                accountNumber = v;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: "開戶行代碼",
                                              hintText: "請輸入開戶行代碼，如：008",
                                              hasFloatingPlaceholder: false,
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color:
                                                              Color(0xFFBCBCBC),
                                                          style: BorderStyle
                                                              .solid)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color:
                                                              Color(0xFFBCBCBC),
                                                          style: BorderStyle
                                                              .solid)),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 0,
                                                      color: Color(0xFFED1B2E),
                                                      style:
                                                          BorderStyle.solid)),
                                            )),
                                        new TextFormField(
                                            enableInteractiveSelection: false,
                                            onChanged: (v) {
                                              setState(() {
                                                accountInfo = v;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: "賬號文字版",
                                              hintText:
                                                  "請輸入賬號的文字版，如：052526xxxxx",
                                              hasFloatingPlaceholder: false,
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color:
                                                              Color(0xFFBCBCBC),
                                                          style: BorderStyle
                                                              .solid)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 0,
                                                          color:
                                                              Color(0xFFBCBCBC),
                                                          style: BorderStyle
                                                              .solid)),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 0,
                                                      color: Color(0xFFED1B2E),
                                                      style:
                                                          BorderStyle.solid)),
                                            )),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 12, 0, 6),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  child: Text(
                                                    "銀行賬簿照片(最多2張)",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFF222222)),
                                                  ),
                                                )),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              "/examples",
                                                              arguments: {
                                                            "type": 2
                                                          });
                                                    },
                                                    child: Container(
                                                      child: Row(children: [
                                                        Container(
                                                            child: Text(
                                                          "示例圖片",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xFF007AFF)),
                                                        )),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: Image.asset(
                                                            'assets/icons/icon-page-arrow-detail-blue.png',
                                                            fit: BoxFit.cover,
                                                            width: 6,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ]),
                                                    )),
                                              ],
                                            )),
                                      ])),
                                  getBBWidget(context, 10000)
                                ])
                              : stepIndex == 3 && arguments["type"] == 20
                                  ? ListView(
                                      children:
                                          renderGoods3(context, optionalList))
                                  : Container(
                                      child: ListView(
                                        children: [
                                          serviceList.length > 0
                                              ? rederSaleserviceText(
                                                  serviceList[0])
                                              : Container()
                                        ],
                                      ),
                                    )),
              optionalList.length > 0 && stepIndex < 4
                  ? Align(
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
                        child: stepIndex == 1
                            ? Row(children: <Widget>[
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                  child: Text(
                                    "已選${checkNum()}件商品",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xFFED1B2E)),
                                  ),
                                )),
                                GestureDetector(
                                    onTap: () {
                                      if (checkNum() > 0) {
                                        setState(() {
                                          stepIndex++;
                                        });
                                      } else {
                                        Toast.toast(context,
                                            msg: "請選擇要退的商品和數量！",
                                            position: ToastPostion.bottom);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(6, 6, 12, 6),
                                      alignment: Alignment.center,
                                      height: 38.0,
                                      width: 115.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Color(0xFFED1B2E),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      child: Text(
                                        '下一步',
                                        style: TextStyle(
                                            color: Color(0xFFFFFFFFF),
                                            fontSize: 16),
                                      ),
                                    ))
                              ])
                            : (stepIndex == 2 && arguments["type"] == 20) ||
                                    (stepIndex == 2 &&
                                        arguments["type"] == 10 &&
                                        arguments["order"].paymentType == 1)
                                ? Row(children: <Widget>[
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            stepIndex--;
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(12, 6, 0, 6),
                                          alignment: Alignment.center,
                                          height: 36.0,
                                          width: 113.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0xFFED1B2E)),
                                          ),
                                          child: Text(
                                            '上一步',
                                            style: TextStyle(
                                                color: Color(0xFFED1B2E),
                                                fontSize: 16),
                                          ),
                                        )),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          for (var i = 0;i < optionalList.length; i++) {
                                             if (checkList[i] && numList[i] > 0) {
                                            if (question[i] == null || question[i] == "") {
                                              Toast.toast(context,
                                                  msg: "請選擇產品要更換的原因",
                                                  position:
                                                      ToastPostion.bottom);
                                              return false;
                                            }}
                                          }
                                          setState(() {
                                            stepIndex++;
                                          });
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 6, 12, 6),
                                          alignment: Alignment.center,
                                          height: 38.0,
                                          width: 115.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Color(0xFFED1B2E),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          child: Text(
                                            '下一步',
                                            style: TextStyle(
                                                color: Color(0xFFFFFFFFF),
                                                fontSize: 16),
                                          ),
                                        ))
                                  ])
                                : stepIndex == 3 ||
                                        (stepIndex == 2 &&
                                            arguments["type"] == 10 &&
                                            arguments["order"].paymentType > 1)
                                    ? Row(children: <Widget>[
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                stepIndex--;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  12, 6, 0, 6),
                                              alignment: Alignment.center,
                                              height: 36.0,
                                              width: 113.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color(0xFFED1B2E)),
                                              ),
                                              child: Text(
                                                '上一步',
                                                style: TextStyle(
                                                    color: Color(0xFFED1B2E),
                                                    fontSize: 16),
                                              ),
                                            )),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              if (arguments["order"].paymentType ==1 &&
                                                  arguments["type"] == 10) {
                                                if (accountName == "") {
                                                  Toast.toast(context,
                                                      msg: "請填寫您的銀行戶名",
                                                      position:
                                                          ToastPostion.bottom);
                                                  return false;
                                                }
                                                if (accountBank == '') {
                                                  Toast.toast(context,
                                                      msg: "請填寫您的開戶行及分行名稱",
                                                      position:
                                                          ToastPostion.bottom);
                                                  return false;
                                                }
                                                if (accountNumber == '') {
                                                  Toast.toast(context,
                                                      msg: "請填寫開戶行代碼",
                                                      position:
                                                          ToastPostion.bottom);
                                                  return false;
                                                }
                                                if (accountInfo == '') {
                                                  Toast.toast(context,
                                                      msg: "請填寫銀行賬號",
                                                      position:
                                                          ToastPostion.bottom);
                                                  return false;
                                                }
                                              }
                                              List _afterSaleServiceProducts =
                                                  [];

                                              for (var i = 0;
                                                  i < optionalList.length;
                                                  i++) {
                                                if (arguments["type"] == 20 &&
                                                    optionalList[i].discountPrice ==null &&
                                                    checkList[i]) {
                                                  Toast.toast(context,
                                                      msg:
                                                          "請選擇產品${i + 1}要更換的規格",
                                                      position:
                                                          ToastPostion.bottom);
                                                  return false;
                                                }
                                              
                                                if (checkList[i] && numList[i] > 0) {
                                                    if (question[i] == null ||
                                                      question[i] == "") {
                                                    Toast.toast(context,
                                                        msg:
                                                            "請選擇產品要更換的原因",
                                                        position:
                                                            ToastPostion.bottom);
                                                    return false;
                                                  }
                                                  _afterSaleServiceProducts
                                                      .add({
                                                    "discountPrice":
                                                        arguments["type"] == 20
                                                            ? optionalList[i]
                                                                .discountPrice
                                                            : null,
                                                    "originalPrice":
                                                        arguments["type"] == 20
                                                            ? optionalList[i]
                                                                .originalPrice
                                                            : null,
                                                    "createdAt": optionalList[i]
                                                        .createdAt,
                                                    "createdBy": optionalList[i]
                                                        .createdBy,
                                                    "deliveryCode":
                                                        optionalList[i]
                                                            .deliveryCode,
                                                    "deliveryId":
                                                        optionalList[i]
                                                            .deliveryId,
                                                    "deliveryQuantity":
                                                        numList[i],
                                                    "quantity": optionalList[i]
                                                        .deliveryQuantity,
                                                    "id": optionalList[i].id,
                                                    "orderCode": optionalList[i]
                                                        .orderCode,
                                                    "orderId":
                                                        optionalList[i].orderId,
                                                    "orderProductId":
                                                        optionalList[i]
                                                            .orderProductId,
                                                    "productId": optionalList[i]
                                                        .productId,
                                                    "sourceProductSkuId":
                                                        optionalList[i]
                                                            .sourceProductSkuId,
                                                    "productSkuBarcode":
                                                        optionalList[i]
                                                            .productSkuBarcode,
                                                    "productSkuId":
                                                        optionalList[i]
                                                            .productSkuId,
                                                    "productSkuName":
                                                        optionalList[i]
                                                            .productSkuName,
                                                    "productSkuPrice":
                                                        optionalList[i]
                                                            .productSkuPrice,
                                                    "productTitle":
                                                        optionalList[i]
                                                            .productTitle,
                                                    "status":
                                                        optionalList[i].status,
                                                    "updatedAt": optionalList[i]
                                                        .updatedAt,
                                                    "updatedBy": optionalList[i]
                                                        .updatedBy,
                                                    "serviceType": question[i],
                                                    "subServiceType":
                                                        reasonListCheckOne[i],
                                                    "serviceDesc":
                                                        messageList[i],
                                                    "serviceUserImgs":
                                                        imgList[i].join(",")
                                                  });
                                                }
                                              }
                                              var data = {
                                                "serviceType":
                                                    arguments["type"],
                                                "serviceSource": 40,
                                                "orderCode":
                                                    optionalList[0].orderCode,
                                                "deliveryCode": widget
                                                    .arguments["data"]
                                                    .deliveryCode,
                                                "afterSaleServiceProducts":
                                                    _afterSaleServiceProducts,
                                                "accountInfo": accountInfo,
                                                "accountName": accountName,
                                                "accountNumber": accountNumber,
                                                "accountBank": accountBank,
                                                "accountBankImgs":
                                                    cardImgList.join(",")
                                              };
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return new LoadingDialog(
                                                      text: "售後提交中…",
                                                    );
                                                  });
                                              saleserviceSubmit(data)
                                                  .then((val) {
                                                saleservice(val.body.id)
                                                    .then((v) {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    if (v.body.handleStatus ==
                                                            20 ||
                                                        v.body.handleStatus ==
                                                            -10) {
                                                      stepIndex = 5;
                                                    } else {
                                                      stepIndex = 4;
                                                    }
                                                    serviceList.add(v.body);
                                                  });
                                                });
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 6, 12, 6),
                                              alignment: Alignment.center,
                                              height: 38.0,
                                              width: 115.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: Color(0xFFED1B2E),
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              child: Text(
                                                '確定',
                                                style: TextStyle(
                                                    color: Color(0xFFFFFFFFF),
                                                    fontSize: 16),
                                              ),
                                            ))
                                      ])
                                    : Container(),
                      ))
                  : Container()
            ])));
  }
}
