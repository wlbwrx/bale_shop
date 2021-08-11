import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/login.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final TextStyle textStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w300);
  @override
  void initState() {
    //设置焦点监听
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

  void _shop() async {
    String url = "https://www.91up.com.tw/user/order.html";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('不能访问');
    }
  }

  String returnText(tel, nickName) {
    if (nickName != null && nickName != '') {
      return nickName;
    }
    if (tel != null && tel != "") {
      return tel;
    }
    return '登入/註冊';
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
    return Container(
        child: Provide<LoginProvide>(builder: (context, child, childCatgory) {
      String tel = Provide.value<LoginProvide>(context).dataTel;
      String photo = Provide.value<LoginProvide>(context).dataPhoto;
      String nickName = Provide.value<LoginProvide>(context).dataNickname;

      return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/user-bg.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter),
              color: Color(0xFFF4F4F4)),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
              ),
              GestureDetector(
                  onTap: () {
                    if (tel != null && tel != "") {
                      Navigator.of(context).pushNamed("/setting");
                    } else {
                      Navigator.of(context).pushNamed("/login");
                    }
                  },
                  child: Container(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 10, 0),
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(30.0),
                              border:
                                  new Border.all(width: 2, color: Colors.white),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: photo != null && photo != ""
                                    ? NetworkImage("https:${photo}")
                                    : AssetImage(
                                        "assets/icons/user.png",
                                      ),
                              )),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 35, 10, 0),
                            child: Text(
                              returnText(tel, nickName),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                        Expanded(
                            child: Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                          child: Image.asset(
                            "assets/icons/icon-menu.png",
                            width: 24,
                            height: 24,
                          ),
                        ))
                      ],
                    ),
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            // padding: EdgeInsets.all(5.0),
                            child: GestureDetector(
                          onTap: () {
                            if (tel != null && tel != "") {
                              Navigator.of(context)
                                  .pushNamed("/order", arguments: {"type": 0});
                            } else {
                              Navigator.of(context).pushNamed("/login");
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Image.asset(
                                  "assets/icons/all_orders.png",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text('全部訂單'),
                              )
                            ],
                          ),
                        )),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            child: GestureDetector(
                          onTap: () {
                            if (tel != null && tel != "") {
                              Navigator.of(context)
                                  .pushNamed("/order", arguments: {"type": 1});
                            } else {
                              Navigator.of(context).pushNamed("/login");
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Image.asset(
                                  "assets/icons/to_be_shipped.png",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text('待發貨'),
                              )
                            ],
                          ),
                        )),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            child: GestureDetector(
                          onTap: () {
                            if (tel != null && tel != "") {
                              Navigator.of(context)
                                  .pushNamed("/order", arguments: {"type": 2});
                            } else {
                              Navigator.of(context).pushNamed("/login");
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Image.asset(
                                  "assets/icons/shipped.png",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text('已發貨'),
                              )
                            ],
                          ),
                        )),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                            child: GestureDetector(
                          onTap: () {
                            if (tel != null && tel != "") {
                              Navigator.of(context)
                                  .pushNamed("/order", arguments: {"type": 3});
                            } else {
                              Navigator.of(context).pushNamed("/login");
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Image.asset(
                                  "assets/icons/completed.png",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text('已完成'),
                              )
                            ],
                          ),
                        )),
                        flex: 1,
                      ),
                       Expanded(
                        child: Container(
                            child: GestureDetector(
                          onTap: () {
                            if (tel != null && tel != "") {
                              Navigator.of(context)
                                  .pushNamed("/afterSalesList", arguments: {"type": 3});
                            } else {
                              Navigator.of(context).pushNamed("/login");
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Image.asset(
                                  "assets/icons/icon-my_order-return.png",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text('退換貨'),
                              )
                            ],
                          ),
                        )),
                        flex: 1,
                      ),
                    ],
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
                            Navigator.of(context).pushNamed("/footMark");
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(15, 17, 16, 17),
                                child: Image.asset(
                                  "assets/icons/footmark.png",
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '瀏覽足跡',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
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
                          )),
                      Container(
                        height: 0.5,
                        color: Color(0xFFEDEDED),
                        margin: EdgeInsets.fromLTRB(52, 0, 0, 0),
                        child: Row(),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (tel != null && tel != "") {
                            Navigator.of(context).pushNamed("/track");
                          } else {
                            Navigator.of(context).pushNamed("/login");
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(15, 17, 17, 16),
                              child: Image.asset(
                                "assets/icons/love.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '我的收藏',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
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
                      )
                    ],
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
                          Navigator.of(context).pushNamed("/word");
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(15, 16, 16, 16),
                              child: Image.asset(
                                "assets/icons/icon-menu-word.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '官方文檔',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  height: 40,
                                  color: Colors.white,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '隱私/服務/常見問題',
                                    style: TextStyle(
                                        color: Color(0xFFBCBCBC), fontSize: 14),
                                  )),
                            ),
                            Container(
                              height: 40,
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              margin: EdgeInsets.fromLTRB(7, 0, 0, 0),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/icons/icon-back-right.png",
                                width: 6,
                                height: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 0.5,
                        color: Color(0xFFEDEDED),
                        margin: EdgeInsets.fromLTRB(52, 0, 0, 0),
                        child: Row(),
                      ),
                      GestureDetector(
                        onTap: () {
                          _fb();
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(15, 16, 16, 16),
                              child: Image.asset(
                                "assets/icons/customer-service.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: Text('在線客服',
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
                      )
                    ],
                  )),
              tel == null || tel == ""
                  ? GestureDetector(
                      onTap: () {
                        _shop();
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(24, 24, 10, 0),
                        alignment: Alignment.center,
                        width: 180.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(25.0),
                            border: new Border.all(
                                width: 1, color: Color(0xFFED1B2E)),
                            color: Colors.white),
                        child: Text(
                          '歷史訂單查詢',
                          style:
                              TextStyle(color: Color(0xFFED1B2E), fontSize: 16),
                        ),
                      ))
                  : Container()
            ],
          ));
    }));
  }else{
    return Container();
  }});
  
  }
   Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<LoginProvide>(context).getData();
    return 'end';
  }
  }