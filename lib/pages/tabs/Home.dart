import 'package:flutter/material.dart';
import 'package:bale_shop/pages/home_page/Hot.dart';
import 'package:bale_shop/pages//home_page/Category.dart';
import 'package:bale_shop/api/home.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/home.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key,this.tabIndex}) : super(key: key);
  int tabIndex;
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin  {
  @override
  bool get wantKeepAlive => true;
  
  ///see AutomaticKeepAliveClientMixin
  final List _tabs = [];
  final List pageList = [];
  int subId = 0;
  var tabController;   
  List tabList;
  
  @override
  void initState() {
    super.initState();
    //初始化时即进行数据请求
    loadJSDataModel().then((val) {
      setState(() {
        for (var i = 0; i < val.body.length; i++) {
          var name = val.body[i];
          print(val.body[i]);
          if (name.isTopNavigation) {
            _tabs.add(name);
          }
        }
        this.tabController = new TabController(
            vsync: this,        // 动画效果的异步处理
            length: _tabs.length,           // tab 个数
            initialIndex: 0    // 起始位置
        );
      });
    });
     
  }



  

  Future<String> _getNavInfo(BuildContext context) async {
    await Provide.value<HomeProvide>(context).getNavigationList();
    return 'end';
  }

  _editIndex(editText) {
    for(var i=0;i<_tabs.length;i++){
      if(int.parse(editText.split(',')[0])==_tabs[i].id){
        if(editText.split(',').length>1&&editText.split(',')[1]!=null){
          print("发起跳转");
          setState(() {
            subId = int.parse(editText.split(',')[1]);
          });
        }      
        Future.delayed(Duration(milliseconds: 300), (){
          this.tabController.animateTo(i);
        }); 
        
      }
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  

  isBanner(f) {
    bool lock = false;
    for (var i = 0; i < f.childrens.length; i++) {
      if (f.childrens[i].isShow) {
        lock = true;
      }
    }
    if (lock) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return FutureBuilder(
        future: _getNavInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Provide<HomeProvide>(
                builder: (context, child, childCatgory) {
              List navigationList = Provide.value<HomeProvide>(context).navigationList;
              return DefaultTabController(
                length: _tabs.length > 0 ? _tabs.length : navigationList.length,
                child: Scaffold(
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(106),
                      child:GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/search");
            },
            child: Container(
                color: Colors.white,
                child:  Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(0, topPadding, 0, 0),
                            child: Row(),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 10, 12, 8),
                            color: Colors.white,
                            child: Container(
                              height: 38,
                              decoration: BoxDecoration(
                                color: Color(0xFFF4F4F4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(21)),
                              ),
                              child: Row(
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
                                        fontSize: 16, color: Color(0xFFBCBCBC)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Column(children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TabBar(
                                    controller: tabController,
                                      unselectedLabelColor: Color(0xFF222222),
                                      indicatorColor: Color(0xFFED1B2E),
                                      labelColor: Color(0xFFED1B2E),
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorPadding: EdgeInsets.only(bottom: 3.0),
                                      isScrollable: true,
                                      indicatorWeight: 4,
                                      tabs: _tabs.length > 0
                                          ? _tabs.map<Tab>((tab) {
                                              return Tab(
                                                  child: Text(
                                                tab.name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ));
                                            }).toList()
                                          : navigationList.map<Tab>((tab) {
                                              return Tab(
                                                  child: Text(
                                                tab.name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ));
                                            }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ]),
                          ),
                        ],
                      )),)),
                  body: new TabBarView(
                    controller: tabController,
                    children: _tabs.length > 0
                        ? _tabs.map((f) {
                            if (isBanner(f)) {
                              return new HotPage(data: f.id,editFunction:_editIndex);
                            }
                            return new CategoryPage(
                                data: f.id, list: f.childrens,subId:subId);
                          }).toList()
                        : navigationList.map((f) {
                            if (isBanner(f)) {
                              return new HotPage(data: f.id);
                            }
                            return new CategoryPage(
                                data: f.id, list: f.childrens, subId:subId);
                          }).toList(),
                  ),
                ),
              );
            });
          } else {
            return Container();
          }
        });
  }
}
