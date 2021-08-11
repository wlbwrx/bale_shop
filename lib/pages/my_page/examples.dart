import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
class Examples extends StatefulWidget {
  Examples({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _ExamplesState createState() => _ExamplesState();
}

class _ExamplesState extends State<Examples> {
  int type;
  @override
  void initState() {

     type = widget.arguments["type"];
    // TODO: implement initState
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
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
           type==1? '商品示例圖片':"银行账簿示例图片",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
             GestureDetector(
                  onTap: () {
                    _fb();
                  },
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Image.asset(
                      'assets/icons/customer-service.png',
                      width: 24,
                      height: 24,
                    ),
                  )),
          ],
        ),
        body: Container(
            color: Color(0xFFFFFFFF),
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            margin: EdgeInsets.only(bottom: 12),
            child: ListView(
              children: [
                
                type==1?Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text(
                    "帶標籤的商品圖",
                    style: TextStyle(fontSize: 14, color: Color(0xFF222222)),
                  ),
                ):Container(),
               type==1? Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                 
                        imageUrl:
                            "https://d3o2c7bn83e5x8.cloudfront.net/image/return-1.jpg",
                        
                      )),
                ):Container(),
                type==1?Container(
                  margin: EdgeInsets.only(bottom: 12, top: 12),
                  child: Text(
                    "商品細節圖",
                    style: TextStyle(fontSize: 14, color: Color(0xFF222222)),
                  ),
                ):Container(),
               type==1? Container(
                    child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://d3o2c7bn83e5x8.cloudfront.net/image/return-2.jpg",
                   
                  ),
                )):Container(),


                type==2?Container(
                  margin: EdgeInsets.only(bottom: 12, top: 12),
                  child: Text(
                    "銀行賬戶",
                    style: TextStyle(fontSize: 14, color: Color(0xFF222222)),
                  ),
                ):Container(),
                type==2?Container(
                    child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,

                    imageUrl:
                        "https://d3o2c7bn83e5x8.cloudfront.net/image/return-3.jpg",
                    
                  ),
                )):Container(),
              ],
            )));
  }
}
