import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bale_shop/api/home.dart';
import 'package:bale_shop/widgets/cart/toast.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/login.dart';
import 'package:bale_shop/widgets/loadingDialog.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();
  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();
  //表单状态
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  var _password = '';
  var _username = '';
  var _isShowClear = false; //是否显示输入框尾部的清除按钮
  int _seconds = 0;
  String _verifyStr = '獲取驗證碼';
  Timer _timer;
  Map arguments;
  @override
  void initState() {
    arguments = widget.arguments;
    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);

    //监听用户名框的输入改变
    _userNameController.addListener(() {
      // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }

      setState(() {
        _username = _userNameController.text;
      });
    });
    super.initState();

    // Future.delayed(Duration(milliseconds: 500), () {
    //   FocusScope.of(context).requestFocus(_focusNodeUserName);
    // });
  }

  @override
  void dispose() {
    // 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
    _cancelTimer();
  }

  _startTimer() {
    _formKey.currentState.save();
    if (validateUserName(_username) == null) {
      sendsms('${_username}').then((val) {
        Toast.toast(context, msg: "驗證碼已發送", position: ToastPostion.center);
      });
      _seconds = 60;
      _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        if (_seconds == 0) {
          _cancelTimer();
          return;
        }
        _seconds--;
        _verifyStr = '重新发送$_seconds(s)';
        setState(() {});
        if (_seconds == 0) {
          _verifyStr = '重新发送';
        }
      });
    } else {
      Toast.toast(context,
          msg: validateUserName(_username), position: ToastPostion.center);
    }
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  // 监听焦点
  Future _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  /**
   * 验证用户名
   */
  String validateUserName(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(r'^([6|9])\d{7}$|^[0][9]\d{8}$|^6\d{5}$');
    if (value.isEmpty) {
      return '請輸入手機號碼！';
    } else if (!exp.hasMatch(value)) {
      return '請輸入正確的手機號！';
    }
    return null;
  }

  /**
   * 验证验证码
   */
  String validatePassWord(value) {
    if (value.isEmpty) {
      return '請輸入驗證碼！';
    } else if (value.trim().length != 6) {
      return '驗證碼長度不正確！';
    }
    return null;
  }

  login(id, scopeId, tel, token, photo, nickname) async {
    await Provide.value<LoginProvide>(context)
        .save(id, scopeId, tel, token, photo, nickname);
    Toast.toast(context, msg: "登录成功", position: ToastPostion.bottom);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    Widget verifyCodeBtn = new InkWell(
      onTap: (_seconds == 0)
          ? () {
              setState(() {
                _startTimer();
              });
            }
          : null,
      child: new Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 17),
        width: 105,
        height: 30,
        decoration: new BoxDecoration(
            border: new Border.all(
              width: 1.0,
              color: _seconds == 0 ? Color(0xFF1B7EED) : Colors.black38,
            ),
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: new Text(
          '$_verifyStr',
          style: new TextStyle(
              fontSize: 14.0,
              color: _seconds == 0 ? Color(0xFF1B7EED) : Colors.black38),
        ),
      ),
    );
    //输入文本框区域
    Widget inputTextArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            new TextFormField(
              controller: _userNameController,
              focusNode: _focusNodeUserName,
              //设置键盘类型
              keyboardType: TextInputType.number,
            
              keyboardAppearance: Brightness.light,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                labelText: "手機號",
                hintText: "請輸入手機號",
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
                suffixIcon: (_isShowClear)
                    ? IconButton(
                        icon: Container(
                          margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                          child: Image.asset(
                            'assets/icons/icon-del.png',
                            width: 15,
                            height: 15,
                          ),
                        ),
                        onPressed: () {
                          // 清空输入框内容
                          _userNameController.clear();
                        },
                      )
                    : null,
              ),
              //验证用户名
              validator: validateUserName,
              //保存数据
              onSaved: (String value) {
                _username = value;
              },
            ),
            new Stack(children: <Widget>[
              new TextFormField(
                focusNode: _focusNodePassWord,
                keyboardType: TextInputType.number,
                keyboardAppearance: Brightness.light,
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  labelText: "驗證碼",
                  hintText: "請輸入驗證碼",
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
                ),
                //密码验证
                validator: validatePassWord,
                //保存数据
                onSaved: (String value) {
                  _password = value;
                },
              ),
              new Align(
                alignment: Alignment.centerRight,
                child: verifyCodeBtn,
              ),
            ])
          ],
        ),
      ),
    );

    // 登录按钮区域
    Widget loginButtonArea = GestureDetector(
        onTap: () {
          //点击登录按钮，解除焦点，回收键盘
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();

          if (_formKey.currentState.validate()) {
            //只有输入通过验证，才会执行这里
            _formKey.currentState.save();
            //todo 登录操作
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return new LoadingDialog(
                    text: "正在登錄中…",
                  );
                });
            userLogin({"tel": _username, "code": _password, "scopeId": 8})
                .then((val) {
              if (val != null) {
                login(
                    val.body.userInfo.id,
                    val.body.userInfo.scopeId,
                    val.body.userInfo.tel,
                    val.body.token,
                    val.body.userInfo.nickname != null &&
                            val.body.userInfo.nickname != ""
                        ? val.body.userInfo.nickname
                        : "",
                    val.body.userInfo.photo != null
                        ? val.body.userInfo.photo
                        : "");
                Future.delayed(Duration(milliseconds: 300), () {
                  Navigator.of(context).pop();
                });
                //   Future.delayed(Duration(milliseconds: 300), (){
                //  Navigator.of(context).pop();
                //   });
                if (arguments != null) {
                  Future.delayed(Duration(milliseconds: 300), () {
                    Navigator.of(context).pushNamed("/placeAnOrder");
                  });
                }
              } else {
                Navigator.of(context).pop();
              }
            });

          }
        },
        child: new Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          height: 45.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(23.0),
            color: Color(0xFFED1B2E),
            border: new Border.all(width: 1, color: Color(0xFFED1B2E)),
          ),
          child: Text(
            "確定",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          // 设置按钮圆角
        ));

    // 游客购买
    Widget buttonArea = GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).pushNamed("/placeAnOrder");
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          alignment: Alignment.center,
          height: 45.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(25.0),
            border: new Border.all(width: 1, color: Colors.red),
          ),
          child: Text(
            '遊客模式購買',
            style: TextStyle(color: Color(0xFFED1B2E), fontSize: 16),
          ),
        ));
    //第三方登录区域
    Widget thirdLoginArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: new Column(
        children: [
          new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 80,
                height: 1.0,
                color: Colors.grey,
              ),
              Text('第三方登录'),
              Container(
                width: 80,
                height: 1.0,
                color: Colors.grey,
              ),
            ],
          ),
          new SizedBox(
            height: 18,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                color: Colors.red,
                icon: Icon(FontAwesomeIcons.facebook),
                iconSize: 30.0,
                onPressed: () {},
              ),
              IconButton(
                color: Colors.red,
                icon: Icon(FontAwesomeIcons.line),
                iconSize: 30.0,
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );

    Widget _buildProtocol() {
      return new Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: new Text.rich(
          new TextSpan(
              text: '確定即代表同意',
              style: new TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF777777),
                  fontWeight: FontWeight.w400),
              children: [
                new TextSpan(
                    text: '《客戶服務條款》',
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed("/serviceTerms");
                      },
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF1B7EED),
                      fontWeight: FontWeight.w400,
                    )),
                new TextSpan(
                    text: '和',
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF777777),
                      fontWeight: FontWeight.w400,
                    )),
                new TextSpan(
                    text: '《隱私政策》',
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed("/privacyPolicy");
                      },
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF1B7EED),
                      fontWeight: FontWeight.w400,
                    )),
              ]),
        ),
      );
    }

    //忘记密码  立即注册
    Widget bottomArea = new Container(
      margin: EdgeInsets.only(right: 20, left: 30),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            child: Text(
              "忘记密码?",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
            //忘记密码按钮，点击执行事件
            onPressed: () {},
          ),
          FlatButton(
            child: Text(
              "快速注册",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
            //点击快速注册、执行事件
            onPressed: () {},
          )
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
          "手機號快捷登入",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      // 外层添加一个手势，用于点击空白部分，回收键盘
      body: new GestureDetector(
          onTap: () {
            // 点击空白区域，回收键��
            _focusNodePassWord.unfocus();
            _focusNodeUserName.unfocus();
          },
          child: Container(
            child: new ListView(
              children: [
                new SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                inputTextArea,
                new SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                loginButtonArea,
                arguments != null ? buttonArea : Container(),
                _buildProtocol(),
              ],
            ),
          )),
    );
  }
}
