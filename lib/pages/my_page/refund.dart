import 'package:flutter/material.dart';

class Refund extends StatefulWidget {
  final type;
  Refund({Key key, this.type}) : super(key: key);
  @override
  _RefundState createState() => _RefundState();
}

class _RefundState extends State<Refund> {
  int type = 0;
  void initState() {
    type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 70),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                     Row(
                      children: <Widget>[
                        Container(
                          width: 4,
                          height: 4,
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.red),
                          child: Text('·'),
                        ),
                        Text(
                          "全站滿\$699免運",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF222222)),
                        ),
                      ],
                    ),
                       Container(
                         alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(17, 10, 10, 30),
                      child: Text(
                        "全站商品，單筆訂單滿\$699免運費，否則需收取\$60的運費。",
                        style: TextStyle(color: Color(0xFF777777)),
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        Container(
                          width: 4,
                          height: 4,
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.red),
                          child: Text('·'),
                        ),
                        Text(
                          "20天運輸價更低",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF222222)),
                        ),
                      ],
                    ),
                       Container(
                         alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(17, 10, 10, 30),
                      child: Text(
                        "10天運輸，採用空運方式；20天運輸，採用海運方式； 選擇20天運輸方式，即可以享受更加優惠的商品價格喔。",
                        style: TextStyle(color: Color(0xFF777777)),
                      ),
                    ),
                  
                    Row(
                      children: <Widget>[
                        Container(
                          width: 4,
                          height: 4,
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.red),
                          child: Text('·'),
                        ),
                        Text(
                          "支持7天無憂退換貨➕運費補償",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF222222)),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(17, 10, 10, 10),
                      child: Text(
                        "自收到商品之日起7日內，顧客可在線申請退換貨。超過7日，不受理退換貨申請。",
                        style: TextStyle(color: Color(0xFF777777)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(17, 10, 10, 10),
                      child: Text(
                        "以上時限為猶豫期，而非試穿/試用期，所以您退回的商品必須是全新的狀態、而且完整包裝。",
                        style: TextStyle(color: Color(0xFFED1B2E)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(17, 10, 10, 10),
                      child: Text(
                        "美妝產品為私人消耗性產品，壹經拆封或使用，將不可退換貨。",
                        style: TextStyle(color: Color(0xFF777777)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(17, 10, 10, 10),
                      child: Text(
                        "*註：只要在7日內聯系客服，並提供退換貨所需資料，即代表受理申請成功。",
                        style: TextStyle(color: Color(0xFFED1B2E)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(17, 10, 10, 10),
                      child: Text(
                        "*註：退換貨的商品需要用戶主動寄回，因我們的商品問題產生的退換貨，官方補償\$60寄回運費。",
                        style: TextStyle(color: Color(0xFF777777)),
                      ),
                    ),
                  
                  ],
                ),
              ),
            ],
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
                "阿噗官方声明",
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
                            left: 0, right: 0, top: size.height * 0.7 - 70),
                        height: 38.0,
                        color: Colors.white,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(23.0),
                            color: Color(0xFFED1B2E),
                          ),
                          child: Text(
                            "知道了",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        // 设置按钮圆角
                      ))))
        ],
      )
    ]);
  }
}
