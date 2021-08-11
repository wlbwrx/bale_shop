import 'dart:async';

import 'package:bale_shop/provide/footmark.dart';
import 'package:flutter/material.dart';
import 'package:bale_shop/widgets/cart/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tabs/home.dart';
import 'tabs/category.dart';
import 'tabs/setting.dart';
import 'tabs/cat.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/currentIndex.dart';
import 'package:badges/badges.dart';
import 'package:bale_shop/api/home.dart';
import 'package:bale_shop/widgets/loadingDialog.dart';
import 'package:bale_shop/provide/cart.dart';
import 'dart:convert';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:bale_shop/apiModel/jpush_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:bale_shop/utils/tool.dart';
class Tabs extends StatefulWidget {
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  
  
  final bodyList = [HomePage(tabIndex:0), CategoryPage(), CatPage(), SeetingPage()];
  JPush jpush = new JPush(); /* 初始化极光插件*/
  

  String debugLable = 'Unknown'; /*错误信息*/
 
 
  String iosVersion = getVersionIos();
  String androidVersion = getVersionAndroid();

 
  @override
  void initState() {
    // TODO: implement initState
    String isVersion = "";
    String isPlatform = "";
    
    if (Platform.isIOS) {
      isVersion = iosVersion;
      isPlatform = "up-ios";
    } else if (Platform.isAndroid) {
      isVersion = androidVersion;
      isPlatform = "up-android";
    }
    isCheckVersion(isPlatform,isVersion);
    jpush.setup(
        appKey: 'b7ded6cdf99d2b8d79686dc1',
        channel: 'developer-default',
        production: true,
        debug: false);

    /// 监听jpush
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));
    jpush.addEventHandler(
      onReceiveNotification: (Map<String, dynamic> message) async {
        print(message);
      },
      onOpenNotification: (Map<String, dynamic> message) async {
        /// 点击通知栏消息，在此时通常可以做一些页面跳转等
        print('Flutter JPush 点击通知消息:\n $message');
        var a = "";
        //安卓
        if (message['extras']['cn.jpush.android.EXTRA'] != null) {
          a = message['extras']['cn.jpush.android.EXTRA'];
          final jsonResponse = json.decode(a);
          jpush_model model = jpush_model.fromJson(jsonResponse);
          if (model.product != null) {
            Navigator.of(context)
                .pushNamed("/detail", arguments: {"id": model.product});
          }
        }
        //IOS
        if (message['product'] != null) {
          Navigator.of(context)
              .pushNamed("/detail", arguments: {"id": message['product']});
        }
      },
    );
    jpush.isNotificationEnabled().then((bool value) {
      print("通知授权是否打开: $value");
      if (!value) {
        _showCalljPushDialog();
      }
    }).catchError((onError) {
      setState(() {
        debugLable = "通知授权是否打开: ${onError.toString()}";
      });
    });
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
      setState(() {
        debugLable = "flutter get registration id :$rid";
      });
    });

    jpush.getLaunchAppNotification().then((map) {
      if (map['product'] != null) {
        Navigator.of(context).pushNamed("/detail", arguments: {"id": map['product']});
      }
    });

   
     super.initState();
  }


  

   

  isCheckVersion(isPlatform,isVersion) async{
    var today = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartString = prefs.getString('versionDate');
    checkVersion(isPlatform, isVersion).then((val) {
      String dateText = "${today.year}${today.month}${today.day}";
      if (val.body.isNeedUpdate){
        if(val.body.isMustUpdate){
           Future.delayed(Duration.zero, () {
             _showVersionDialog(val.body.isMustUpdate);
           });
        }else if(dateText!=cartString){
          prefs.setString('versionDate',dateText);
          Future.delayed(Duration.zero, () {
             _showVersionDialog(val.body.isMustUpdate);
           });
        }
      } 
    });
  }
  _showCalljPushDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('是否開啟通知，接收最新的商品推薦'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => {Navigator.of(context).pop()},
                child: Text('暫不開啟'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  jpush.openSettingsForNotification();
                },
                child: Text('去開啟'),
              ),
            ],
          );
        });
  }

  _showVersionDialog(must) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('app發現新的版本，請前往應用商店更新'),
            actions: <Widget>[
              must
                  ? FlatButton(
                      onPressed: () {
                        String isVersion = "";
                        String isPlatform = "";
                        if (Platform.isIOS) {
                          isVersion = iosVersion;
                          isPlatform = "up-ios";
                        } else if (Platform.isAndroid) {
                          isVersion = androidVersion;
                          isPlatform = "up-android";
                        }
                        checkVersion(isPlatform, isVersion).then((val) {
                          if (!val.body.isNeedUpdate) {
                             Navigator.of(context).pop();
                          } else {
                             Toast.toast(context,
                                msg: "未更新成功", position: ToastPostion.bottom);
                          }
                        });
                      },
                      child: Text('已更新'),
                    )
                  : FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('暂不更新'),
                    ),
              FlatButton(
                onPressed: () {
                  if (Platform.isIOS) {
                    print("IOS");
                    _launchURL("https://apps.apple.com/cn/app/%E9%98%BF%E5%99%97%E7%89%B9%E8%B3%A3-%E4%BD%8E%E8%87%B31%E6%8A%98%E6%9C%8D%E9%A3%BE%E7%BE%8E%E5%A6%9D%E9%9E%8B%E5%8C%85%E9%85%8D%E9%A3%BE/id1481554817");
                    //ios相关代码
                  } else if (Platform.isAndroid) {
                    print("安卓");
                    //android相关代码
                    _launchURL( "https://play.google.com/store/apps/details?id=io.dcloud.UNI7A85DF0");
                  }
                },
                child: Text('去更新'),
              ),
            ],
          );
        });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> _getCatNum(BuildContext context) async {
    await Provide.value<CurrentIndexProvide>(context).getCatNum();
    await Provide.value<FootMarkProvide>(context).getList();
    return 'end';
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return FutureBuilder(
        future: _getCatNum(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Provide<CurrentIndexProvide>(
                builder: (context, child, childCatgory) {
              int currentIndex =
               Provide.value<CurrentIndexProvide>(context).currentIndex;
              int catNum = Provide.value<CurrentIndexProvide>(context).catNum;
              return Scaffold(
                body: IndexedStack(
                  index: currentIndex,
                  children: bodyList,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: currentIndex, //配置对应的索引值选中
                  onTap: (int index) {
                    Provide.value<CurrentIndexProvide>(context).changeIndex(index);
                    if (index == 2) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return new LoadingDialog(
                              text: "",
                            );
                          });

                      List cartList = Provide.value<CartProvide>(context).cartList;
                      List footList = Provide.value<FootMarkProvide>(context).footMarkList;
                      String  cartInfoLast = Provide.value<CartProvide>(context).cartInfoLast;
                      var orderProducts = [];
                      cartList.forEach((item) {
                         var _shoppingType = 3;
                         
                        if(item.shoppingType==1 || item.shoppingType==3){
                          _shoppingType =3;
                        }
                        if(item.shoppingType==2 || item.shoppingType==4){
                          _shoppingType =4;
                        }
                        var newGoods = {
                          'productId': item.productId,
                          'productTitle': item.productTitle,
                          'quantity': item.quantity,
                          'productSkuId': item.productSkuId,
                          'productSkuBarcode': item.productSkuBarcode,
                          'productSkuName': item.productSkuName,
                          'productImageUrl': item.productImageUrl,
                          'isSelect': item.isSelect,
                          'productPrice': item.productPrice,
                          'originalPrice': item.originalPrice,
                          "discountPrice": item.discountPrice,
                          "shoppingType":_shoppingType,
                        };
                        orderProducts.add(newGoods);
                      });

                      orderPrice({"orderProducts": orderProducts}).then((val) {
                      var cartText = ""; 
                      var  footText = "";
                      int footIndex = 0;          
                      for(var i=0;i<val.body.products.length;i++){
                        if(i==0){
                          cartText+= "${val.body.products[i].productId}";
                        }else{
                          cartText+=",${val.body.products[i].productId}";
                        }
                      }
                      for(var i=footList.length-1;i>=0;i--){
                        footIndex++;
                        if(footIndex<19){
                          if(i==footList.length-1){
                            if(val.body.products.length>0){
                              footText+="${val.body.products[val.body.products.length-1].productId},${footList[i].id}";
                            }else{
                               if(cartInfoLast!=""){
                                  footText+="${cartInfoLast},${footList[i].id}";
                                }else{
                                  footText+="${footList[i].id}";
                                }
                            }
                          }else{
                            footText+=",${footList[i].id}";
                          }
                        }
                      }
                      cartRecommend("productIds=${cartText}&carProductIds=${footText}").then((value) {
                        Provide.value<CartProvide>(context).saveList(value);
                      });
                       Navigator.pop(context);
                        if(val!=500){
                            Provide.value<CartProvide>(context).remove();
                        int num = 0;
                        for (var i = 0; i < val.body.products.length; i++) {
                          Provide.value<CartProvide>(context).save(
                              val.body.products[i].productId,
                              val.body.products[i].productTitle,
                              val.body.products[i].quantity,
                              val.body.products[i].productSkuId,
                              val.body.products[i].productSkuBarcode,
                              val.body.products[i].productSkuName,
                              val.body.products[i].productImageUrl,
                              val.body.products[i].isSelect,
                              val.body.products[i].price,
                              val.body.products[i].originalPrice,
                              val.body.products[i].discountPrice,
                              val.body.products[i].shoppingType,
                              val.body.products[i].isLimitProduct!=null?val.body.products[i].isLimitProduct:false
                              );
                          num += val.body.products[i].quantity;
                        }
                        Provide.value<CurrentIndexProvide>(context).changeCatNum(num);
                       }
                       
                      });
                    }
                  },
                  iconSize: 36.0, //icon的大小
                  fixedColor: Colors.red, //选中的颜色
                  type: BottomNavigationBarType.fixed, //配置底部tabs可以有多个按钮
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/icons/icon-home.png",
                        width: 20,
                        height: 20,
                      ),
                      title: Text("首頁", style: TextStyle(fontSize: 10,color:Color(0xFF222222) )),
                      activeIcon: Image.asset(
                        "assets/icons/icon-home-c.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    BottomNavigationBarItem(
                        activeIcon: Image.asset(
                          "assets/icons/icon-search-c.png",
                          width: 20,
                          height: 20,
                        ),
                        icon: Image.asset(
                          "assets/icons/icon-search.png",
                          width: 20,
                          height: 20,
                        ),
                        title: Text("分類", style: TextStyle(fontSize: 10,color:Color(0xFF222222) ))),
                    BottomNavigationBarItem(
                        activeIcon: catNum > 0
                            ? Badge(
                                badgeColor: Color(0xFFED1B2E),
                                borderRadius: catNum < 10 ? BorderRadius.circular(10) : BorderRadius.circular(20),
                                elevation: 0,
                                toAnimate: false,
                                padding: EdgeInsets.fromLTRB(
                                    4,
                                    catNum < 10 ? 4 : 2,
                                    4,
                                    catNum < 10 ? 4 : 2),
                                shape: catNum < 10
                                    ? BadgeShape.circle
                                    : BadgeShape.square,
                                position: BadgePosition.topEnd(
                                    top: catNum < 10 ? -10 : -6,
                                    end: catNum < 10 ? -10 : -20),
                                badgeContent: Text(
                                  '${catNum}',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF), fontSize: 12),
                                ),
                                child: Image.asset(
                                  "assets/icons/icon-cart-c.png",
                                  width: 20,
                                  height: 20,
                                ))
                            : Image.asset(
                                "assets/icons/icon-cart-c.png",
                                width: 20,
                                height: 20,
                              ),
                        icon: catNum > 0
                            ? Badge(
                                badgeColor: Color(0xFFED1B2E),
                                borderRadius: catNum < 10 ? BorderRadius.circular(10) : BorderRadius.circular(20),
                                elevation: 0,
                                toAnimate: false,
                                padding: EdgeInsets.fromLTRB(
                                    4,
                                    catNum < 10 ? 4 : 2,
                                    4,
                                    catNum < 10 ? 4 : 2),
                                shape: catNum < 10
                                    ? BadgeShape.circle
                                    : BadgeShape.square,
                                position: BadgePosition.topEnd(
                                    top: catNum < 10 ? -10 : -6,
                                    end: catNum < 10 ? -10 : -20),
                                badgeContent: Text(
                                  '${catNum}',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF), fontSize: 12),
                                ),
                                child: Image.asset(
                                  "assets/icons/icon-cart.png",
                                  width: 20,
                                  height: 20,
                                ),
                              )
                            : Image.asset(
                                "assets/icons/icon-cart.png",
                                width: 20,
                                height: 20,
                              ),
                        title: Text("購物車", style: TextStyle(fontSize: 10,color:Color(0xFF222222) ))),
                    BottomNavigationBarItem(
                        activeIcon: Image.asset(
                          "assets/icons/icon-my-c.png",
                          width: 20,
                          height: 20,
                        ),
                        icon: Image.asset(
                          "assets/icons/icon-my.png",
                          width: 20,
                          height: 20,
                        ),
                        title: Text("我的", style: TextStyle(fontSize: 10,color:Color(0xFF222222) )))
                  ],
                ),
              );
            });
          } else {
            return Container();
          }
        });
  }
}
