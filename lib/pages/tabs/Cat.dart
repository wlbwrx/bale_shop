import 'package:bale_shop/provide/footmark.dart';
import 'package:bale_shop/widgets/cart/toast.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/cart.dart';
import 'package:bale_shop/provide/currentIndex.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:bale_shop/widgets/loadingDialog.dart';
import 'package:bale_shop/api/home.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'dart:convert';
import 'package:bale_shop/apiModel/cart_recommend.dart';
import 'package:bale_shop/widgets/goods/goodsMouldFour.dart';
class CatPage extends StatefulWidget {
  CatPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  bool isChecked = true;
  Map arguments;
  static final facebookAppEvents = FacebookAppEvents();
  void initState() {
    arguments = widget.arguments;
    super.initState();
    if (arguments != null) {
      Future.delayed(Duration(microseconds: 500), () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new LoadingDialog(
                text: null,
              );
            });
        List cartList = Provide.value<CartProvide>(context).cartList;
         List footList = Provide.value<FootMarkProvide>(context).footMarkList;
          String  cartInfoLast = Provide.value<CartProvide>(context).cartInfoLast;
        var orderProducts = [];
        cartList.forEach((item) {
          var _shoppingType = 3;

          if (item.shoppingType == 1 || item.shoppingType == 3) {
            _shoppingType = 3;
          }
          if (item.shoppingType == 2 || item.shoppingType == 4) {
            _shoppingType = 4;
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
            "shoppingType": _shoppingType,
          };
          orderProducts.add(newGoods);
        });
        orderPrice({"orderProducts": orderProducts}).then((val) {
          Navigator.pop(context);
          if (val != 500) {
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
                  cartRecommend("productIds=${footText}&carProductIds=${cartText}").then((value) {
                    Provide.value<CartProvide>(context).saveList(value);
                  });
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
                  val.body.products[i].isLimitProduct != null
                      ? val.body.products[i].isLimitProduct
                      : false);
              num += val.body.products[i].quantity;
            }
            Provide.value<CurrentIndexProvide>(context).changeCatNum(num);
          }
        });
      });
    }
  }

  Widget _cartCheckBt(context, item) {
    return GestureDetector(
      onTap: () {
        item.isSelect = !item.isSelect;
        Provide.value<CartProvide>(context).changeCheckState(item);
      },
      child: Container(
          child: item.isSelect
              ? Image.asset(
                  "assets/icons/icon_check.png",
                  width: 20,
                  height: 20,
                )
              : Image.asset(
                  "assets/icons/icon_no_check.png",
                  width: 20,
                  height: 20,
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          leading: arguments != null
              ? GestureDetector(
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
                  ))
              : null,
          title: Text(
            '購物車',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
            future: _getCartInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provide<CartProvide>(
                    builder: (context, child, childCatgory) {
                  double discountTotalPrice =
                      Provide.value<CartProvide>(context)
                          .discountTotalPrice; //折扣价
                  List cartList = Provide.value<CartProvide>(context).cartList;
                  int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount; //数量
                  double price = Provide.value<CartProvide>(context).price; //优惠金额
                  String likeString = Provide.value<CartProvide>(context).cartLikeString;
                  final jsonResponse = json.decode(likeString);
                  cart_recommend model = cart_recommend.fromJson(jsonResponse);

                  return Stack(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              cartList.length > 0 ? 43 : 0,
                              0,
                              cartList.length > 0 ? 45 : 0),
                          color: Color(0xFFF4F4F4),
                          child: ListView(
                            children: cartItem(cartList, model,context),
                          )),
                      Positioned(
                          child: cartList.length > 0
                              ? Container(
                                  height: 44,
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      discountTotalPrice < 699
                                          ? Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 12, 15, 12),
                                              color: Color(0xFFFFFCEE),
                                              height: 44,
                                              child: Row(
                                                children: <Widget>[
                                                  new Expanded(
                                                      child: Text(
                                                    '再買\$${doubleText(699 - discountTotalPrice)}，免運費',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFF9670F),
                                                        fontSize: 14),
                                                  )),
                                                  Provide<CurrentIndexProvide>(
                                                      builder: (context, child,
                                                          childCatgory) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Provide.value<CurrentIndexProvide>(context).changeIndex(0);
                                                        Navigator.popUntil(context,ModalRoute.withName('/home'));
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          new Text(
                                                            '繼續逛 ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFF9670F),
                                                            ),
                                                          ),
                                                          Image.asset(
                                                            "assets/icons/icon-back-right.png",
                                                            width: 6,
                                                            height: 10,
                                                            color: Color(
                                                                0xFFF9670F),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  })
                                                ],
                                              ))
                                          : Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 12, 15, 12),
                                              color: Color(0xFFFFFCEE),
                                              height: 44,
                                              child: Row(
                                                children: <Widget>[
                                                  new Expanded(
                                                      child: Text(
                                                    '已免運費',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFF9670F),
                                                        fontSize: 14),
                                                  )),
                                                  Provide<CurrentIndexProvide>(
                                                      builder: (context, child,
                                                          childCatgory) {
                                                    return InkWell(
                                                      onTap: () {
                                                          Provide.value<CurrentIndexProvide>(context).changeIndex(0);
                                                          Navigator.popUntil(context,ModalRoute.withName('/home'));
                                                      },
                                                      child: Row(
                                                        children: <Widget>[
                                                          new Text(
                                                            '再逛逛 ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFF9670F),
                                                            ),
                                                          ),
                                                          Image.asset(
                                                            "assets/icons/icon-back-right.png",
                                                            width: 6,
                                                            height: 10,
                                                            color: Color(
                                                                0xFFF9670F),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  })
                                                ],
                                              )),
                                    ],
                                  ),
                                )
                              : Container()),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: cartList.length > 0
                              ? Container(
                                  height: arguments != null
                                      ? 54.5 + bottomPadding
                                      : 54.5,
                                  padding: EdgeInsets.only(
                                      left: 12,
                                      right: 10,
                                      bottom: arguments != null
                                          ? bottomPadding
                                          : 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(
                                            width: 0.5,
                                            color: Color(0xFFDFDEDB)), //有边框
                                      )),
                                  child: Row(
                                    children: <Widget>[
                                      // Container(
                                      //     margin:
                                      //         EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      //     child: GestureDetector(
                                      //       onTap: () {
                                      //         Provide.value<CartProvide>(
                                      //                 context)
                                      //             .changeAllCheck(!checktype);
                                      //       },
                                      //       child: Container(
                                      //           child: checktype
                                      //               ? Image.asset(
                                      //                   "assets/icons/icon_check.png",
                                      //                   width: 20,
                                      //                   height: 20,
                                      //                 )
                                      //               : Image.asset(
                                      //                   "assets/icons/icon_no_check.png",
                                      //                   width: 20,
                                      //                   height: 20,
                                      //                 )),
                                      //     )),
                                      // Text(
                                      //   '全選',
                                      //   style: TextStyle(
                                      //       color: Color(0xFF7B7B7B),
                                      //       fontSize: 14),
                                      // ),
                                      Expanded(
                                        child: Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 4, 8, 0),
                                            alignment: Alignment.centerLeft,
                                            child: price > 0
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 6, 0, 0),
                                                            child: Text(
                                                              '合計:\$',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFED1B2E),
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                          Text(
                                                            '${doubleText(discountTotalPrice + (discountTotalPrice < 699 ? 60 : 0))}',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFFED1B2E),
                                                                fontSize: 22),
                                                          ),
                                                        ],
                                                      ),
                                                      discountTotalPrice < 699
                                                          ? Text(
                                                              '含運費\$60',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0xFF777777)),
                                                            )
                                                          : Text(
                                                              '已免運費',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0xFF777777)),
                                                            )
                                                    ],
                                                  )
                                                : Text(
                                                    '\$${doubleText(discountTotalPrice)}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFED1B2E),
                                                        fontSize: 22),
                                                  )),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return new LoadingDialog(
                                                  text: null,
                                                );
                                              });
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          String tel = "";

                                          tel = prefs.getString('tel');
                                          List cartList =
                                              Provide.value<CartProvide>(
                                                      context)
                                                  .cartList;
                                          var orderProducts = [];
                                          cartList.forEach((item) {
                                            var _shoppingType = 3;
                                            if (item.shoppingType == 1 ||
                                                item.shoppingType == 3) {
                                              _shoppingType = 3;
                                            }
                                            if (item.shoppingType == 2 ||
                                                item.shoppingType == 4) {
                                              _shoppingType = 4;
                                            }
                                            var newGoods = {
                                              'productId': item.productId,
                                              'productTitle': item.productTitle,
                                              'quantity': item.quantity,
                                              'productSkuId': item.productSkuId,
                                              'productSkuBarcode':
                                                  item.productSkuBarcode,
                                              'productSkuName':
                                                  item.productSkuName,
                                              'productImageUrl':
                                                  item.productImageUrl,
                                              'isSelect': item.isSelect,
                                              'productPrice': item.productPrice,
                                              'originalPrice':
                                                  item.originalPrice,
                                              "discountPrice":
                                                  item.discountPrice,
                                              "shoppingType": _shoppingType
                                            };
                                            orderProducts.add(newGoods);
                                          });

                                          orderPrice({
                                            "orderProducts": orderProducts
                                          }).then((val) {
                                            Navigator.of(context).pop();
                                            if (val != 500) {
                                              Provide.value<CartProvide>(
                                                      context)
                                                  .remove();
                                              int num = 0;
                                              List contentIDs = [];
                                              List contentItem = [];
                                              for (var i = 0;
                                                  i < val.body.products.length;
                                                  i++) {
                                                if (val.body.products[i]
                                                        .isSelect ==
                                                    true) {
                                                  contentIDs.add(val.body
                                                      .products[i].productId);
                                                  contentItem.add({
                                                    "id": val.body.products[i]
                                                        .productSkuId,
                                                    "quantity": val.body
                                                        .products[i].quantity,
                                                    "item_price": val
                                                                .body
                                                                .products[i]
                                                                .shoppingType ==
                                                            "4"
                                                        ? val.body.products[i]
                                                            .price
                                                        : val.body.products[i]
                                                            .originalPrice
                                                  });
                                                }

                                                Provide.value<CartProvide>(
                                                        context)
                                                    .save(
                                                        val.body.products[i]
                                                            .productId,
                                                        val.body.products[i]
                                                            .productTitle,
                                                        val.body.products[i]
                                                            .quantity,
                                                        val.body.products[i]
                                                            .productSkuId,
                                                        val.body.products[i]
                                                            .productSkuBarcode,
                                                        val.body.products[i]
                                                            .productSkuName,
                                                        val.body.products[i]
                                                            .productImageUrl,
                                                        val.body.products[i]
                                                            .isSelect,
                                                        val.body.products[i]
                                                            .price,
                                                        val.body.products[i]
                                                            .originalPrice,
                                                        val.body.products[i]
                                                            .discountPrice,
                                                        val.body.products[i]
                                                            .shoppingType,
                                                        val.body.products[i]
                                                            .isLimitProduct);
                                                num += val
                                                    .body.products[i].quantity;
                                              }

                                              Provide.value<
                                                          CurrentIndexProvide>(
                                                      context)
                                                  .changeCatNum(num);

                                              if (tel != "" && tel != null) {
                                                if (allGoodsCount > 0) {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          "/placeAnOrder");
                                                } else {
                                                  Toast.toast(context,
                                                      msg: "請選購商品",
                                                      position:
                                                          ToastPostion.center);
                                                }
                                              } else {
                                                if (allGoodsCount > 0) {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          "/login",
                                                          arguments: {
                                                        "type": 1
                                                      });
                                                } else {
                                                  Toast.toast(context,
                                                      msg: "請選購商品",
                                                      position:
                                                          ToastPostion.center);
                                                }
                                              }
                                            }
                                          });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 108,
                                            height: 38,
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 2),
                                            padding:
                                                EdgeInsets.fromLTRB(0, 8, 0, 8),
                                            decoration: BoxDecoration(
                                              color: allGoodsCount > 0
                                                  ? Color(0xFFED1B2E)
                                                  : Colors.black38,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '下單(${allGoodsCount})',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                )
                              : Container()),
                    ],
                  );
                });
              } else {
                return Text('正在加载');
              }
            }));
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getList();
    await Provide.value<FootMarkProvide>(context).getList();
    return 'end';
  }

  //减少按钮
  Widget _reduceBtn(context, item) {
    return InkWell(
      onTap: () {
        if (item.quantity > 1) {
          item.quantity--;
          Provide.value<CartProvide>(context).changeCheckState(item);
          int catNum = Provide.value<CurrentIndexProvide>(context).catNum;
          Provide.value<CurrentIndexProvide>(context).changeCatNum(catNum - 1);
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(32),
        height: ScreenUtil().setHeight(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          '-',
          style: TextStyle(
              color: item.quantity <= 1 ? Colors.black12 : Colors.black,
              fontSize: 24),
        ),
      ),
    );
  }

  //加号按钮
  Widget _addBtn(context, item) {
    return InkWell(
      onTap: () {
        item.quantity++;
        Provide.value<CartProvide>(context).changeCheckState(item);
        int catNum = Provide.value<CurrentIndexProvide>(context).catNum;
        Provide.value<CurrentIndexProvide>(context).changeCatNum(catNum + 1);
      },
      child: Container(
        width: ScreenUtil().setWidth(32),
        height: ScreenUtil().setHeight(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          '+',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  //中间数量显示区域

  Widget _countArea(quantity) {
    return Container(
      width: ScreenUtil().setWidth(44),
      height: ScreenUtil().setHeight(32),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '${quantity}',
        style: TextStyle(fontSize: 17),
      ),
    );
  }

  List<Widget> cartItem(cartList,model, context) {
    final size = MediaQuery.of(context).size;
    List<Widget> item = [];
    for (var index = 0; index < cartList.length; index++) {
      item.add(Container(
        padding: EdgeInsets.fromLTRB(
            12,
            12,
            12,
            cartList[index].isLimitProduct != null &&
                    cartList[index].isLimitProduct == true
                ? 4
                : 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: index == 0 ? Radius.circular(8) : Radius.circular(0),
            topLeft: index == 0 ? Radius.circular(8) : Radius.circular(0),
            bottomLeft: index == cartList.length - 1
                ? Radius.circular(8)
                : Radius.circular(0),
            bottomRight: index == cartList.length - 1
                ? Radius.circular(8)
                : Radius.circular(0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _cartCheckBt(context, cartList[index]),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/detail",
                        arguments: {"id": cartList[index].productId});
                  },
                  child: Container(
                    height: 90,
                    width: 90,
                    margin: EdgeInsets.fromLTRB(12, 0, 10, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: cartList[index].productImageUrl != null
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                'assets/icons/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                              imageUrl:
                                  "http:" + cartList[index].productImageUrl,
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/icons/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              // cartList[index]
                              //             .productPrice <
                              //         cartList[index]
                              //             .originalPrice
                              //     ? Container(
                              //         padding:
                              //             EdgeInsets
                              //                 .fromLTRB(
                              //                     4,
                              //                     1,
                              //                     4,
                              //                     1),
                              //         margin: EdgeInsets
                              //             .fromLTRB(0,
                              //                 0, 4, 0),
                              //         decoration: BoxDecoration(
                              //             color: Color(
                              //                 0xFFFEEFE7),
                              //             borderRadius:
                              //                 BorderRadius.all(
                              //                     Radius.circular(
                              //                         3))),
                              //         child: Text(
                              //           '限時',
                              //           style:
                              //               TextStyle(
                              //             fontSize: 10,
                              //             color: Color(
                              //                 0xFFF9670F),
                              //           ),
                              //         ),
                              //       )
                              //     : Container(),
                              Expanded(
                                  child: Text(
                                cartList[index].productTitle,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF777777),
                                    decoration: TextDecoration.none),
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                            padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                            decoration: BoxDecoration(
                                color: Color(0xFFF9F9F9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            child: Text(cartList[index].productSkuName),
                          ),
                          Row(
                            children: <Widget>[
                              cartList[index].shoppingType == 2 ||
                                      cartList[index].shoppingType == 4
                                  ? Column(
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Text(
                                              "\$${doubleText(cartList[index].discountPrice)}",
                                              style: TextStyle(
                                                  color: Color(0xFFED1B2E),
                                                  fontSize: 14)),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Text(
                                              "\$${doubleText(cartList[index].originalPrice)}",
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Color(0xFF777777),
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 12, 0, 0),
                                          child: Text(
                                              "\$${doubleText(cartList[index].productPrice)}",
                                              style: TextStyle(
                                                  color: Color(0xFF222222),
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return new AlertDialog(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                              titlePadding: EdgeInsets.fromLTRB(
                                                  0, 16, 0, 24),
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(8),
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  )),
                                              title: Container(
                                                alignment: Alignment.center,
                                                child: new Text(
                                                  "確定要刪除此商品吗?",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF222222),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              content: Container(
                                                  height: 180,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                            height: 73,
                                                            width: 73,
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    10, 0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child: cartList[index]
                                                                          .productImageUrl !=
                                                                      null
                                                                  ? CachedNetworkImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/icons/placeholder.png',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      imageUrl:
                                                                          "http:" +
                                                                              cartList[index].productImageUrl,
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/icons/placeholder.png',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    )
                                                                  : Container(),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                            height:
                                                                                20,
                                                                            child:
                                                                                Container(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(
                                                                                cartList[index].productTitle,
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  color: Color(0xFF777777),
                                                                                ),
                                                                              ),
                                                                            )),
                                                                        Container(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              6,
                                                                              6,
                                                                              6,
                                                                              6),
                                                                          decoration: BoxDecoration(
                                                                              color: Color(0xFFF9F9F9),
                                                                              borderRadius: BorderRadius.all(Radius.circular(6))),
                                                                          child:
                                                                              Text(
                                                                            cartList[index].productSkuName,
                                                                            style:
                                                                                TextStyle(fontSize: 14),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.fromLTRB(
                                                                              0,
                                                                              6,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Row(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                width: 100,
                                                                                child: Text("\$${doubleText(cartList[index].productPrice)}", style: TextStyle(color: Color(0xFFED1B2E), fontSize: 14)),
                                                                              ),
                                                                              Expanded(
                                                                                child: Container(
                                                                                  alignment: Alignment.centerRight,
                                                                                  child: Text(
                                                                                    "x${cartList[index].quantity}",
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                      color: Color(0xFF777777),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ])))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Provide.value<
                                                                              CartProvide>(
                                                                          context)
                                                                      .del(cartList[
                                                                          index]);
                                                                  int catNum =
                                                                      Provide.value<CurrentIndexProvide>(
                                                                              context)
                                                                          .catNum;
                                                                  Provide.value<
                                                                              CurrentIndexProvide>(
                                                                          context)
                                                                      .changeCatNum(
                                                                          catNum -
                                                                              cartList[index].quantity);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          26,
                                                                          5,
                                                                          0),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: 120.0,
                                                                  height: 38.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25.0),
                                                                    border: new Border
                                                                            .all(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                  child: Text(
                                                                    '確定刪除',
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFFED1B2E),
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ),
                                                              flex: 1),
                                                          Expanded(
                                                              child: GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Container(
                                                                        margin: EdgeInsets.fromLTRB(
                                                                            5,
                                                                            26,
                                                                            0,
                                                                            0),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        width:
                                                                            120.0,
                                                                        height:
                                                                            38.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          color:
                                                                              Color(0xFFED1B2E),
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          border: new Border.all(
                                                                              width: 1,
                                                                              color: Color(0xFFED1B2E)),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          '再考慮一下',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ))),
                                                              flex: 1),
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                              // actions: <Widget>[
                                              //   new FlatButton(
                                              //     onPressed:
                                              //         () {
                                              //       Provide.value<CartProvide>(context).del(cartList[index]);
                                              //       Navigator.of(context).pop();
                                              //     },
                                              //     child: new Text(
                                              //         "確認",
                                              //         style: TextStyle(color: Colors.red)),
                                              //   ),
                                              //   new FlatButton(
                                              //     onPressed:
                                              //         () {
                                              //       Navigator.of(context).pop();
                                              //     },
                                              //     child:
                                              //         new Text("取消"),
                                              //   ),
                                              // ],
                                            );
                                          });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                                      child: Image.asset(
                                          "assets/icons/icon-del1.png",
                                          width: 18,
                                          height: 18),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black12),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        _reduceBtn(context, cartList[index]),
                                        _countArea(cartList[index].quantity),
                                        _addBtn(context, cartList[index])
                                      ],
                                    ),
                                  )
                                ],
                              )),
                            ],
                          ),
                        ],
                      )),
                  flex: 2,
                ),
              ],
            ),
            cartList[index].isLimitProduct != null &&
                    cartList[index].isLimitProduct == true
                ? Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(
                            30, 12, 0, index == cartList.length - 1 ? 8 : 0),
                        child: Image.asset(
                          "assets/icons/icon-heed.png",
                          width: 12,
                          height: 12,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            4, 12, 0, index == cartList.length - 1 ? 8 : 0),
                        child: Text(
                          '限量出清，不可退換',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFED1B2E),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ));
    }
    if (cartList.length < 1) {
      item.add(Container(
        color: Colors.white,
        height: 320,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Image.asset(
                "assets/images/cart-empty.png",
                width: 200,
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                child: Text(
                  "您還沒有添加任何商品喲",
                  style: TextStyle(color: Color(0xFF777777), fontSize: 14),
                )),
            GestureDetector(
                onTap: () {
                  if (arguments != null) {
                    Navigator.pop(context);
                  } else {
                    Provide.value<CurrentIndexProvide>(context).changeIndex(0);
                  }
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                  alignment: Alignment.center,
                  width: 180.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25.0),
                    border: new Border.all(width: 1, color: Colors.red),
                  ),
                  child: Text(
                    arguments != null ? "繼續逛" : "去逛逛",
                    style: TextStyle(
                        color: Color(0xFFED1B2E),
                        fontSize: 16,
                        letterSpacing: 1),
                  ),
                )),
          ],
        ),
      ));
    }

    // item.add(
    //   Container(
    //       color: Color(0xFFF4F4F4),
    //       alignment: Alignment.center,
    //       padding: EdgeInsets.fromLTRB(12, 12, 0, 12),
    //       child: Text(
    //         "您可能喜歡",
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color:Color(0xFF222222)),
    //       )),
    // );
    // item.add(
    //   Container(
    //     color: Color(0xFFF4F4F4),
    //     alignment: Alignment.centerLeft,
    //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    //     child: GridView.builder(
    //         itemCount: model.body.length,
    //         shrinkWrap: true,
    //         physics: new NeverScrollableScrollPhysics(),
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 2, //Grid按两列显示
    //           mainAxisSpacing: 10,
    //           crossAxisSpacing: 10,
    //           childAspectRatio: sizeHeight2(size.height),
    //         ),
    //         itemBuilder: (BuildContext context, int index) {
    //           return GestureDetector(
    //               onTap: () {
    //                 Navigator.of(context).pushNamed("/detail", arguments: {
    //                       "id": model.body[index].id,
    //                       "isIndex": 2
    //                     });
    //               },
    //               child: GoodsMouldFour(data: [model.body[index]]));
    //         }),
    //   ),
    // );
    return item;
  }
}
