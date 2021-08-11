import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:bale_shop/widgets/goods/GoodsMouldThree.dart';
import 'package:bale_shop/api/home.dart';

class Track extends StatefulWidget {
  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  List list = [];

  void initState() {
    super.initState();
    favoriteGoods().then((val) {
         setState(() {
           for (var i = 0; i < val.body.length; i++) {
          list.add(val.body[i]);
        }
    });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           elevation: 0.5,
          title: Text(
            '收藏商品列表',
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
        body: list.length>0?Container(
            color: Color(0xFFF4F4F4),
            child: EasyRefresh.custom(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: new SliverList(
                    //Grid
                    delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        //创建子widget
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed("/detail",
                                  arguments: {
                                    "id": list[index].id,
                                    "isIndex": 2
                                  });
                            },
                            child: GoodsMouldThree(data: [list[index]]));
                      },
                      childCount: list.length,
                    ),
                  ),
                ),
              ],
            )):no(context));
  }
    Widget no(context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Image.asset(
              "assets/images/null-order.png",
              width: 100,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Text("您还没有追踪任何商品哟～",style: TextStyle(
              fontSize: 14,
              color:Color(0xFF777777)
            ),),
          ),
          
        ],
      ),
    );
  }

  
}
