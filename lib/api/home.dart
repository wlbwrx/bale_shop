import 'package:bale_shop/utils/HttpUtils.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:bale_shop/apiModel/home_banner.dart';
import 'package:bale_shop/apiModel/home_model.dart';
import 'package:bale_shop/apiModel/product_list.dart';
import 'package:bale_shop/apiModel/product_detail.dart';
import 'package:bale_shop/apiModel/classify.dart';
import 'package:bale_shop/apiModel/sms.dart';
import 'package:bale_shop/apiModel/login.dart';
import 'package:bale_shop/apiModel/submit.dart';
import 'package:bale_shop/apiModel/submit_pay.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:bale_shop/apiModel/like.dart';
import 'package:bale_shop/apiModel/order.dart';
import 'package:bale_shop/apiModel/favorite.dart';
import 'package:bale_shop/apiModel/my_favorite.dart';
import 'package:bale_shop/apiModel/order_price.dart';
import 'package:bale_shop/apiModel/order_price_a.dart';
import 'package:bale_shop/apiModel/user.dart';
import 'package:bale_shop/apiModel/order_list.dart';
import 'package:bale_shop/apiModel/logistics.dart';
import 'package:bale_shop/apiModel/payment.dart';
import 'package:bale_shop/apiModel/hot_word.dart';
import 'package:bale_shop/apiModel/search_word.dart';
import 'package:bale_shop/apiModel/search_list.dart';
import 'package:bale_shop/apiModel/version.dart';
import 'package:bale_shop/apiModel/cancel_order.dart';
import 'package:bale_shop/apiModel/saleservice_delivery.dart';
import 'package:bale_shop/apiModel/saleservice_detail.dart';
import 'package:bale_shop/apiModel/saleservice_list.dart';
import 'package:bale_shop/apiModel/saleservice_order_list.dart';
import 'package:bale_shop/apiModel/product_sku.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:facebook_app_events/facebook_app_events.dart';


Future<String> _loadAssets() async {
  return await HttpUtils.request(
    'api/aggregate/page/secondaryNavigation',
    method: HttpUtils.GET,
  );
}

Future loadJSDataModel() async {
  String jsonString = await _loadAssets();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('homeNavigation', jsonString);
  final jsonResponse = json.decode(jsonString);
  home_banner model = home_banner.fromJson(jsonResponse);
  return model;
}

Future<String> _moduleIdsInfo(data) async {
  return await await HttpUtils.request(
    'api/aggregate/page/moduleIds/info/$data',
    method: HttpUtils.GET,
  );
}

Future moduleIdsInfo(data) async {
  String jsonString = await _moduleIdsInfo(data);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('model${data}', jsonString);
  final jsonResponse = json.decode(jsonString);
  home_model model = home_model.fromJson(jsonResponse);
  return model;
}

Future<String> _productList(data) async {
  return await await HttpUtils.request(
    'api/aggregate/page/moduleIds/details?aggregateModuleIds[0]=$data'+'&v=${getVersionIos()}',
    method: HttpUtils.GET,
  );
}

Future productList(data) async {
  String jsonString = await _productList(data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('product${data}', jsonString);
  final jsonResponse = json.decode(jsonString);
  product_list model = product_list.fromJson(jsonResponse);
  return model;
}

Future<String> _producDetail(data) async {
  return await await HttpUtils.request(
    'api/product/info/$data'+'?v=${getVersionIos()}',
    method: HttpUtils.GET,
  );
}

Future producDetail(data) async {
  String jsonString = await _producDetail(data);
  final jsonResponse = json.decode(jsonString);
  product_detail model = product_detail.fromJson(jsonResponse);
  return model;
}

Future<String> _producSub(data) async {
  final facebookAppEvents = FacebookAppEvents();
  facebookAppEvents.logEvent(
       name:"fb_mobile_content_view",
       parameters: {
         "fb_content_type":'分类页',
         "fb_content_id":'${data}'
       }
  );
  return await await HttpUtils.request(
    'api/product/sub/$data',
    method: HttpUtils.GET,
  );
}

Future producSub(data) async {
  String jsonString = await _producSub(data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('productSub${data}', jsonString);
  final jsonResponse = json.decode(jsonString);
  classify model = classify.fromJson(jsonResponse);
  return model;
}

Future<String> _sendsms(data) async {
  return await await HttpUtils.request(
    'api/users/sendsms?tel=$data',
    method: HttpUtils.POST,
  );
}

Future sendsms(data) async {
  String jsonString = await _sendsms(data);
  final jsonResponse = json.decode(jsonString);
  sms model = sms.fromJson(jsonResponse);

  return model;
}

Future<String> _login(data) async {
  return await HttpUtils.request('api/users/login',
      method: HttpUtils.POST, data: data);
}

Future userLogin(data) async {
  String jsonString = await _login(data);
  if (jsonString != null) {
    final jsonResponse = json.decode(jsonString);
    login model = login.fromJson(jsonResponse);
    return model;
  } else {
    return jsonString;
  }
}


Future<String> _submit(data) async {
  return await HttpUtils.request('api/app-order/submit',
      method: HttpUtils.POST, data: data);
}

Future submitOrder(data) async {
  String jsonString = await _submit(data);
   if (jsonString.contains("500:::")) {
    return 500;
  }else{
     final jsonResponse = json.decode(jsonString);
  submit model = submit.fromJson(jsonResponse);
  return model;
  }
 
}

Future<String> _orderQuerys(data) async {
  return await HttpUtils.request(
    'api/order/querys/app/$data',
    method: HttpUtils.GET,
  );
}

Future orderQuerys(data) async {
  String jsonString = await _orderQuerys(data);
  final jsonResponse = json.decode(jsonString);
  order model = order.fromJson(jsonResponse);
  return model;
}

Future<String> _recommendSimilar(data) async {
  return await HttpUtils.request(
    'api/recommend/similar/$data',
    method: HttpUtils.GET,
  );
}

Future recommendSimilar(data) async {
  String jsonString = await _recommendSimilar(data);
  final jsonResponse = json.decode(jsonString);
  like model = like.fromJson(jsonResponse);
  return model;
}

Future<String> _favorite(data) async {
  return await HttpUtils.request('api/users/favorite',
      method: HttpUtils.POST, data: data);
}

Future favoriteGood(data) async {
  String jsonString = await _favorite(data);
  final jsonResponse = json.decode(jsonString);
  favorite model = favorite.fromJson(jsonResponse);
  return model;
}

Future<String> _nofavorite(data) async {
  return await HttpUtils.request(
    'api/users/favorite/${data}',
    method: HttpUtils.DELETE,
  );
}

Future nofavoriteGood(data) async {
  String jsonString = await _nofavorite(data);
  final jsonResponse = json.decode(jsonString);
  return null;
}

Future<String> _favorites() async {
  return await HttpUtils.request(
    'api/users/favorites',
    method: HttpUtils.GET,
  );
}

Future favoriteGoods() async {
  String jsonString = await _favorites();
  final jsonResponse = json.decode(jsonString);
  my_favorite model = my_favorite.fromJson(jsonResponse);
  return model;
}

Future<String> _userDetail() async {
  return await HttpUtils.request(
    'api/users',
    method: HttpUtils.GET,
  );
}

Future userDetail() async {
  String jsonString = await _userDetail();
  if (jsonString != null) {
    final jsonResponse = json.decode(jsonString);
    user model = user.fromJson(jsonResponse);
    return model;
  } else {
    return null;
  }
}

Future<String> _userChange(data) async {
  return await HttpUtils.request('api/users', method: HttpUtils.POST, data: data);
}

Future userChange(data) async {
  String jsonString = await _userChange(data);
  final jsonResponse = json.decode(jsonString);
  user model = user.fromJson(jsonResponse);
  return model;
}

Future<String> _orderPrice(data) async {
  return await HttpUtils.request('api/app-order/price',
      method: HttpUtils.POST, data: data);
}

Future orderPrice(data) async {
  String jsonString = await _orderPrice(data);
  if(jsonString==null){
      return 500;
  }else if (jsonString.contains("500:::")) {
    print(jsonString.split(":::")[0]);
    order_price_a model = order_price_a.fromJson({
      "statusCodeValue": jsonString.split(":::")[0],
      "body": jsonString.split(":::")[1]
    });
    return model;
  } else {
    final jsonResponse = json.decode(jsonString);
    order_price model = order_price.fromJson(jsonResponse);
    return model;
  }
}

Future<String> _upImg(data, id) async {
  return await HttpUtils.request('api/users/${id}/upload/image',
      method: "postImg", data: data);
}

Future upImg(data, id) async {
  String jsonString = await _upImg(data, id);
  final jsonResponse = json.decode(jsonString);
  user model = user.fromJson(jsonResponse);
  return model;
}



Future<String> _orderList(data,page) async {
  return await HttpUtils.request(
    'api/order/querys/page?status=${data}&terminal=app&size=10&page=${page}',
    method: HttpUtils.GET,
  );
}

Future getOrderList(data,page) async {
  String jsonString = await _orderList(data,page);
  final jsonResponse = json.decode(jsonString);
  order_list model = order_list.fromJson(jsonResponse);
  return model;
}



Future<String> _logistics(x,y) async {
  return await HttpUtils.request(
    'api/order/querys/${x}/${y}?terminal=app',
    method: HttpUtils.GET,
  );
}

Future getLogistics(x,y) async {
  String jsonString = await _logistics(x,y);
  final jsonResponse = json.decode(jsonString);
  logistics model = logistics.fromJson(jsonResponse);
  return model;
}


Future<String> _paymentOrder(data) async {
  return await HttpUtils.request('api/app-order/stripe/order/json',
      method: HttpUtils.POST, data: data);
}

Future paymentOrder(data) async {
  String jsonString = await _paymentOrder(data);
   if (jsonString.contains("500:::")) {
    return 500;
  }else{
     final jsonResponse = json.decode(jsonString);
    payment model = payment.fromJson(jsonResponse);
    return model;
  }
}



Future<String> _stripeCheckout(x,y) async {
  return await HttpUtils.request('api/order/stripe/paymentIntent/checkout'+'?stripeToken=${x}&orderId=${y}' ,
      method: HttpUtils.POST);
}

Future stripeCheckout(x,y) async {
  String jsonString = await _stripeCheckout(x,y);
 if (jsonString.contains("500:::")) {
    return 500;
  }else{
    final jsonResponse = json.decode(jsonString);
  submit_pay model = submit_pay.fromJson(jsonResponse);
  return model;
  } 
}





Future<String> _hotWord() async {
  return await HttpUtils.request('search/track/hotword',
      method: HttpUtils.GET);
}

Future hotWord() async {
  String jsonString = await _hotWord();
  final jsonResponse = json.decode(jsonString);
  hot_word model = hot_word.fromJson(jsonResponse);
  return model;
}



Future<String> _searchWord(data) async {
  return await HttpUtils.request('search/product/associate?keyword=${data}',
      method: HttpUtils.GET);
}

Future searchWord(data) async {
  String jsonString = await _searchWord(data);
  final jsonResponse = json.decode(jsonString);
  search_word model = search_word.fromJson(jsonResponse);
  return model;
}



Future<String> _searchList(data) async {
  return await HttpUtils.request('search/product/list?${data}',
      method: HttpUtils.GET);
}

Future searchList(data) async {
  String jsonString = await _searchList(data);
  final jsonResponse = json.decode(jsonString);
  search_list model = search_list.fromJson(jsonResponse);
  return model;
}



Future<String> _checkVersion(data,data1) async {
  return await HttpUtils.request('api/app/checkupdate?appname=${data}&version=${data1}',
      method: HttpUtils.GET);
}

Future checkVersion(data,data1) async {
  String jsonString = await _checkVersion(data,data1);
  final jsonResponse = json.decode(jsonString);
  version model = version.fromJson(jsonResponse);
  return model;
}



Future<String> _cancelOrder(data) async{
   return await HttpUtils.request('api/order/app-cancel',
      method: HttpUtils.POST,data:data);
}

Future cancelOrder(data) async{
  String jsonString = await _cancelOrder(data);
  if (jsonString.contains("500:::")) {
    return 500;
  }else{
    final jsonResponse = json.decode(jsonString);
    cancel_order model = cancel_order.fromJson(jsonResponse);
    return model;
  }
}



Future<String> _saleserviceDelivery(data) async{
  print(data);
   return await HttpUtils.request('api/saleservice/delivery/${data}',
      method: HttpUtils.GET);
}

Future saleserviceDelivery(data) async{
  String jsonString = await _saleserviceDelivery(data);
  final jsonResponse = json.decode(jsonString);
  saleservice_delivery model = saleservice_delivery.fromJson(jsonResponse);
  return model;
}





Future<String> _upImgSaleservice(data) async {
  return await HttpUtils.request('api/saleservice/upload',
      method: "postImg", data: data);
}

Future upImgSaleservice(data) async {
  String jsonString = await _upImgSaleservice(data);
  final jsonResponse = json.decode(jsonString);

  return jsonResponse["body"][0];
}



Future<String> _saleserviceSubmit(data) async {
  return await HttpUtils.request('api/saleservice/submit',
      method: HttpUtils.POST, data: data);
}

Future saleserviceSubmit(data) async {
  String jsonString = await _saleserviceSubmit(data);
  final jsonResponse = json.decode(jsonString);
  saleservice_detail model = saleservice_detail.fromJson(jsonResponse);
  return model;
}




Future<String> _productSku(data) async {
  return await HttpUtils.request('api//product/sku/${data}',
      method: HttpUtils.GET);
}

Future productSku(data) async {
  String jsonString = await _productSku(data);
  final jsonResponse = json.decode(jsonString);
   product_sku model = product_sku.fromJson(jsonResponse);
  return model;
}




Future<String> _saleservice(data) async {
  return await HttpUtils.request('api/saleservice/${data}',
      method: HttpUtils.GET);
}

Future saleservice(data) async {
  String jsonString = await _saleservice(data);
  final jsonResponse = json.decode(jsonString);
   saleservice_detail model = saleservice_detail.fromJson(jsonResponse);
   print(model);
  return model;
}



Future<String> _saleserviceList(data) async {
  return await HttpUtils.request('api/saleservice/page?size=10&page=${data}',
      method: HttpUtils.GET);
}

Future saleserviceList(data) async {
  String jsonString = await _saleserviceList(data);
  final jsonResponse = json.decode(jsonString);
  saleservice_list model = saleservice_list.fromJson(jsonResponse);
  return model;
}





Future<String> _saleserviceCancel(data) async {
  return await HttpUtils.request('api/saleservice/cancel',
      method: HttpUtils.DELETE,data:data);
}

Future saleserviceCancel(data) async {
  String jsonString = await _saleserviceCancel(data);
  final jsonResponse = json.decode(jsonString);
  print(jsonResponse);
}



Future<String> _saleserviceOrderList(data) async {
  return await HttpUtils.request('api/saleservice/list?orderCode=${data}',
      method: HttpUtils.GET);
}

Future saleserviceOrderList(data) async {
  String jsonString = await _saleserviceOrderList(data);
  final jsonResponse = json.decode(jsonString);
  saleservice_order_list model = saleservice_order_list.fromJson(jsonResponse);
  return model;
}



Future<String> _cartRecommend(data) async {
  return await HttpUtils.request('api/product/cart-recommend?${data}',
      method: HttpUtils.GET);
}

Future cartRecommend(data) async {
  String jsonString = await _cartRecommend(data);
  return jsonString;
}


