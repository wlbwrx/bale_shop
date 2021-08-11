import 'package:flutter/material.dart';
import 'package:bale_shop/provide/address.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:bale_shop/widgets/pick/province.dart' as province;
import 'package:provide/provide.dart';
import 'package:bale_shop/widgets/cart/toast.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
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
  bool isCity = true;
  @override
  void initState() {
    //设置焦点监听
    _focusNodeName.addListener(_focusNodeListener);
    _focusNodePhone.addListener(_focusNodeListener);
    _focusNodeCity.addListener(_focusNodeListener);
    _focusNodeAddress.addListener(_focusNodeListener);
    //监听用户名框的输入改变
    // _userNameController.addListener(() {
    //   print(_userNameController.text);
    //   // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
    //   if (_userNameController.text.length > 0) {
    //     _isShowClear = true;
    //   } else {
    //     _isShowClear = false;
    //   }
    //   setState(() {});
    // });
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(_focusNodeName);
    });
  }

  show(context) async {
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
    print('${temp}');
    if (temp != null) {
      setState(() {
        _result = "${temp.provinceName},${temp.cityName}";
        _city = temp.provinceName;
        _district = temp.cityName;
      });
    }
  }

  @override
  void dispose() {
    // 移除焦点监听
    _focusNodeName.removeListener(_focusNodeListener);
    _focusNodePhone.removeListener(_focusNodeListener);
    _focusNodeCity.removeListener(_focusNodeListener);
    _focusNodeAddress.removeListener(_focusNodeListener);
    super.dispose();
  }

  // 监听焦点
  Future _focusNodeListener() async {
    if (_focusNodeName.hasFocus) {
      print("姓名获取焦点");
      // 取消密码框的焦点状态
      _focusNodePhone.unfocus();
      _focusNodeCity.unfocus();
      _focusNodeAddress.unfocus();
    }
    if (_focusNodePhone.hasFocus) {
      print("手机获取焦点");
      // 取消用户名框焦点状态
      _focusNodeName.unfocus();
      _focusNodeCity.unfocus();
      _focusNodeAddress.unfocus();
    }
    if (_focusNodeAddress.hasFocus) {
      print("地址获取焦点");
      // 取消用户名框焦点状态
      _focusNodeName.unfocus();
      _focusNodePhone.unfocus();
      _focusNodeCity.unfocus();
    }
  }

  String validateName(value) {
    RegExp exp = RegExp(r'^([\\u4e00-\\u9fa5]{1,20}|[a-zA-Z\\.\\s]{1,20})$');
    if (value.isEmpty) {
      return '姓名不能為空!';
    }else if (!exp.hasMatch(value)) {
      return '請輸入正確的姓名!';
    }
    return null;
  }

  String validatePhone(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(r'^([6|9])\d{7}$|^[0][9]\d{8}$|^6\d{5}$');
    if (value.isEmpty) {
      return '電話不能為空!';
    } else if (!exp.hasMatch(value)) {
      return '請輸入正確的手機號!';
    }
    return null;
  }

  bool validateCity(addressList) {
    if (_result == "" && addressList[0] == null) {
      setState(() {
        isCity = false;
      });
      return false;
    } else {
      setState(() {
        isCity = true;
      });
      return true;
    }
  }

  String validateAddress(value) {
    if (value.isEmpty) {
      return '地址不能為空!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
          '收貨地址管理',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: new GestureDetector(
        onTap: () {
          // 点击空白区域，回收键盘
          print("点击了空白区域");
          _focusNodeName.unfocus();
          _focusNodePhone.unfocus();
          _focusNodeCity.unfocus();
          _focusNodeAddress.unfocus();
        },
        child: Container(
          child: FutureBuilder(
              future: _getAddress(context),
              builder: (context, snapshot) {
                List addressList =
                    Provide.value<AddressProvide>(context).addressList;
                return Provide<AddressProvide>(
                    builder: (context, child, childCatgory) {
                  addressList =
                      Provide.value<AddressProvide>(context).addressList;
                  return new ListView(
                    children: [
                      new Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                                    validator: validateName,
                                    initialValue: addressList.length > 0
                                        ? addressList[0].name
                                        : "",
                                    onSaved: (String value) {
                                      _name = value;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "姓名",
                                      hintText: "請填寫收件人姓名",
                                      hasFloatingPlaceholder: false,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Color(0xFFBCBCBC),
                                              style: BorderStyle.solid)),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Color(0xFFBCBCBC),
                                              style: BorderStyle.solid)),
                                      errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: Color(0xFFED1B2E),
                                              style: BorderStyle.solid)),
                                      //尾部添加清除按钮
                                    ),
                                  ),
                                  Container(
                                      height: 31,
                                      margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                                      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFCEE),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(4),
                                        border: new Border.all(
                                            width: 1, color: Color(0xFFECE2C8)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "註：為保證訂單順利到達，請您填寫完整姓名",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFBAA269)),
                                          ),
                                        ],
                                      )),
                                  Positioned(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(19, 50, 0, 0),
                                          child: CustomPaint(
                                            painter: TrianglePainter(
                                              strokeColor: Color(0xFFECE2C8),
                                              strokeWidth: 10,
                                              paintingStyle: PaintingStyle.fill,
                                            ),
                                            child: Container(
                                              height: 10,
                                              width: 17,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(20, 51, 0, 0),
                                          child: CustomPaint(
                                            painter: TrianglePainter(
                                              strokeColor: Color(0xFFFFFCEE),
                                              strokeWidth: 10,
                                              paintingStyle: PaintingStyle.fill,
                                            ),
                                            child: Container(
                                              height: 11,
                                              width: 15,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              new TextFormField(
                                //设置键盘类型
                                enableInteractiveSelection: false,
                                focusNode: _focusNodePhone,
                                validator: validatePhone,
                                initialValue: addressList.length > 0
                                    ? addressList[0].phone
                                    : "",
                                onSaved: (String value) {
                                  _phone = value;
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
                                  this.show(context);
                                },
                                child: Container(
                                  height: 60,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      0, 1, 0, 0),
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 10, 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.5,
                                              color: Color(0xFFBCBCBC)))),
                                  child: _result == "" && addressList.length < 1
                                      ? Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 5, 5, 5),
                                              child: Text(
                                                "市區",
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 40,
                                                color: Colors.white,
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                alignment:
                                                    Alignment.centerRight,
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
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                        _result != ""
                                                            ? _result
                                                            : "${addressList[0].city},${addressList[0].district}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16))
                                                  ],
                                                )),
                                            Expanded(
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
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
                              !isCity
                                  ? Container(
                                      child: Row(
                                      children: <Widget>[
                                        Text(
                                          '市區不能為空!',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                      ],
                                    ))
                                  : Container(),
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
                      ),
                      new SizedBox(
                        height: 20,
                      ),
                      new Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        //点击登录按钮，解除焦点，回收键盘
                                        _focusNodeName.unfocus();
                                        _focusNodePhone.unfocus();
                                        _focusNodeAddress.unfocus();
                                        _formKey.currentState.save();
                                        if (_name == "") {
                                          Toast.toast(context,
                                              msg: "姓名不能为空！",
                                              position: ToastPostion.center);
                                        }

                                        bool city = validateCity(addressList);
                                        if (_formKey.currentState.validate() &&
                                            city) {
                                          //只有输入通过验证，才会执行这里
                                          _formKey.currentState.save();
                                          saveAddress(context, addressList);
                                          Navigator.pop(context);
                                          //todo 登录操作

                                        }
                                      },
                                      child: new Container(
                                        margin: EdgeInsets.only(
                                          left: 0,
                                          right: 0,
                                        ),
                                        height: 38.0,
                                        color: Colors.white,
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        // 设置按钮圆角
                                      ))))
                        ],
                      )
                    ],
                  );
                });
              }),
        ),
      ),
    );
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
