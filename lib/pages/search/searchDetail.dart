import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bale_shop/widgets/goods/GoodsMouldOne.dart';
import 'package:bale_shop/api/home.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
class SearchDetail extends StatefulWidget {
  SearchDetail({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  Map arguments;
  int _index = 0; //排序index
  List type = ['综合排序', '价格升序', '价格降序'];
  String searchText = ""; 
  List pageList = [];
  List hotWordList = [];
  int pageIndex = 0;
  int totalPages = 0;
  bool lock = true;
  bool noProduct = false;
   static final facebookAppEvents = FacebookAppEvents();
  void initState() {
    arguments = widget.arguments;
    super.initState();
    setState(() {
      searchText = arguments["text"];
    });
    getData(0,false,arguments["text"]);
    hotWord().then((val) {
      setState(() {
        for (var i = 0; i < val.body.length; i++) {
          hotWordList.add(val.body[i]);
        }
      });
    });
  }
  getData(index,b,search) async {
    facebookAppEvents.logEvent(
       name:"fb_mobile_search",
       parameters: {
         "fb_search_string":'${search}'
       }
    );
    print("监听一次");
    String text = "keyword=${search}";
    int size = pageIndex;
    if(b&&pageIndex==0){
       size = 1;
       setState(() {
         pageIndex =1;
       });
    }
    if (index == 0) {
      text += '&sortType=0&page=${size}&size=20';
    }
    if (index == 1) {
      text += '&sortType=2&page=${size}&size=20';
    }
    if (index == 2) {
      text += '&sortType=-2&page=${size}&size=20';
    }
    await Future.delayed(Duration(milliseconds: 50), () {
      getProduct(text,index,b);
    });
  }


  void getProduct(data,index,b)  {
    if(data!=null){
        searchList(data).then((val) {
          if(index ==_index){
            setState(() {
              if(b){
                pageIndex++;
              }else{
                pageList.clear();
                if(val.body.content.length==0){
                  noProduct = true;
                }
              }
              lock = true;
              for (var i = 0; i < val.body.content.length; i++) {
                pageList.add(val.body.content[i]);
              }
              totalPages = val.body.totalPages;
            });
          }
      });
    }
  }


   List<Widget> boxs(data) => List.generate(data.length, (index) {
        return GestureDetector(
            onTap: () {
                setState(() {
                  pageList.clear();
                  searchText = data[index].keyword;
                  noProduct = false; 
                });
               getData(0,false, data[index].keyword);
            },
            child:  Container(
               padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
               margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
               decoration: BoxDecoration(
                 color: Color(0xFFF4F4F4),
                 borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              child: Text(
                   data[index].keyword,
                   style: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w400,
                     color: Color(0xFF777777)),
               ))
            );
      });

  Widget renderType(String text, int index, int _index) {
    if (index != _index) {
      return Container(
        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: new Border.all(width: 0.5, color: Color(0xFFBCBCBC)),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF777777)),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFFFEF2F3),
          border: new Border.all(width: 0.5, color: Color(0xFFFEF2F3)),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFFED1B2E)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(pageList.length==0?59 :109),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
                      child: Row(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom:
                            BorderSide(width: 0.5, color: Colors.black12), //有边框
                      )),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(20, 19, 12, 19),
                                child: Image.asset(
                                  'assets/icons/icon-back-light.png',
                                  width: 20,
                                  height: 20,
                                  color: Colors.black,
                                ),
                              )),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 12, 8),
                              color: Colors.white,
                              child: Container(
                                height: 38,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4F4F4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(21)),
                                ),
                                child:searchText!=null?Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child:Text(searchText,style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF777777)
                                      ),
                                    ))
                                  ],
                                ):Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                                      child: Image.asset(
                                        "assets/icons/search.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    Text(
                                      "搜索",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFBCBCBC)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    pageList.length<=0?Container(): Container(
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 11),
                      height: 50,
                      child: new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: type.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pageList.clear();
                                    _index = index;
                                    pageIndex = 0;
                                  });
                                  getData(index,false,searchText);
                                },
                                child: renderType(type[index], index, _index));
                          }),
                    )
                  ]),
                ))),
        body:Scrollbar(
          child:
            noProduct?Container(
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                        child:Column(
                          children: [
                            Text("\"${searchText}\"暫無搜索結果，試試搜這些",style: TextStyle(
                              color:Color(0xFF222222),
                              fontSize: 14
                            )),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Container(
                                  child: Wrap(
                                spacing: 0, //主轴上子控件的间距
                                runSpacing: 0, //交叉轴上子控件之间的间距
                                children: boxs(hotWordList), //要显示的子控集合
                              )))
                          ],
                        )
                      ):Container(
                color: Color(0xFFF4F4F4),
                child: pageList.length > 0
                    ? Container(
                        child: EasyRefresh.custom(
                          header: BallPulseHeader(color: Color(0xFF777777)),
                          footer: BallPulseFooter(color: Color(0xFF777777)),
                          onLoad:pageIndex<=totalPages-1?()async {   
                            if(lock){
                              setState(() {
                                lock = false;
                              });
                              await Future.delayed(Duration(seconds: 1), () {
                                getData(_index,true,searchText);  
                              }); 
                            }                                                 
                          }:null,
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.all(8.0),
                              sliver: new SliverGrid(
                                //Grid
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, //Grid按两列显示
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 9,
                                  childAspectRatio: sizeHeight(size.height),
                                ),
                                delegate: new SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    //创建子widget
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed("/detail", arguments: {
                                            "id": pageList[index].productId,
                                            "isIndex": 2
                                          });
                                        },
                                        child: GoodsMouldOne(data: [pageList[index]]));
                                  },
                                  childCount: pageList.length,
                                ),
                              ),
                            ),
                             SliverToBoxAdapter(
                    child: pageIndex>totalPages-1
                        ? Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            height: 40,
                            child: Text(
                              "沒有更多數據了",
                              style: TextStyle(color: Color(0xFF777777)),
                            ),
                          )
                        : Container(),
                  )
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpinKitFadingCircle(
                            color: Colors.black26,
                            size: 25.0,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text("正在載入...."),
                          )
                        ],
                      )),
          ),
        );
  }
}
