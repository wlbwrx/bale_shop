import 'package:flutter/material.dart';

class Word extends StatefulWidget {
  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<Word> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '官方文檔',
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
      body: Container(
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
                          Navigator.of(context).pushNamed("/serviceTerms");
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 17, 0, 16),
                              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),  
                              alignment: Alignment.center,
                              child: Text(
                                '客戶服務條款',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              height: 55,
                              color: Colors.white,
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
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/privacyPolicy");
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 17, 0, 16),
                            alignment: Alignment.center,
                            child: Text(
                              '客戶隱私政策',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              height: 55,
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
                    ),
                    Container(
                      height: 0.5,
                      color: Color(0xFFEDEDED),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/problem");
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 17, 0, 16),
                            
                             decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                            alignment: Alignment.center,
                            child: Text(
                              '常見問題說明',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              height: 55,
                              color: Colors.white,
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
      ),
    );
  }
}
