import 'package:dio/dio.dart';
import 'package:bale_shop/apiModel/error.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
/*
 * 封装 restful 请求
 *
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */

class HttpUtils {
  /// global dio object
  static Dio dio;

  /// default options
  static const String API_PREFIX = 'https://api.baleshop.tw/';
  //static const String API_PREFIX = 'http://172.30.41.95:8080/';
  //static const String API_PREFIX = 'http://172.30.11.67:8080/';
  //static const String API_PREFIX = 'http://172.30.41.202:8080/';
  
  static const int CONNECT_TIMEOUT = 60000;
  static const int RECEIVE_TIMEOUT = 60000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static Future<dynamic> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';
    if (method == "postImg") {
      method = HttpUtils.POST;
    } else {
      data.forEach((key, value) {
        if (url.indexOf(key) != -1) {
          url = url.replaceAll(':$key', value.toString());
        }
      });
    }

    /// restful 请求处理

    String token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    Dio dio = createInstance(token);



    /// token过期时间28天
    if(prefs.getString("tokenTime")!=null){
      var d1 = DateTime.parse(prefs.getString("tokenTime"));
      var d2 = new DateTime.now();
      var difference = d1.difference(d2);
      if(difference.inDays>28){
          prefs.remove('phone');
          prefs.remove('scopeId');
          prefs.remove('tel');
          prefs.remove('token');
          prefs.remove('photo');
          prefs.remove('nickname');
      }
    }

    /// 打印请求相关信息：请求地址、请求方式、请求参数
    print('请求地址：【' + dio.options.baseUrl + url + '】');
   // print('请求参数：' + data.toString());

    var result;

    try {
      Response response = await dio.request(url,
          data: data, options: new Options(method: method));
      result = response.data;
      /// 打印响应相关信息
      print('响应数据成功！');
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('响应数据失败！');
      try{
        final jsonResponse = json.decode(e.response.data);
        error model = error.fromJson(jsonResponse);
        // print('请求出错：' + e.toString());
        // print(model.body.path);
        if ( (model.body.path == "/app-order/price" || model.body.path == "/order/stripe/paymentIntent/checkout")  && model.body.status == 500) {
          result = "500:::${model.body.message!=null?model.body.message:'111111'}";
          if(model.body.path == "/order/stripe/paymentIntent/checkout"){
             EasyLoading.showError(model.body.message);
          }
        } else {
          result = "500:::";
          EasyLoading.showError(model.body.message);
        }
      } catch (e) {
        return null;
      }
      
    }
    return result;
  }

  /// 创建 dio 实例对象
  static Dio createInstance(token) {
    print(token);
    if (dio == null || token != "") {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions option = new BaseOptions(
          baseUrl: API_PREFIX,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          headers: {
            "user-agent": "dio",
            "api": "1.0.0",
            "requestHost": 'www.91up.com.tw',
            "userTerminal": "app",
            "Authorization": token != "" ? "${token}" : ""
          },
          
          //contentType: ContentType.JSON,
          // Transform the response data to a String encoded with UTF8.
          // The default value is [ResponseType.JSON].
          responseType: ResponseType.plain);
      dio = new Dio(option);
    }

    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }
}
