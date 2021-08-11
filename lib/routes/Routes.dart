
import 'package:bale_shop/pages/my_page/order.dart';
import 'package:flutter/material.dart';

import 'package:bale_shop/pages/tabs.dart';
import 'package:bale_shop/pages/tabs/cat.dart';
import 'package:bale_shop/pages/product_page/ProductPage.dart';
import 'package:bale_shop/pages/product_page/ClassifyDetail.dart';
import 'package:bale_shop/pages/my_page/Word.dart';
import 'package:bale_shop/pages/my_page/privacyPolicy.dart';
import 'package:bale_shop/pages/my_page/serviceTerms.dart';
import 'package:bale_shop/pages/my_page/problem.dart';
import 'package:bale_shop/pages/my_page/footMark.dart';
import 'package:bale_shop/pages/my_page/track.dart';
import 'package:bale_shop/pages/my_page/refund.dart';
import 'package:bale_shop/pages/my_page/afterSales.dart';
import 'package:bale_shop/pages/login_page/login_page.dart';
import 'package:bale_shop/pages/cat_page/placeAnOrder.dart';
import 'package:bale_shop/pages/cat_page/address.dart';
import 'package:bale_shop/pages/cat_page/orderSuccess.dart';
import 'package:bale_shop/pages/cat_page/order_detail.dart';
import 'package:bale_shop/pages/my_page/setting.dart';
import 'package:bale_shop/pages/my_page/examples.dart';
import 'package:bale_shop/pages/my_page/afterSalesList.dart';
import 'package:bale_shop/pages/search/search.dart';
import 'package:bale_shop/pages/search/searchDetail.dart';
//配置路由
final routes={
      '/home':(context)=>Tabs(), 
      '/cat':(context,{arguments})=>CatPage(arguments:arguments), 
      '/detail':(context,{arguments})=>ProductPage(arguments:arguments), 
      '/classify':(context,{arguments})=>ClassifyDetail(arguments:arguments), 
      '/word':(context)=>Word(), 
      '/privacyPolicy':(context)=>PrivacyPolicy(), 
      '/serviceTerms':(context)=>ServiceTerms(), 
      '/problem':(context)=>Problem(), 
      '/track':(context)=>Track(),
      '/footMark':(context)=>FootMark(),
      '/order':(context,{arguments})=>Order(arguments:arguments),
      '/refund':(context)=>Refund(),
      '/login':(context,{arguments})=>LoginPage(arguments:arguments),
      '/placeAnOrder':(context)=>PlaceAnOrderPage(),
      '/address':(context)=>Address(),
      '/orderSuccess':(context,{arguments})=>OrderSuccessPage(arguments:arguments),
      '/orderDetail':(context,{arguments})=>OrderDetailPage(arguments:arguments),
      '/setting':(context)=>SettingPage(),
      '/search':(context)=>SearchPage(),
      '/searchDetail':(context,{arguments})=>SearchDetail(arguments:arguments),
      '/afterSales':(context,{arguments})=>AfterSales(arguments:arguments),
      '/examples':(context,{arguments})=>Examples(arguments:arguments),
      '/afterSalesList':(context,{arguments})=>AfterSalesList(arguments:arguments),
     
};

//固定写法
var onGenerateRoute=(RouteSettings settings) {
      // 统一处理
      final String name = settings.name; 
      final Function pageContentBuilder = routes[name];
      if (pageContentBuilder != null) {
        if (settings.arguments != null) {
          final Route route = MaterialPageRoute(
              builder: (context) =>pageContentBuilder(context, arguments: settings.arguments),
              settings:RouteSettings(name:name));
          return route;
        }else{
            final Route route = MaterialPageRoute(
              builder: (context) =>
                  pageContentBuilder(context),
                   settings:RouteSettings(name:name));
            return route;
        }
      }
};