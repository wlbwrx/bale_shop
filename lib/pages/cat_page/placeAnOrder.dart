import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/provide/currentIndex.dart';
import 'package:flutter/material.dart';
import 'package:bale_shop/provide/cart.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/address.dart';
import 'package:bale_shop/api/home.dart';
import 'package:bale_shop/widgets/loadingDialog.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:bale_shop/widgets/pick/province.dart' as province;
import 'package:bale_shop/widgets/cart/toast.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

class PlaceAnOrderPage extends StatefulWidget {
  @override
  _PlaceAnOrderPageState createState() => _PlaceAnOrderPageState();
}

class _PlaceAnOrderPageState extends State<PlaceAnOrderPage> {
  bool show = false;
  bool btnShow = true;
  String message = "";
  String couponCode = "";
  String newCouponCode = "";
  int payIndex = 1;
  FocusNode _message = new FocusNode();
  FocusNode _preferential = new FocusNode();
  String errText = "";
  double discountTotalCouponPrice = 0;
  static final facebookAppEvents = FacebookAppEvents();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  FocusNode _focusNodeName = new FocusNode();
  FocusNode _focusNodePhone = new FocusNode();
  FocusNode _focusNodeCity = new FocusNode();
  FocusNode _focusNodeAddress = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _result = "";
  String _name = '';
  String _phone = '';
  String _city = '';
  String _district = '';
  String _address = '';

  bool lock = false;

  bool isName = false;
  bool isPhone = false;
  bool isCity = false;
  bool isAddress = false;

  bool checkSuccessLock = true;
  checkSuccess() {
    if (isAddress && isCity && isPhone && isName && checkSuccessLock) {
      setState(() {
        checkSuccessLock = false;
      });
      print("发送了一次监听");
      facebookAppEvents
          .logEvent(name: 'fb_mobile_add_payment_info', parameters: {});
    }
  }

  @override
  void initState() {
    //设置焦点监听
    _message.addListener(_focusNodeListener);
    _preferential.addListener(_focusNodeListener);

    //设置焦点监听
    _focusNodeName.addListener(_focusNodeListener);
    _focusNodePhone.addListener(_focusNodeListener);
    _focusNodeCity.addListener(_focusNodeListener);
    _focusNodeAddress.addListener(_focusNodeListener);

    super.initState();

    // Future.delayed(Duration(milliseconds: 500), () {
    //   FocusScope.of(context).requestFocus(_focusNodeName);
    // });
  }

  showIndex(context) async {
    _focusNodeName.unfocus();
    _focusNodePhone.unfocus();
    _focusNodeAddress.unfocus();
    Result temp = await CityPickers.showCityPicker(
      context: context,
      showType: ShowType.pc,
      // locationCode: '640221',
      citiesData: province.citiesData,
      provincesData: province.provincesData,
      height: 400,
    );

    if (temp != null) {
      setState(() {
        _result = "${temp.provinceName},${temp.cityName}";
        _city = temp.provinceName;
        _district = temp.cityName;
        isCity = true;
      });
    } else {
      setState(() {
        isCity = false;
      });
    }
  }

  @override
  void dispose() {
    // 移除焦点监听
    _message.removeListener(_focusNodeListener);
    _preferential.removeListener(_focusNodeListener);

    _focusNodeName.removeListener(_focusNodeListener);
    _focusNodePhone.removeListener(_focusNodeListener);
    _focusNodeCity.removeListener(_focusNodeListener);
    _focusNodeAddress.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future _focusNodeListener() async {
    if (_focusNodeName.hasFocus) {
      print("姓名获取焦点");
      _focusNodePhone.unfocus();
      _focusNodeCity.unfocus();
      _focusNodeAddress.unfocus();
    }
    if (_focusNodePhone.hasFocus) {
      print("手机获取焦点");
      _focusNodeName.unfocus();
      _focusNodeCity.unfocus();
      _focusNodeAddress.unfocus();
    }
    if (_focusNodeAddress.hasFocus) {
      print("地址获取焦点");
      _focusNodeName.unfocus();
      _focusNodePhone.unfocus();
      _focusNodeCity.unfocus();
    }

    if (_message.hasFocus || _preferential.hasFocus) {
      setState(() {
        btnShow = false;
      });
    } else {
      setState(() {
        btnShow = true;
      });
    }
  }

  bool validateCity(addressList) {
    if (_result == "" && addressList[0] == null) {
      return false;
    } else {
      return true;
    }
  }

  String validateAddress(value) {
    if (value.isEmpty) {
      return '地址不能為空!';
    }
    return null;
  }

  void setError(dynamic error) {}

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
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
                            "放棄購買嗎",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF222222),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        content: Container(
                            height: 130,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text("您選購的商品都是熱賣單品隨時都有可能售空，確定要放棄購買嗎？"),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
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
                                                  width: 1, color: Colors.red),
                                            ),
                                            child: Text(
                                              '放棄結算',
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
                                                        color:
                                                            Color(0xFFED1B2E)),
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
            '確認訂單信息',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: new GestureDetector(
            onTap: () {
              // 点击空白区域，回收键盘
              _message.unfocus();
              _focusNodePhone.unfocus();
              _focusNodeCity.unfocus();
              _focusNodeAddress.unfocus();
              _focusNodeName.unfocus();
            },
            child: Container(
              color: Color(0xFFF4F4F4),
              child: Stack(children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 12, 12, 5),
                      child: Text("收件人地址",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
                      child: Text(
                        "為保證訂單順利到達，請您填寫完整姓名",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFFED1B2E)),
                      ),
                    ),
                    Container(
                      child: FutureBuilder(
                          future: _getAddress(context),
                          builder: (context, snapshot) {
                            List addressList =
                                Provide.value<AddressProvide>(context)
                                    .addressList;
                            return Provide<AddressProvide>(
                                builder: (context, child, childCatgory) {
                              return Container(
                                height: 260,
                              
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                padding: EdgeInsets.only(left: 20, right: 20),
                                decoration: new BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Colors.white),
                                child: new Form(
                                  key: _formKey,
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        children: <Widget>[
                                          new TextFormField(
                                            //设置键盘类型
                                            enableInteractiveSelection: false,
                                            focusNode: _focusNodeName,
                                            initialValue: addressList.length > 0
                                                ? addressList[0].name
                                                : "",
                                            onSaved: (String value) {
                                              _name = value;
                                            },
                                            onChanged: (v) {
                                              if (v != "") {
                                                setState(() {
                                                  isName = true;
                                                });
                                              } else {
                                                setState(() {
                                                  isName = false;
                                                });
                                              }
                                              checkSuccess();
                                            },
                                            decoration: InputDecoration(
                                              labelText: "姓名",
                                              hintText: "請填寫收件人姓名",
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
                                              //尾部添加清除按钮
                                            ),
                                          ),
                                          // Container(
                                          //     height: 31,
                                          //     margin: EdgeInsets.fromLTRB(
                                          //         0, 60, 0, 0),
                                          //     padding: EdgeInsets.fromLTRB(
                                          //         0, 0, 8, 0),
                                          //     decoration: BoxDecoration(
                                          //       color: Color(0xFFFFFCEE),
                                          //       shape: BoxShape.rectangle,
                                          //       borderRadius:
                                          //           BorderRadius.circular(4),
                                          //       border: new Border.all(
                                          //           width: 1,
                                          //           color: Color(0xFFECE2C8)),
                                          //     ),
                                          //     child: Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.end,
                                          //       children: <Widget>[
                                          //         Text(
                                          //           "註：為保證訂單順利到達，請您填寫完整姓名",
                                          //           style: TextStyle(
                                          //               fontSize: 12,
                                          //               color:
                                          //                   Color(0xFFBAA269)),
                                          //         ),
                                          //       ],
                                          //     )),
                                          // Positioned(
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.start,
                                          //     children: <Widget>[
                                          //       Container(
                                          //         margin: EdgeInsets.fromLTRB(
                                          //             19, 50, 0, 0),
                                          //         child: CustomPaint(
                                          //           painter: TrianglePainter(
                                          //             strokeColor:
                                          //                 Color(0xFFECE2C8),
                                          //             strokeWidth: 10,
                                          //             paintingStyle:
                                          //                 PaintingStyle.fill,
                                          //           ),
                                          //           child: Container(
                                          //             height: 10,
                                          //             width: 17,
                                          //           ),
                                          //         ),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          // Positioned(
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.start,
                                          //     children: <Widget>[
                                          //       Container(
                                          //         margin: EdgeInsets.fromLTRB(
                                          //             20, 51, 0, 0),
                                          //         child: CustomPaint(
                                          //           painter: TrianglePainter(
                                          //             strokeColor:
                                          //                 Color(0xFFFFFCEE),
                                          //             strokeWidth: 10,
                                          //             paintingStyle:
                                          //                 PaintingStyle.fill,
                                          //           ),
                                          //           child: Container(
                                          //             height: 11,
                                          //             width: 15,
                                          //           ),
                                          //         ),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      new TextFormField(
                                        //设置键盘类型
                                        enableInteractiveSelection: false,
                                        focusNode: _focusNodePhone,
                                        initialValue: addressList.length > 0
                                            ? addressList[0].phone
                                            : "",
                                        onSaved: (String value) {
                                          _phone = value;
                                        },
                                        onChanged: (v) {
                                          if (v != "") {
                                            setState(() {
                                              isPhone = true;
                                            });
                                          } else {
                                            setState(() {
                                              isPhone = false;
                                            });
                                          }
                                          checkSuccess();
                                        },
                                        decoration: InputDecoration(
                                          labelText: "電話",
                                          hintText: "請填寫聯系電話",
                                          hasFloatingPlaceholder: false,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Color(0xFFBCBCBC),
                                                  style: BorderStyle.solid)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Color(0xFFBCBCBC),
                                                  style: BorderStyle.solid)),
                                          errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Color(0xFFED1B2E),
                                                  style: BorderStyle.solid)),
                                          //尾部添加清除按钮
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          this.showIndex(context);
                                        },
                                        child: Container(
                                          height: 60,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 1, 0, 0),
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 10, 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 0.5,
                                                      color:
                                                          Color(0xFFBCBCBC)))),
                                          child: _result == "" &&
                                                  addressList.length < 1
                                              ? Row(
                                                  children: <Widget>[
                                                    Container(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 5, 5, 5),
                                                      child: Text(
                                                        "市區",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        height: 40,
                                                        color: Colors.white,
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 0),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Image.asset(
                                                          "assets/icons/icon-back-right.png",
                                                          width: 6,
                                                          height: 10,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: <Widget>[
                                                    Container(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black45,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                                _result != ""
                                                                    ? _result
                                                                    : "${addressList[0].city},${addressList[0].district}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16))
                                                          ],
                                                        )),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Image.asset(
                                                            "assets/icons/icon-back-right.png",
                                                            width: 6,
                                                            height: 10),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        ),
                                      ),
                                      new TextFormField(
                                        //设置键盘类型
                                        enableInteractiveSelection: false,
                                        focusNode: _focusNodeAddress,
                                        validator: validateAddress,
                                        initialValue: addressList.length > 0
                                            ? addressList[0].address
                                            : "",
                                        onSaved: (String value) {
                                          _address = value;
                                        },
                                        onChanged: (v) {
                                          if (v != "") {
                                            setState(() {
                                              isAddress = true;
                                            });
                                          } else {
                                            setState(() {
                                              isAddress = false;
                                            });
                                          }
                                          checkSuccess();
                                        },
                                        decoration: InputDecoration(
                                          labelText: "地址",
                                          hintText: "請填寫街道、樓牌號等",
                                          hasFloatingPlaceholder: false,
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Color(0xFFBCBCBC),
                                                  style: BorderStyle.solid)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Color(0xFFBCBCBC),
                                                  style: BorderStyle.solid)),
                                          errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Color(0xFFED1B2E),
                                                  style: BorderStyle.solid)),
                                          //尾部添加清除按钮
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          }),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Text("商品需要管理室代收嗎？",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF222222)))),
                                  Container(
                                      child: Text("如需管理室代收，請打開右側按鈕",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF777777))))
                                ])),
                            Container(
                              width: 60,
                              child: Switch(
                                value: lock,
                                activeColor: Color(0xFF007AFF),
                                onChanged: (value) {
                                  setState(() {
                                    lock = value;
                                  });
                                },
                              ),
                            )
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 12, 12, 10),
                      child: Text("付款方式",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  payIndex = 1;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(8, 0, 12, 0),
                                      child: payIndex == 1
                                          ? Image.asset(
                                              "assets/icons/icon_check.png",
                                              width: 20,
                                              height: 20,
                                            )
                                          : Image.asset(
                                              "assets/icons/icon_no_check.png",
                                              width: 20,
                                              height: 20,
                                            ),
                                    ),
                                    Container(
                                        child: Text(
                                      "貨到付款",
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 16),
                                    ))
                                  ],
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  payIndex = 2;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 0, 12, 0),
                                        child: payIndex == 2
                                            ? Image.asset(
                                                "assets/icons/icon_check.png",
                                                width: 20,
                                                height: 20,
                                              )
                                            : Image.asset(
                                                "assets/icons/icon_no_check.png",
                                                width: 20,
                                                height: 20,
                                              ),
                                      ),
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 12, 0),
                                          child: Text(
                                            "信用卡",
                                            style: TextStyle(
                                                color: Color(0xFF000000),
                                                fontSize: 16),
                                          )),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: Image.asset(
                                            "assets/images/visa.png",
                                            width: 30,
                                            height: 30,
                                          )),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: Image.asset(
                                            "assets/images/MasterCard.png",
                                            width: 30,
                                            height: 30,
                                          )),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: Image.asset(
                                            "assets/images/American-Express.png",
                                            width: 30,
                                            height: 30,
                                          )),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: Image.asset(
                                            "assets/images/discover.png",
                                            width: 30,
                                            height: 30,
                                          ))
                                    ],
                                  ))),
                          Container(
                              child: Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.fromLTRB(41, 5, 0, 0),
                                  child: Text(
                                    "信用卡付款，最高可隨機立減\$99",
                                    style: TextStyle(
                                        color: Color(0xFFF9670F), fontSize: 12),
                                  ))
                            ],
                          ))
                        ],
                      ),
                    )),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: Text("商品清單",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w500)),
                    ),
                    Column(
                      children: <Widget>[
                        Provide<CartProvide>(
                            builder: (context, child, childCatgory) {
                          List cartListAll =
                              Provide.value<CartProvide>(context).cartList;
                          List cartList = [];

                          for (var i = 0; i < cartListAll.length; i++) {
                            if (cartListAll[i].isSelect) {
                              cartList.add(cartListAll[i]);
                            }
                          }

                          double discountTotalPrice =
                              Provide.value<CartProvide>(context)
                                  .discountTotalPrice; //折扣价
                          double freight =
                              Provide.value<CartProvide>(context).freight;
                          int allGoodsCount =
                              Provide.value<CartProvide>(context).allGoodsCount;

                          return Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: Color(0xFFF4F4F4),
                                child: cartList.length == 1
                                    ? orderText(context, cartList)
                                    : order(context, cartList, allGoodsCount),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  color: Color(0xFFF4F4F4),
                                  child: Container(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 17, 10, 17),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                String err = "";
                                                return StatefulBuilder(
                                                    builder: (context1, state) {
                                                  return new AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 10, 0),
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
                                                    content: Container(
                                                        height: 170,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          20,
                                                                          10,
                                                                          0),
                                                              child: TextField(
                                                                enableInteractiveSelection:
                                                                    false,
                                                                onChanged: (v) {
                                                                  state(() {
                                                                    ///为了区分把setState改个名字
                                                                    couponCode =
                                                                        v;
                                                                  });
                                                                },
                                                                focusNode:
                                                                    _preferential,
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .fromLTRB(
                                                                              10,
                                                                              15,
                                                                              10,
                                                                              15),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0xFFDFDEDB),
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0xFFDFDEDB),
                                                                    ),
                                                                  ),
                                                                  // errorBorder:
                                                                  //     UnderlineInputBorder(
                                                                  //         borderSide: BorderSide(
                                                                  //             color:  Color(0xFFDFDEDB))),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0xFFDFDEDB),
                                                                    ),
                                                                  ),
                                                                  hintText:
                                                                      "請輸入折價卷碼",
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          3,
                                                                          0,
                                                                          3),
                                                              child: Text(
                                                                err,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xFFED1B2E)),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        state(
                                                                            () {
                                                                          couponCode =
                                                                              "";
                                                                        });

                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.fromLTRB(
                                                                            0,
                                                                            26,
                                                                            5,
                                                                            0),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        width:
                                                                            120.0,
                                                                        height:
                                                                            38.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          border: new Border.all(
                                                                              width: 1,
                                                                              color: Colors.red),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          '取消',
                                                                          style: TextStyle(
                                                                              color: Color(0xFFED1B2E),
                                                                              fontSize: 16),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    flex: 1),
                                                                Expanded(
                                                                    child: GestureDetector(
                                                                        //111111

                                                                        onTap: () {
                                                                          if (couponCode != "" &&
                                                                              couponCode != null) {
                                                                            List
                                                                                cartList =
                                                                                Provide.value<CartProvide>(context).cartList;
                                                                            var orderProducts =
                                                                                [];
                                                                            cartList.forEach((item) {
                                                                              var newGoods = {
                                                                                'productId': item.productId,
                                                                                'productTitle': item.productTitle,
                                                                                'quantity': item.quantity,
                                                                                'productSkuId': item.productSkuId,
                                                                                'productSkuBarcode': item.productSkuBarcode,
                                                                                'productSkuName': item.productSkuName,
                                                                                'productImageUrl': item.productImageUrl,
                                                                                'isSelect': item.isSelect,
                                                                                'productPrice': item.productPrice,
                                                                                'originalPrice': item.originalPrice,
                                                                                "discountPrice": item.discountPrice
                                                                              };
                                                                              orderProducts.add(newGoods);
                                                                            });
                                                                            var data =
                                                                                {
                                                                              "couponCode": couponCode,
                                                                              "orderProducts": orderProducts,
                                                                            };

                                                                            orderPrice(data).then((val) {
                                                                              if (val != 500) {
                                                                                if (val.statusCodeValue == "500") {
                                                                                  state(() {
                                                                                    err = val.body;
                                                                                  });
                                                                                }
                                                                                if (val.body != null) {
                                                                                  state(() {
                                                                                    discountTotalCouponPrice = val.body.price.discountTotalCouponPrice;
                                                                                    newCouponCode = couponCode;
                                                                                  });
                                                                                  Navigator.pop(context);
                                                                                }
                                                                              }
                                                                            });
                                                                          } else {
                                                                            Navigator.pop(context);
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                          margin: EdgeInsets.fromLTRB(
                                                                              5,
                                                                              26,
                                                                              0,
                                                                              0),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          width:
                                                                              120.0,
                                                                          height:
                                                                              38.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            color:
                                                                                Color(0xFFED1B2E),
                                                                            borderRadius:
                                                                                BorderRadius.circular(25.0),
                                                                            border:
                                                                                new Border.all(width: 1, color: Color(0xFFED1B2E)),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            '确定',
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 16),
                                                                          ),
                                                                        )),
                                                                    flex: 1),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                  );
                                                });
                                              });
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              color: Colors.white,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      "折價券",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            discountTotalCouponPrice >
                                                                    0
                                                                ? "-${doubleText(discountTotalCouponPrice)}"
                                                                : '請選擇折價卷',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: discountTotalCouponPrice >
                                                                        0
                                                                    ? Color(
                                                                        0xFFDF4C0F)
                                                                    : Color(
                                                                        0xFFBCBCBC)),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  6, 0, 0, 0),
                                                          child: Image.asset(
                                                            "assets/icons/icon-back-right.png",
                                                            width: 6,
                                                            height: 10,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.fromLTRB(12, 12, 12, 10),
                                child: Text("明細表",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  color: Color(0xFFF4F4F4),
                                  child: Container(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        // Container(
                                        //   padding: EdgeInsetsDirectional.fromSTEB(
                                        //       0, 10, 10, 0),
                                        //   child: Row(
                                        //     children: <Widget>[
                                        //       Container(
                                        //         child: Text("付款方式"),
                                        //       ),
                                        //       Expanded(
                                        //         child: Container(
                                        //           alignment: Alignment.centerRight,
                                        //           child: Text('貨到付款'),
                                        //         ),
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),

                                        Container(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "商品總金額",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff222222)),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    '\$${doubleText(discountTotalPrice)}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff222222)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "運費",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff222222)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '\$${doubleText(freight)}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(
                                                              0xff222222)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                        // Container(
                                        //     padding:
                                        //         EdgeInsetsDirectional.fromSTEB(
                                        //             0, 20, 0, 0),
                                        //     child: Row(
                                        //       children: <Widget>[
                                        //         Container(
                                        //           child: Text(
                                        //             discountTotalPrice < 699
                                        //                 ? "金額未滿\$699，需補差價："
                                        //                 : "金額已滿\$699，需補差價：",
                                        //             style: TextStyle(
                                        //                 fontSize: 14,
                                        //                 color:
                                        //                     Color(0xff222222)),
                                        //           ),
                                        //         ),
                                        //         Expanded(
                                        //           child: Container(
                                        //             alignment:
                                        //                 Alignment.centerRight,
                                        //             child: Text(
                                        //               discountTotalPrice < 699
                                        //                   ? '\$${doubleText(spreadPrice)}'
                                        //                   : '\$0',
                                        //               style: TextStyle(
                                        //                   fontSize: 14,
                                        //                   color: Color(
                                        //                       0xff222222)),
                                        //             ),
                                        //           ),
                                        //         )
                                        //       ],
                                        //     )),
                                        // Container(
                                        //   alignment: Alignment.centerLeft,
                                        //   padding:
                                        //       EdgeInsetsDirectional.fromSTEB(
                                        //           0, 0, 0, 0),
                                        //   child: Text(
                                        //     "金額數值為限時出清價和8折價的差價",
                                        //     style: TextStyle(
                                        //         fontSize: 12,
                                        //         color: Color(0xff7777777)),
                                        //   ),
                                        // ),
                                        discountTotalCouponPrice > 0
                                            ? Container(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        "折價券優惠",
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                            '-\$${doubleText(discountTotalCouponPrice)}'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  )),
                              !show
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          show = true;
                                        });
                                      },
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.fromLTRB(
                                              16, 16, 0, 86),
                                          child: Text("+ 添加留言",
                                              style: TextStyle(
                                                  color: Color(0xFFED1B2E),
                                                  fontSize: 16))),
                                    )
                                  : Container(),
                              show
                                  ? Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.fromLTRB(12, 16, 12, 0),
                                      child: Text("我的留言",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500)),
                                    )
                                  : Container(),
                              show
                                  ? Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 86),
                                      color: Color(0xFFF4F4F4),
                                      child: Container(
                                        height: 110,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
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
                                                  message = v;
                                                });
                                              },
                                              focusNode: _message,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                hintText: "請輸入您的留言...",
                                              ),
                                              maxLines: 3,
                                            )
                                          ],
                                        ),
                                      ))
                                  : Container()
                            ],
                          );
                        }),

                        // InkWell(
                        //   onTap: () {
                        //     Navigator.of(context).pushNamed("/orderSuccess");
                        //   },
                        //   child: Container(
                        //     child: Text('1111'),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
                Provide<CartProvide>(builder: (context, child, childCatgory) {
                  double discountTotalPrice =
                      Provide.value<CartProvide>(context)
                          .discountTotalPrice; //折扣价
                  double spreadPrice =
                      Provide.value<CartProvide>(context).spreadPrice;
                  double freight = Provide.value<CartProvide>(context).freight;
                  num _allGoodsCount =
                      Provide.value<CartProvide>(context).allGoodsCount;
                  final size = MediaQuery.of(context).size;
                  return btnShow
                      ? Align(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: Column(
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 8, 8, 0),
                                        alignment: Alignment.centerRight,
                                        child: Row(children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 6, 0, 0),
                                            child: Text('應付:'),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 9, 0, 0),
                                            child: Text(
                                              "\$",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.red),
                                            ),
                                          ),
                                          Text(
                                            "${doubleText(discountTotalPrice + freight - discountTotalCouponPrice)}",
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.red),
                                          ),
                                        ])),
                                    // InkWell(
                                    //   onTap: () {
                                    //     showModalBottomSheet(
                                    //       context: context,
                                    //       isScrollControlled: true,
                                    //       shape: RoundedRectangleBorder(
                                    //           side: BorderSide.none,
                                    //           borderRadius: BorderRadius.only(
                                    //             topRight: Radius.circular(10),
                                    //             topLeft: Radius.circular(10),
                                    //           )),
                                    //       builder: (BuildContext context) {
                                    //         return Container(
                                    //           child: Stack(
                                    //             children: <Widget>[
                                    //               Container(
                                    //                   padding: EdgeInsets.only(
                                    //                       top: 25),
                                    //                   height: 280,
                                    //                   child: Container(
                                    //                     padding:
                                    //                         EdgeInsets.fromLTRB(
                                    //                             20, 20, 20, 40),
                                    //                     color: Colors.white,
                                    //                     child: Column(
                                    //                       children: <Widget>[
                                    //                         Container(
                                    //                           padding:
                                    //                               EdgeInsetsDirectional
                                    //                                   .fromSTEB(
                                    //                                       0,
                                    //                                       10,
                                    //                                       0,
                                    //                                       0),
                                    //                           child: Row(
                                    //                             children: <
                                    //                                 Widget>[
                                    //                               Container(
                                    //                                 child: Text(
                                    //                                   "共${_allGoodsCount}件商品",
                                    //                                   style: TextStyle(
                                    //                                       fontSize:
                                    //                                           14,
                                    //                                       color:
                                    //                                           Color(0xff222222)),
                                    //                                 ),
                                    //                               ),
                                    //                             ],
                                    //                           ),
                                    //                         ),
                                    //                         Container(
                                    //                           padding:
                                    //                               EdgeInsetsDirectional
                                    //                                   .fromSTEB(
                                    //                                       0,
                                    //                                       10,
                                    //                                       0,
                                    //                                       0),
                                    //                           child: Row(
                                    //                             children: <
                                    //                                 Widget>[
                                    //                               Container(
                                    //                                 child: Text(
                                    //                                   "商品總金額",
                                    //                                   style: TextStyle(
                                    //                                       fontSize:
                                    //                                           14,
                                    //                                       color:
                                    //                                           Color(0xff222222)),
                                    //                                 ),
                                    //                               ),
                                    //                               Expanded(
                                    //                                 child:
                                    //                                     Container(
                                    //                                   alignment:
                                    //                                       Alignment
                                    //                                           .centerRight,
                                    //                                   child:
                                    //                                       Text(
                                    //                                     '\$${doubleText(discountTotalPrice)}',
                                    //                                     style: TextStyle(
                                    //                                         fontSize:
                                    //                                             14,
                                    //                                         color:
                                    //                                             Color(0xff222222)),
                                    //                                   ),
                                    //                                 ),
                                    //                               )
                                    //                             ],
                                    //                           ),
                                    //                         ),
                                    //                         Container(
                                    //                             padding:
                                    //                                 EdgeInsetsDirectional
                                    //                                     .fromSTEB(
                                    //                                         0,
                                    //                                         10,
                                    //                                         0,
                                    //                                         0),
                                    //                             child: Row(
                                    //                               children: <
                                    //                                   Widget>[
                                    //                                 Container(
                                    //                                   child:
                                    //                                       Text(
                                    //                                     "運費",
                                    //                                     style: TextStyle(
                                    //                                         fontSize:
                                    //                                             14,
                                    //                                         color:
                                    //                                             Color(0xff222222)),
                                    //                                   ),
                                    //                                 ),
                                    //                                 Expanded(
                                    //                                   child:
                                    //                                       Container(
                                    //                                     alignment:
                                    //                                         Alignment.centerRight,
                                    //                                     child:
                                    //                                         Text(
                                    //                                       '\$0',
                                    //                                       style: TextStyle(
                                    //                                           fontSize: 14,
                                    //                                           color: Color(0xff222222)),
                                    //                                     ),
                                    //                                   ),
                                    //                                 )
                                    //                               ],
                                    //                             )),
                                    //                         Container(
                                    //                             padding:
                                    //                                 EdgeInsetsDirectional
                                    //                                     .fromSTEB(
                                    //                                         0,
                                    //                                         20,
                                    //                                         0,
                                    //                                         0),
                                    //                             child: Row(
                                    //                               children: <
                                    //                                   Widget>[
                                    //                                 Container(
                                    //                                   child:
                                    //                                       Text(
                                    //                                     discountTotalPrice <
                                    //                                             699
                                    //                                         ? "金額未滿\$699，需補差價："
                                    //                                         : "金額已滿\$699，需補差價：",
                                    //                                     style: TextStyle(
                                    //                                         fontSize:
                                    //                                             14,
                                    //                                         color:
                                    //                                             Color(0xff222222)),
                                    //                                   ),
                                    //                                 ),
                                    //                                 Expanded(
                                    //                                   child:
                                    //                                       Container(
                                    //                                     alignment:
                                    //                                         Alignment.centerRight,
                                    //                                     child:
                                    //                                         Text(
                                    //                                       discountTotalPrice < 699
                                    //                                           ? '\$${doubleText(spreadPrice)}'
                                    //                                           : '\$0',
                                    //                                       style: TextStyle(
                                    //                                           fontSize: 14,
                                    //                                           color: Color(0xff222222)),
                                    //                                     ),
                                    //                                   ),
                                    //                                 )
                                    //                               ],
                                    //                             )),
                                    //                         Container(
                                    //                           alignment: Alignment
                                    //                               .centerLeft,
                                    //                           padding:
                                    //                               EdgeInsetsDirectional
                                    //                                   .fromSTEB(
                                    //                                       0,
                                    //                                       0,
                                    //                                       0,
                                    //                                       0),
                                    //                           child: Text(
                                    //                             "金額數值為限時出清價和8折價的差價",
                                    //                             style: TextStyle(
                                    //                                 fontSize:
                                    //                                     12,
                                    //                                 color: Color(
                                    //                                     0xff7777777)),
                                    //                           ),
                                    //                         ),
                                    //                         discountTotalCouponPrice >
                                    //                                 0
                                    //                             ? Container(
                                    //                                 padding: EdgeInsetsDirectional
                                    //                                     .fromSTEB(
                                    //                                         0,
                                    //                                         10,
                                    //                                         0,
                                    //                                         0),
                                    //                                 child: Row(
                                    //                                   children: <
                                    //                                       Widget>[
                                    //                                     Container(
                                    //                                       child:
                                    //                                           Text(
                                    //                                         "折價券優惠",
                                    //                                         style:
                                    //                                             TextStyle(fontSize: 14),
                                    //                                       ),
                                    //                                     ),
                                    //                                     Expanded(
                                    //                                       child:
                                    //                                           Container(
                                    //                                         alignment:
                                    //                                             Alignment.centerRight,
                                    //                                         child:
                                    //                                             Text('-\$${doubleText(discountTotalCouponPrice)}'),
                                    //                                       ),
                                    //                                     )
                                    //                                   ],
                                    //                                 ),
                                    //                               )
                                    //                             : Container(),
                                    //                       ],
                                    //                     ),
                                    //                   )),
                                    //               Positioned(
                                    //                   child: Container(
                                    //                 height: 42,
                                    //                 decoration: BoxDecoration(
                                    //                   color: Colors.white,
                                    //                   borderRadius:
                                    //                       BorderRadius.only(
                                    //                     topRight:
                                    //                         Radius.circular(25),
                                    //                     topLeft:
                                    //                         Radius.circular(25),
                                    //                   ),
                                    //                 ),
                                    //                 padding:
                                    //                     EdgeInsets.fromLTRB(
                                    //                         12, 4, 12, 0),
                                    //                 child: Row(
                                    //                   children: <Widget>[
                                    //                     Container(
                                    //                       child: Text(
                                    //                         "訂單明細表",
                                    //                         style: TextStyle(
                                    //                             fontSize: 18,
                                    //                             fontWeight:
                                    //                                 FontWeight
                                    //                                     .w600,
                                    //                             color: Color(
                                    //                                 0xFF222222)),
                                    //                       ),
                                    //                     ),
                                    //                     Expanded(
                                    //                         child: Container(
                                    //                             padding:
                                    //                                 EdgeInsets
                                    //                                     .fromLTRB(
                                    //                                         0,
                                    //                                         12,
                                    //                                         0,
                                    //                                         0),
                                    //                             width: 30,
                                    //                             alignment:
                                    //                                 Alignment
                                    //                                     .topRight,
                                    //                             child:
                                    //                                 GestureDetector(
                                    //                               onTap: () {
                                    //                                 Navigator.of(
                                    //                                         context)
                                    //                                     .pop();
                                    //                               },
                                    //                               child: Image
                                    //                                   .asset(
                                    //                                 'assets/icons/icon-close.png',
                                    //                                 width: 15,
                                    //                                 height: 15,
                                    //                                 color: Color(
                                    //                                     0xFF222222),
                                    //                               ),
                                    //                             )))
                                    //                   ],
                                    //                 ),
                                    //               )),
                                    //             ],
                                    //           ),
                                    //         );
                                    //       },
                                    //     );
                                    //   },
                                    //   child: Container(
                                    //       padding:
                                    //           EdgeInsets.fromLTRB(15, 0, 8, 0),
                                    //       alignment: Alignment.centerLeft,
                                    //       child: Row(
                                    //         children: [
                                    //           Text("點擊此處，查看明細  ",
                                    //               style: TextStyle(
                                    //                   fontSize: 12,
                                    //                   color:
                                    //                       Color(0xff777777))),
                                    //           Image.asset(
                                    //             'assets/icons/icon-top.png',
                                    //             width: 9,
                                    //             height: 6,
                                    //             fit: BoxFit.cover,
                                    //           ),
                                    //         ],
                                    //       )),
                                    // ),
                                  ],
                                )),
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 7, 10, 0),
                                  alignment: Alignment.center,
                                  width: 100.0,
                                  height: 38.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFED1B2E),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: new Border.all(
                                        width: 1, color: Colors.white),
                                  ),
                                  child: pay(context),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container();
                })
              ]),
            )));
  }

  Widget addressText(context, addressList) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 10, 5),
              child: Text("${addressList[0].name}  ${addressList[0].phone}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            Container(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 11),
                child: Text(
                    "${addressList[0].address}  (${addressList[0].city} ${addressList[0].district})",
                    style: TextStyle(fontSize: 14, color: Colors.black45))),
          ],
        ),
        Expanded(
            child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
          alignment: Alignment.centerRight,
          child: Container(
              margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
              child: Image.asset(
                "assets/icons/icon-back-right.png",
                width: 6,
                height: 10,
              )),
        ))
      ],
    );
  }

  Widget orderText(context, cartList) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(children: [
         Row(
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
                imageUrl: "http:" + cartList[0].productImageUrl,
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
                      children: <Widget>[
                        SizedBox(
                            height: 20,
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                cartList[0].productTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                          decoration: BoxDecoration(
                              color: Color(0xFFF9F9F9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Text(cartList[0].productSkuName),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text(
                                    "\$${doubleText(cartList[0].productPrice)}",
                                    style: TextStyle(
                                        color: Color(0xFFED1B2E),
                                        fontSize: 14)),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "x${cartList[0].quantity}",
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
         cartList[0].isLimitProduct != null && cartList[0].isLimitProduct == true
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
      ],)      
     
    );
  }

  Widget order(context, cartList, allGoodsCount) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
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
              child: Stack(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 25),
                      height: size.height * 0.7,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(12, 20, 12, 80),
                        color: Colors.white,
                        child: _showNomalWid(context, cartList),
                      )),
                  Positioned(
                      child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(12, 4, 12, 0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "購買商品列表",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF222222)),
                          ),
                        ),
                        Expanded(
                            child: Container(
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
                                )))
                      ],
                    ),
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
                                        top: size.height * 0.7 - 70),
                                    height: 38.0,
                                    color: Colors.white,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(23.0),
                                        color: Color(0xFFED1B2E),
                                      ),
                                      child: Text(
                                        "確定",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    // 设置按钮圆角
                                  ))))
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      child: Container(
          margin: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Row(children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              height: (size.width - 40) / 4,
              width: (size.width - 40) / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: cartList.length > 0
                    ? img(context, "http:${cartList[0].productImageUrl}",
                        cartList[0].quantity, (size.width - 40) / 4)
                    : Text(''),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: (size.width - 40) / 4,
                width: (size.width - 40) / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  child: cartList.length > 1
                      ? img(context, "http:${cartList[1].productImageUrl}",
                          cartList[1].quantity, (size.width - 40) / 4)
                      : Text(''),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              height: (size.width - 40) / 4,
              width: (size.width - 40) / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: cartList.length > 2
                    ? img(context, "http:${cartList[2].productImageUrl}",
                        cartList[2].quantity, (size.width - 40) / 4)
                    : Text(''),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('共${allGoodsCount}件'),
                    Container(
                      margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Image.asset(
                        "assets/icons/icon-back-right.png",
                        width: 6,
                        height: 10,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ])),
    );
  }

  Widget pay(context) {
    return InkWell(
        onTap: () {
          List address = Provide.value<AddressProvide>(context).addressList;
          List cartList = Provide.value<CartProvide>(context).cartList;
          int num = Provide.value<CurrentIndexProvide>(context).catNum;
          int allNum = 0;
          RegExp exp = RegExp(r'^([6|9])\d{7}$|^[0][9]\d{8}$|^6\d{5}$');
          RegExp checkName = RegExp(r'^[\u4E00-\u9FA5A-Za-z0-9]+$');
          _formKey.currentState.save();

          if (_name.isEmpty ||
              _name.replaceAll(new RegExp(r"\s+\b|\b\s"), "").trim().length <
                  1) {
            Toast.toast(context, msg: "姓名不能为空！", position: ToastPostion.center);
            return false;
          } else if (!checkName.hasMatch(_name) ||
              _name.length > 20 ||
              _name.length < 2) {
            Toast.toast(context,
                msg: "請輸入正確的姓名", position: ToastPostion.center);
            return false;
          }
          if (_phone.isEmpty) {
            Toast.toast(context, msg: "電話不能为空！", position: ToastPostion.center);
            return false;
          } else if (!exp.hasMatch(_phone)) {
            Toast.toast(context,
                msg: "請輸入正確的手機號", position: ToastPostion.center);
            return false;
          }
          if (!validateCity(address)) {
            Toast.toast(context, msg: "請選擇市區", position: ToastPostion.center);
            return false;
          }

          if (_address.isEmpty ||
              _address.replaceAll(new RegExp(r"\s+\b|\b\s"), "").trim().length <
                  1) {
            Toast.toast(context, msg: "地址不能为空！", position: ToastPostion.center);
            return false;
          }
          //只有输入通过验证，才会执行这里
          _focusNodeName.unfocus();
          _focusNodePhone.unfocus();
          _focusNodeAddress.unfocus();
          _formKey.currentState.save();
          saveAddress(context, address);
          //构造数据
          Future.delayed(Duration(milliseconds: 50), () {
            var orderProducts = [];

            cartList.forEach((item) {
              var _shoppingType = 3;
              if (item.shoppingType == 1 || item.shoppingType == 3) {
                _shoppingType = 3;
              }
              if (item.shoppingType == 2 || item.shoppingType == 4) {
                _shoppingType = 4;
              }

              if (item.isSelect) {
                var newGoods = {
                  'productId': item.productId,
                  'productTitle': item.productTitle,
                  'quantity': item.quantity,
                  'productSkuId': item.productSkuId,
                  'productSkuBarcode': item.productSkuBarcode,
                  'productSkuName': item.productSkuName,
                  'productImageUrl': item.productImageUrl,
                  'isSelect': item.isSelect,
                  'productPrice': item.productPrice,
                  'originalPrice': item.originalPrice,
                  "discountPrice": item.discountPrice,
                  "shoppingType": _shoppingType
                };

                facebookAppEvents.logInitiatedCheckout(
                  totalPrice: item.productPrice * item.quantity,
                  currency: 'TWD',
                  contentType: 'product',
                  contentId: '${item.productId}',
                  numItems: item.quantity,
                );
                allNum = allNum + item.quantity;
                orderProducts.add(newGoods);
              }
            });
            var data = {
              "message": message,
              "orderProducts": orderProducts,
              "couponCode": newCouponCode,
              "orderAddress": {
                "consignee": _name,
                "tel": _phone,
                "country": "臺灣",
                "province": "臺灣",
                "city": address[0].city,
                "district": address[0].district,
                "detail": lock
                    ? address[0].address + "  (管理室代收)"
                    : address[0].address,
                "type": 1
              },
              "pixelId": "1727478160624151",
              "affiliate": "新版app"
            };

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return new LoadingDialog(
                    text: "下單中…",
                  );
                });

            if (payIndex == 1) {
              submitOrder(data).then((val) {
                Navigator.pop(context);
                if (val != 500) {
                  for(var i=0;i<val.body.orderProducts.length;i++){
                    fbLogPurchase(val.body.orderProducts[i].discountPrice,val.body.orderProducts[i].productId,val.body.orderProducts[i].quantity);
                  }
                  Navigator.of(context).pushNamed("/orderSuccess",arguments: {"id": val.body.code});
                  Provide.value<CartProvide>(context).removeList(orderProducts);
                  Provide.value<CurrentIndexProvide>(context).changeCatNum(num - allNum);
                }
              });
            }
            if (payIndex == 2) {
              paymentOrder(data).then((val) {
                Navigator.pop(context);
                if (val != 500) {
                  StripePayment.setOptions(StripeOptions(
                    publishableKey: val.body.dataKey,
                  ));
                  StripePayment.paymentRequestWithCardForm(
                          CardFormPaymentRequest())
                      .then((paymentMethod) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return new LoadingDialog(
                            text: "下單中…",
                          );
                        });
                    stripeCheckout(paymentMethod.id, val.body.order.id).then((val) {
                      Navigator.of(context).pop();
                      if (val != 500) {
                        for(var i=0;i<orderProducts.length;i++){
                          fbLogPurchase(orderProducts[i]["discountPrice"],orderProducts[i]["productId"],orderProducts[i]["quantity"]);
                        }
                        Navigator.of(context).pushNamed("/orderSuccess",arguments: {"id": val.body.code});
                        Provide.value<CartProvide>(context).removeList(orderProducts);
                        Provide.value<CurrentIndexProvide>(context).changeCatNum(num - allNum);
                      }
                    });
                  }).catchError(setError);
                }
              });
            }
          });
        },
        child: Text(
          '確認結賬',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ));
  }

  fbLogPurchase(discountPrice,productId,quantity){
     facebookAppEvents.logPurchase(
            amount:discountPrice,
            currency: 'TWD',
            parameters: {
              'fb_content_id':productId,
              'fb_content_type': 'product',
              'fb_num_items': quantity,
            }
     );
  }

  Widget img(BuildContext context, url, index, size) {
    return Stack(
      children: <Widget>[
        Container(
          height: size,
          width: size,
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
              imageUrl: url,
              errorWidget: (context, url, error) => Image.asset(
                'assets/icons/placeholder.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        index > 1
            ? Positioned(
                top: 55,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0x80000000),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    "${index}件",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )
            : Text("")
      ],
    );
  }

  Widget _showNomalWid(BuildContext context, cartList) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
              child: Column(
                children: [
                  Row(
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
                                              fontSize: 12,
                                              color: Color(0xFF777777),
                                            ),
                                          ),
                                        )),
                                    Container(
                                      //width: 80,
                                      // margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF9F9F9),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                      child:
                                          Text(cartList[index].productSkuName),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 100,
                                            child: Text(
                                                "\$${doubleText(cartList[index].productPrice)}",
                                                style: TextStyle(
                                                    color: Color(0xFF222222),
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
                  cartList[index].isLimitProduct != null &&
                          cartList[index].isLimitProduct == true
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
                ],
              ));
        },
        itemCount: cartList.length);
  }

  Future<String> saveAddress(BuildContext context, addressList) async {
    await Provide.value<AddressProvide>(context).save(
        _name,
        _phone,
        _city != null && _city != "" ? _city : addressList[0].city,
        _district != null && _district != ""
            ? _district
            : addressList[0].district,
        _address);
    return 'end';
  }

  Future<String> _getAddress(BuildContext context) async {
    await Provide.value<AddressProvide>(context).getList();
    return 'end';
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
