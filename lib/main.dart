import 'package:flutter/material.dart';
import 'routes/Routes.dart';
import 'package:provide/provide.dart';
import 'provide/cart.dart';
import 'provide/login.dart';
import 'provide/currentIndex.dart';
import 'provide/address.dart';
import 'provide/footmark.dart';
import 'provide/home.dart';
import 'provide/product.dart';
import 'provide/model.dart';
import 'provide/search.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



void main(){
  var cartProvide = CartProvide();
  var loginProvide = LoginProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var addressProvide = AddressProvide();
  var footmarkProvide = FootMarkProvide();
  var home = HomeProvide();
  var product = ProductProvide();
  var providers = Providers();
  var model = ModelProvide();
  var search = SearchHistoryProvide();
  providers..provide(Provider<CartProvide>.value(cartProvide));
  providers..provide(Provider<LoginProvide>.value(loginProvide));
  providers..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
  providers..provide(Provider<AddressProvide>.value(addressProvide));
  providers..provide(Provider<FootMarkProvide>.value(footmarkProvide));
  providers..provide(Provider<HomeProvide>.value(home));
  providers..provide(Provider<ProductProvide>.value(product));
  providers..provide(Provider<ModelProvide>.value(model));
  providers..provide(Provider<SearchHistoryProvide>.value(search));
  runApp(ProviderNode(child:MyApp(),providers: providers,));
} 
class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:true ,  //去掉debug图标
      // home:Tabs(),   
      initialRoute: '/home',     //初始化的时候加载的路由
      onGenerateRoute: onGenerateRoute,
       builder: EasyLoading.init(),
    );
  }
}
