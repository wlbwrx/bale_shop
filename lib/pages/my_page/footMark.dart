import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/footmark.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/utils/tool.dart';
class FootMark extends StatefulWidget {
  @override
  _FootMarkState createState() => _FootMarkState();
}

class _FootMarkState extends State<FootMark> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '浏览足迹',
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
        body: FutureBuilder(
            future: _getFootInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List footList = Provide.value<FootMarkProvide>(context).footMarkList;
                return Provide<FootMarkProvide>(
                    builder: (context, child, childCatgory) {
                  footList = Provide.value<FootMarkProvide>(context).footMarkList;

                  List dateList = [];
                  List isFootList = [];
                  List newFootList = [];
                  String date = "";

                  for (var i = footList.length; i > 0; i--) {
                    isFootList.add(footList[i - 1]);
                    if (date != footList[i - 1].date) {
                      date = footList[i - 1].date;
                      dateList.add(footList[i - 1].date);
                      if (i != footList.length) {
                        isFootList.removeAt(isFootList.length - 1);
                        newFootList.add(isFootList);
                        isFootList = [];
                        isFootList.add(footList[i - 1]);
                      }
                    }
                    if (i == 1) {
                      newFootList.add(isFootList);
                      isFootList = [];
                    }
                  }
                  return ListView.builder(
                      itemCount: dateList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Color(0xFFF4F4F4),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text("${dateList[index]}"),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "共${newFootList[index].length}件商品"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  new GridView.count(
                                      padding: EdgeInsets.all(10),
                                      physics:
                                          new NeverScrollableScrollPhysics(), //增加
                                      shrinkWrap: true, //增加
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.81,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      children: List.generate(
                                          newFootList[index].length, (index1) {
                                        return Container(
                                          child: Column(
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed("/detail",
                                                          arguments: {
                                                        "id": newFootList[index]
                                                                [index1]
                                                            .id,
                                                        "isIndex": 2
                                                      });
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(6),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      'assets/icons/placeholder.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    imageUrl: "http:" +
                                                        newFootList[index]
                                                                [index1]
                                                            .img,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      'assets/icons/placeholder.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 6, 0, 0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                        "\$${doubleText(newFootList[index][index1].price)}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFED1B2E),
                                                            fontSize: 16)),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              5, 0, 0, 0),
                                                      child: Text(
                                                        "\$${doubleText(newFootList[index][index1].originalPrice)}",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF777777),
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }))
                                ],
                              ),
                            )
                          ],
                        );
                      });
                });
              }else{
                return null;
              }
            }));
  }

  Future<String> _getFootInfo(BuildContext context) async {
    await Provide.value<FootMarkProvide>(context).getList();
    return 'end';
  }
}
