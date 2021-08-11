import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:bale_shop/apiModel/cartInfo.dart';
import 'package:bale_shop/apiModel/cart_recommend.dart';
class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];
  String cartInfoLast = "";
  String cartLikeString = '{"body":[],"headers":{"digest":["80A01D81407F5E389533301CDFA44E7F"]},"statusCode":"OK","statusCodeValue":200}';
  bool checktype = false;
  double discountTotalPrice = 0; //折扣价
  double originalTotalPrice = 0; //原价
  double price = 0; //优惠金额
  double freight = 0; //运费
  double priceCart = 0;
  double spreadPrice = 0;
  int discountTotalCouponPrice = 0;
  int allGoodsCount = 0;
  save(
      productId,
      productTitle,
      quantity,
      productSkuId,
      productSkuBarcode,
      productSkuName,
      productImageUrl,
      isSelect,
      productPrice,
      originalPrice,
      discountPrice,
      shoppingType,
      isLimitProduct,
    ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    prefs.setString('cartInfoLast',"${productId}");
    cartInfoLast = "${productId}";
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      if (item['productSkuId'] == productSkuId &&
          (item['productPrice']) == productPrice) {
        tempList[ival]['quantity'] = item['quantity'] + quantity;
        cartList[ival].quantity = item['quantity'] + quantity;
        isHave = true;
      }
      ival++;
    });
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'productId': productId,
        'productTitle': productTitle,
        'quantity': quantity,
        'productSkuId': productSkuId,
        'productSkuBarcode': productSkuBarcode,
        'productSkuName': productSkuName,
        'productImageUrl': productImageUrl,
        'isSelect': isSelect,
        'productPrice': productPrice,
        'originalPrice': originalPrice,
        "discountPrice": discountPrice,
        "shoppingType":shoppingType,
        "isLimitProduct":isLimitProduct!=null?isLimitProduct:false
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.formJson(newGoods));
    }
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getList();
  }

  saveList(listString)async {
     cartLikeString = listString;
     notifyListeners();
  }

  changeList(cartList,_discountTotalCouponPrice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    String _cartInfoLast = prefs.getString('cartInfoLast');
    cartInfoLast = _cartInfoLast;
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    for (var i = 0; i < cartList.length; i++) {
      int tempIndex = 0;
      tempList.forEach((item) {
        if (item['productSkuId'] == cartList[i].productSkuId &&
            (item['productPrice']) == cartList[i].productPrice) {
          tempList[tempIndex]['productId'] = cartList[i].productId;
          tempList[tempIndex]['productTitle'] = cartList[i].productTitle;
          tempList[tempIndex]['quantity'] = cartList[i].quantity;
          tempList[tempIndex]['productSkuId'] = cartList[i].productSkuId;
          tempList[tempIndex]['productSkuBarcode'] = cartList[i].productSkuBarcode;
          tempList[tempIndex]['productSkuName'] = cartList[i].productSkuName;
          tempList[tempIndex]['productImageUrl'] = cartList[i].productImageUrl;
          tempList[tempIndex]['isSelect'] = cartList[i].isSelect;
          tempList[tempIndex]['productPrice'] = cartList[i].price;
          tempList[tempIndex]['originalPrice'] = cartList[i].originalPrice;
          tempList[tempIndex]['discountPrice'] = cartList[i].discountPrice;
          tempList[tempIndex]['shoppingType'] = cartList[i].shoppingType;
          tempList[tempIndex]['isLimitProduct']= cartList[i].isLimitProduct!=null?cartList[i].isLimitProduct:false;
        }
        tempIndex++;
      });

    }
    discountTotalCouponPrice = _discountTotalCouponPrice;
    cartString = json.encode(tempList).toString();
    prefs.setString("cartInfo", cartString);
    await getList();
  }

  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['productSkuId'] == cartItem.productSkuId &&
          (item['productPrice']) == cartItem.productPrice) {
        changeIndex = tempIndex;
      };
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString("cartInfo", cartString);
    await getList();
  }

  del(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['productSkuId'] == cartItem.productSkuId &&
          (item['productPrice']) == cartItem.productPrice) {
        delIndex = tempIndex;
      };
      tempIndex++;
    });

    tempList.removeAt(delIndex);

    cartString = json.encode(tempList).toString();
    prefs.setString("cartInfo", cartString);

    await getList();
  }

  getList() async {
    int index = 0;
    int checkIndex = 0;
    discountTotalPrice = 0; //折扣价
    originalTotalPrice = 0; //原价
    price = 0; //优惠金额
    allGoodsCount = 0; //数量
    spreadPrice = 0;
    double _discountTotalPrice = 0;
    double _originalTotalPrice = 0;
    double _price = 0;
    double _spreadPrice = 0;
    int _allGoodsCount =0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    
      for(var i=0;i<tempList.length;i++){
         var item = tempList[i];
         if (item['isSelect']) {
          checkIndex++;
          _allGoodsCount += item['quantity'];
          _discountTotalPrice += (item['productPrice'] * item['quantity']);
          _originalTotalPrice += (item['originalPrice'] * item['quantity']);
          if (item['shoppingType'] == 2 || item['shoppingType'] == 4 ) {
            _spreadPrice+= ((item['originalPrice'] - item['discountPrice']) * item['quantity']);
          }
        }
        index++;
        cartList.add(CartInfoModel.formJson(item));
      }
      
       

      //全选
      if (checkIndex == index) {
        checktype = true;
      } else {
        checktype = false;
      }
      _price = _originalTotalPrice - _discountTotalPrice - discountTotalCouponPrice;
      if (_discountTotalPrice < 699) {
        freight = 60;
      }
      if (_discountTotalPrice >= 699) {
        freight = 0;
        _spreadPrice=0;
      }

      prefs.setBool('allCheck', checktype);
    } 
    
    print('原价${_originalTotalPrice}');
    originalTotalPrice = _originalTotalPrice;
    print('优惠价${_discountTotalPrice}');
    discountTotalPrice = _discountTotalPrice;
    print('优惠${price}');
    price = _price;
    print('数量${_allGoodsCount}');
    allGoodsCount = _allGoodsCount;
    print("需補差價${_spreadPrice}");
    spreadPrice = _spreadPrice;
    notifyListeners();
  }

  //点击全选按钮操作
  changeAllCheck(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem["isSelect"] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getList();
  }

  removeList(list)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
     List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
     List<Map> newList = [];
     for(var i=0;i<tempList.length;i++){
       bool lock = true;
       for(var x=0;x<list.length;x++){
         if(tempList[i]['productSkuId'] == list[x]["productSkuId"] &&
          (tempList[i]['productPrice']) == list[x]["productPrice"]){
            lock = false;
         }
       }
       if(lock){
        newList.add(tempList[i]);
       }
     }
     cartString = json.encode(newList).toString();
     prefs.setString('cartInfo', cartString);
     print(cartString);
     print('清空部分----------------------------');
     await getList();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    print('清空完成----------------------------');
    notifyListeners();
  }
}
