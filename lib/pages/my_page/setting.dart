import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:bale_shop/api/home.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:bale_shop/widgets/pick/province.dart' as province;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:bale_shop/widgets/loadingDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/login.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List data = [];
  String nikeName = "";
  String _result = "";
  FocusNode nikeNameFocusNode = new FocusNode();
  var _nikename = new TextEditingController();

  @override
  void initState() {
    //设置焦点监听
    super.initState();
    userDetail().then((val) {
      if (val != null) {
        setState(() {
          data.add(val.body);
          if (data[0].city != "" && data[0].district != "") {
            _result = "${data[0].city} ${data[0].district}";
          }
        });
        _nikename.text = val.body.nickname;
      }
    });
  }

  void changeData(value) {
    setState(() {
      data[0].nickname = value;
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _upLoadImage(image);
    }
  }

  _upLoadImage(File image) async {
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
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

    FormData formData = FormData.fromMap(
        {"image": await MultipartFile.fromFile(path, filename: name)});

    upImg(formData, data[0].id).then((val) {
      Navigator.pop(context);
      setState(() {
        data[0].photo = val.body.photo;
      });
      Provide.value<LoginProvide>(context).changePhoto(val.body.photo);
    });
  }

  showSex(context) async {
    Result temp = await CityPickers.showCityPicker(
      context: context,
      showType: ShowType.p,
      provincesData: province.sexData,
      citiesData: province.sexData1,
      height: 400,
    );
    if (temp != null) {
      setState(() {
        data[0].sex = temp.provinceId;
      });
    }
  }

  showAddress(context) async {
    Result temp = await CityPickers.showCityPicker(
      context: context,
      showType: ShowType.pc,
      citiesData: province.citiesData,
      provincesData: province.provincesData,
      height: 400,
    );
    if (temp != null) {
      setState(() {
        _result = "${temp.provinceName} ${temp.cityName}";
        data[0].city = temp.provinceName;
        data[0].district = temp.cityName;
      });
    }
  }

  changeUser(id, scopeId, tel, nickname, photo) async {
    await Provide.value<LoginProvide>(context)
        .changeUser(id, scopeId, tel, nickname, photo);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _height = size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '個人信息',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return new LoadingDialog(
                      text: "正在保存中…",
                    );
                  });
              userChange({
                "birthday": data[0].birthday,
                "city": data[0].city,
                "country": data[0].country,
                "district": data[0].district,
                "id": data[0].id,
                "nickname": data[0].nickname,
                "province": data[0].province,
                "sex": data[0].sex,
              }).then((val) {
                changeUser(
                    val.body.id,
                    val.body.scopeId,
                    val.body.tel,
                    val.body.nickname,
                    val.body.photo != null ? val.body.photo : "");
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text(
                "保存",
                style: TextStyle(color: Color(0xFFED1B2E), fontSize: 18),
              ),
            ),
          ),
        ],
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
      body: data.length > 0
          ? Container(
              color: Color(0xFFF4F4F4),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 32, 0, 32),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '头像',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF222222)),
                                    ),
                                  ),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        width: 50.0,
                                        height: 50.0,
                                        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Color(0xFF777777),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            border: new Border.all(
                                                width: 3, color: Colors.white),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: data[0].photo != null &&
                                                        data[0].photo != ""
                                                    ? NetworkImage(
                                                        "https:${data[0].photo}")
                                                    : AssetImage(
                                                        "assets/icons/user.png",
                                                      ))),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        color: Colors.white,
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          "assets/icons/icon-back-right.png",
                                          width: 6,
                                          height: 10,
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              )),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(15, 17, 0, 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '登入手機號',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF222222)),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  color: Colors.white,
                                  alignment: Alignment.centerRight,
                                  child: Text(data[0].tel,
                                      style: TextStyle(
                                          color: Color(0xFF777777),
                                          fontSize: 14)),
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context1, state) {
                                      return new AlertDialog(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        titlePadding:
                                            EdgeInsets.fromLTRB(0, 16, 0, 24),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8),
                                              topLeft: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            )),
                                        content: Container(
                                            height: 170,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 20, 10, 0),
                                                  child: TextField(
                                                     enableInteractiveSelection: false,
                                                    onChanged: (v) {
                                                      state(() {
                                                        nikeName = v;
                                                      });
                                                    },
                                                    controller: _nikename,
                                                    focusNode:
                                                        nikeNameFocusNode,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 15, 10, 15),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFDFDEDB),
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFDFDEDB),
                                                        ),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFDFDEDB),
                                                        ),
                                                      ),
                                                      hintText: "請輸入暱稱",
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            state(() {
                                                              _nikename.text =
                                                                  data[0]
                                                                      .nickname;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 26,
                                                                    5, 0),
                                                            alignment: Alignment
                                                                .center,
                                                            width: 120.0,
                                                            height: 38.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                              border: new Border
                                                                      .all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            child: Text(
                                                              '取消',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFED1B2E),
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ),
                                                        flex: 1),
                                                    Expanded(
                                                        child: GestureDetector(
                                                            //111111
                                                            onTap: () {
                                                              changeData(
                                                                  _nikename
                                                                      .text);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(5,
                                                                      26, 0, 0),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 120.0,
                                                              height: 38.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                color: Color(
                                                                    0xFFED1B2E),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25.0),
                                                                border: new Border
                                                                        .all(
                                                                    width: 1,
                                                                    color: Color(
                                                                        0xFFED1B2E)),
                                                              ),
                                                              child: Text(
                                                                '确定',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
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
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(15, 17, 0, 16),
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '商城暱稱',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF222222)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 8, 0),
                                          child: Text(data[0].nickname!=null&&data[0].nickname!=""?data[0].nickname:'',
                                              style: TextStyle(
                                                  color: Color(0xFF222222))),
                                        ),
                                        Image.asset(
                                          "assets/icons/icon-back-right.png",
                                          width: 6,
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showSex(context);
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(15, 17, 0, 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '性別',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF222222)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        data[0].sex == "0"
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                child: Text("男",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF222222))),
                                              )
                                            : Container(),
                                        data[0].sex == "1"
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                child: Text("女",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF222222))),
                                              )
                                            : Container(),
                                        data[0].sex != "1" && data[0].sex != "0"
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                child: Text(
                                                  "請選擇",
                                                  style: TextStyle(
                                                      color: Color(0xFFED1B2E)),
                                                ),
                                              )
                                            : Container(),
                                        Image.asset(
                                          "assets/icons/icon-back-right.png",
                                          width: 6,
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              int y = 1900;
                              int m = 1;
                              int d = 1;
                              if (data[0].birthday != null &&
                                  data[0].birthday != "") {
                                List _date = data[0].birthday.split('-');
                                y = int.parse(_date[0]);
                                m = int.parse(_date[1]);
                                d = int.parse(_date[2]);
                              }

                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 1, 1),
                                  maxTime: DateTime.now(),
                                  theme: DatePickerTheme(
                                      backgroundColor: Colors.white,
                                      containerHeight: _height * 0.5 - 12,
                                      itemStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      cancelStyle: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          wordSpacing: 15),
                                      doneStyle: TextStyle(
                                          color: Colors.blue, fontSize: 14)),
                                  onChanged: (date) {}, onConfirm: (date) {
                                setState(() {
                                  data[0].birthday =
                                      "${date.year}-${date.month}-${date.day}";
                                });
                              },
                                  currentTime: data[0].birthday != null &&
                                          data[0].birthday != ""
                                      ? DateTime(y, m, d)
                                      : DateTime.now(),
                                  locale: LocaleType.zh);
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(15, 17, 0, 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '生日',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF222222)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        data[0].birthday != null
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                child: Text(data[0].birthday,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF222222))),
                                              )
                                            : Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                child: Text(
                                                  "請選擇",
                                                  style: TextStyle(
                                                      color: Color(0xFFED1B2E)),
                                                ),
                                              ),
                                        Image.asset(
                                          "assets/icons/icon-back-right.png",
                                          width: 6,
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showAddress(context);
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(15, 17, 0, 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '所在地',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF222222)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        data[0].city != null &&
                                                data[0].city != ""
                                            ? Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                child: Text(_result,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF222222))),
                                              )
                                            : Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                child: Text(
                                                  "請選擇",
                                                  style: TextStyle(
                                                      color: Color(0xFFED1B2E)),
                                                ),
                                              ),
                                        Image.asset(
                                          "assets/icons/icon-back-right.png",
                                          width: 6,
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return new AlertDialog(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                    "確定要退出登入吗?",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF222222),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                content: Container(
                                    height: 70,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await Provide.value<LoginProvide>(context).removeUser();
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 15, 5, 0),
                                                    alignment: Alignment.center,
                                                    height: 38.0,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      border: new Border.all(
                                                          width: 1,
                                                          color: Colors.red),
                                                    ),
                                                    child: Text(
                                                      '確定退出',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFED1B2E),
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                                flex: 1),
                                            Expanded(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  5, 15, 0, 0),
                                                          alignment:
                                                              Alignment.center,
                                                          height: 38.0,
                                                           width: 120,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            color: Color(
                                                                0xFFED1B2E),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25.0),
                                                            border: new Border
                                                                    .all(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFFED1B2E)),
                                                          ),
                                                          child: Text(
                                                            '再考慮一下',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        alignment: Alignment.center,
                        height: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                            //border: new Border.all(width: 1, color: Color(0xFFED1B2E)),
                            color: Colors.white),
                        child: Text(
                          '退出当前账号',
                          style:
                              TextStyle(color: Color(0xFFED1B2E), fontSize: 16),
                        ),
                      ))
                ],
              ),
            )
          : Container(),
    );
  }
}
