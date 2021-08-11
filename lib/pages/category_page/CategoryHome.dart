import 'package:flutter/material.dart';
import 'package:bale_shop/api/home.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryHome extends StatefulWidget {
  @override
  _CategoryHomeState createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  int _index = 20;
  List list = [];

  int checkIndex = 0;

  @override
  void initState() {
    super.initState();
    //初始化时即进行数据请求
    loadJSDataModel().then((val) {
      setState(() {
        for (var i = 0; i < val.body.length; i++) {
          var name = val.body[i];
          list.add(name);
        }
      });
    });
  }

  Widget _leftInkWell(int index) {
    if (checkIndex == index) {
      return InkWell(
          onTap: () {
            setState(() {
              this.checkIndex = index;
            });
          },
          child: Stack(
            children: <Widget>[
              Container(
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  list[index].name,
                  style: TextStyle(fontSize: 15, color: Color(0xFFED1B2E)),
                ),
              ),
              Positioned(
                left: 0,
                top: 15,
                child: Container(
                  height: 25,
                  width: 3,
                  decoration: BoxDecoration(color: Color(0xFFED1B2E)),
                ),
              ),
            ],
          ));
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            this.checkIndex = index;
          });
        },
        child: Container(
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Color(0xFFF4F4F4), border: Border()),
          child: Text(
            list[index].name,
            style: TextStyle(fontSize: 15),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '分類',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFF4F4F4),
                  border: Border(
                    right: BorderSide(width: 1.0, color: Colors.black12), //有边框
                  )),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (contex, index) {
                  return _leftInkWell(index);
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: GridView.builder(
                  itemCount:
                      list.length > 0 ? list[checkIndex].childrens.length : 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //横轴三个子widget
                      childAspectRatio: 0.8),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/classify");
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                  child: Container(
                                color: Colors.white,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/icons/placeholder.png',
                                    fit: BoxFit.cover,
                                  ),
                                  imageUrl: "http:" +
                                      list[checkIndex].childrens[index].thumb,
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/icons/placeholder.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                              Text(list[checkIndex].childrens[index].name,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
