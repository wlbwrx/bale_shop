import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:bale_shop/api/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bale_shop/pages/my_page/refund.dart';
import 'package:bale_shop/pages/product_page/productType.dart';
import 'package:bale_shop/widgets/goods/OnsaleTimer.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/currentIndex.dart';
import 'package:bale_shop/provide/footmark.dart';
import 'package:bale_shop/widgets/cart/toast.dart';
import 'package:bale_shop/provide/login.dart';
import 'package:share/share.dart';
import 'package:bale_shop/widgets/goods/goodsMouldFour.dart';
import 'package:badges/badges.dart';
import 'package:bale_shop/widgets/loadingDialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key, this.arguments}) : super(key: key);
  final arguments;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List imgList = [];
  List data = [];
  List tagList = [];
  List likeList = [];
  List detailImgList = [];
  List recommendProducts = [];
  String parameter = "";
  String detail = "";
  double isMax = 0;
  double isMin = 0;
  Map arguments;
  bool isfavorite = false;
  bool isLimitProduct = false;
  ScrollController _controller = new ScrollController();
  static final facebookAppEvents = FacebookAppEvents();
  void _fb() async {
    String url = "https://m.facebook.com/messages/thread/963546037190008";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('不能访问');
    }
  }

  void collect() {
    Navigator.of(context).pushNamed("/login");
  }

  void initState() {
    arguments = widget.arguments;
    super.initState();
    facebookAppEvents.logEvent(name: "fb_mobile_content_view", parameters: {
      "fb_content_type": '详情页',
      "fb_content_id": '${arguments["id"]}'
    });
    producDetail(arguments["id"]).then((val) {
      var body = val.body;
      if (body.product.status != 10) {
        Toast.toast(context,
            msg: "商品未上架,不能購買,帶妳探索更多好物...", position: ToastPostion.bottom);
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      }
      setState(() {
        isfavorite = body.isfavorite != null && body.isfavorite != ""? body.isfavorite: false;
        isLimitProduct = body.isLimitProduct != null && body.isLimitProduct != ""? body.isLimitProduct: false;
        for (var i = 0; i < body.product.productCarouselImages.length; i++) {
          imgList.add("https:" + body.product.productCarouselImages[i]);
        }
        for (var i = 0; i < body.aggregateModules.length; i++) {
          tagList.add(body.aggregateModules[i]);
        }
        if (body.similarProducts != null) {
          for (var i = 0; i < body.similarProducts.length; i++) {
            likeList.add(body.similarProducts[i]);
          }
        }

        List recommendProducts1 = [];
        List recommendProducts2 = [];
        if (body.recommendProducts != null &&
            body.recommendProducts.length > 0) {
          for (var i = 0; i < body.recommendProducts.length; i++) {
            if (i < 3) {
              recommendProducts1.add(body.recommendProducts[i]);
            } else {
              recommendProducts2.add(body.recommendProducts[i]);
            }
          }
          recommendProducts.add(recommendProducts1);
          if (recommendProducts2.length > 0) {
            recommendProducts.add(recommendProducts2);
          }
        }
        bool hasDepletion = false;
        for (var i = 0; i < body.product.productSkus.length; i++) {
          if (body.product.productSkus[i].appPrice == body.product.minPrice) {
            isMin = body.product.productSkus[i].appPrice;
            isMax = body.product.productSkus[i].depletionPrice;
          }

          if (body.product.productSkus[i].depletionPrice != null &&
              body.product.productSkus[i].depletionPrice != 0) {
            hasDepletion = true;
          }
        }

        parameter += body.productDetail.productParams;
        detail = body.productDetail.productDetails.replaceAll("//", "https://");
        imgText(body.productDetail.productDetails);
        data.add(body.product);

        bool hasDepletionRun = false;

        DateTime time01 = DateTime.now();
        DateTime time02 = body.product.depletionEndTime != null
            ? DateTime.parse(body.product.depletionEndTime)
            : DateTime.now();
        int time =
            (time02.millisecondsSinceEpoch - time01.millisecondsSinceEpoch);
        if (time > 0) {
          hasDepletionRun = true;
        }
      });

      var today = DateTime.now();
      Provide.value<FootMarkProvide>(context).save(
          body.product.id,
          "${today.year}/${today.month}/${today.day}",
          body.product.productImageUrl,
          body.product.maxPrice,
          body.product.originalPrice);
    });
  }

  imgText(a) {
    String text = a;
    for (var i = 0; i < a.split("//").length; i++) {
      int x = text.indexOf("//");
      int c = text.indexOf("png");
      int v = text.indexOf("jpg");
      int y = 0;
      if (c > 0 || v > 0) {
        if (c > 0 && v > 0) {
          if (c < v) {
            y = c;
          } else {
            y = v;
          }
        } else if (c > 0 && v < 0) {
          y = c;
        } else if (v > 0 && c < 0) {
          y = v;
        }
      } else {
        return imgList;
      }

      String z = "https:" + text.substring(x, y + 3);

      setState(() {
        detailImgList.add(z);
      });
      if (i < a.split("//").length - 1) {
        text = text.substring(y + 3);
      }
    }
    return imgList;
  }

  Widget renderImgList(data) {
    List<Widget> img = [];
    for (var i = 0; i < data.length; i++) {
      img.add(
        CachedNetworkImage(
          imageUrl: data[i],
          placeholder: (BuildContext context, String url) => Container(
            height: 200,
          ),
        ),
        //     CachedNetworkImage(
        //     imageUrl:data[i],
        //     placeholder: (context, url) => CircularProgressIndicator(),
        //     errorWidget: (context, url, error) => Icon(Icons.error),
        //  ),
        // CachedNetworkImage(
        //   fit: BoxFit.cover,
        //   placeholder: (context, url) => Image.asset(
        //     'assets/icons/placeholder.png',
        //     fit: BoxFit.cover,
        //   ),
        //   imageUrl: data[i],
        //   errorWidget: (context, url, error) => Image.asset(
        //     'assets/icons/placeholder.png',
        //     fit: BoxFit.cover,
        //   ),
        // ),
      );
    }
    return Container(
        child: SizedBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: img)));
  }

  Widget renderTag() {
    List<Widget> tag = [];
    for (var i = 0; i < tagList.length; i++) {
      tag.add(
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/classify", arguments: {
              "data": tagList[i].id,
              "parentId": tagList[i].parentId
            });
          },
          child: Container(
              padding: EdgeInsets.fromLTRB(8, 3, 5, 3),
              margin: EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: new Border.all(width: 1, color: Color(0xFFED1B2E)),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    '${tagList[i].name} ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFED1B2E),
                    ),
                  ),
                  Image.asset(
                    'assets/icons/icon-right-red.png',
                    width: 8,
                    height: 8,
                    color: Colors.red,
                  )
                ],
              )),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0, 11.5, 10, 12),
      alignment: Alignment.center,
      child: Row(children: tag),
    );
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _width = (size.width - 240) / 3;
    final _height = size.height;
    //final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    var today = DateTime.now(); // 2019-11-08 02:54:53.218443

    var fiftyDaysFromNow = today.add(new Duration(days: 10));
    var nowText =
        "${fiftyDaysFromNow.year}.${fiftyDaysFromNow.month}.${fiftyDaysFromNow.day}";
    var fiftyDaysFromEnd = today.add(new Duration(days: 15));
    var endText =
        "${fiftyDaysFromEnd.year}.${fiftyDaysFromEnd.month}.${fiftyDaysFromEnd.day}";
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
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
              )),
          elevation: 0.5,
          backgroundColor: Colors.white,
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  Provide.value<CurrentIndexProvide>(context).changeIndex(0);
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: Image.asset(
                    'assets/icons/icon-home-white.png',
                    width: 20,
                    height: 20,
                    color: Colors.black,
                  ),
                )),
            GestureDetector(
              onTap: () {
                Share.share(
                    'https://www.91up.com.tw/product/index.html?id=${data[0].id}');
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 17, 0),
                child: Image.asset(
                  'assets/icons/icon-share.png',
                  width: 20,
                  height: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: Provide<CurrentIndexProvide>(
            builder: (context, child, childCatgory) {
          int catNum = Provide.value<CurrentIndexProvide>(context).catNum;
          return Scrollbar(
              child: Stack(children: <Widget>[
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              controller: _controller,
              children: <Widget>[
                Container(
                  color: Color(0xFFF4F4F4),
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: imgList.length > 0
                            ? Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Image.asset(
                                      'assets/icons/placeholder.png',
                                      fit: BoxFit.cover,
                                    ),
                                    imageUrl: imgList[index],
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/icons/placeholder.png',
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                itemCount: imgList.length,
                                pagination: new SwiperPagination(
                                    builder: DotSwiperPaginationBuilder(
                                  color: Color(0x40000000),
                                  activeColor: Color(0xFFED1B2E),
                                )),
                                autoplay: true)
                            : Text(''),
                      )),
                      //倒计时
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        height: 55,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [Color(0xFAF23806), Color(0xFFFA991A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //         data.length > 0
                                //             ? Container(
                                // padding: EdgeInsets.fromLTRB(0, 3, 0, 0),child:Text(
                                //                 "限時出清價",
                                //                 style: TextStyle(
                                //                   fontSize: 12,
                                //                   color: Color(0xFFFFFFFF),
                                //                 ),
                                //               ))
                                //             : Text(''),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Text(
                                        '\$',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text(
                                      data.length > 0
                                          ? '${doubleText(isMin)}'
                                          : '',
                                      style: TextStyle(
                                          fontSize: 28,
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Text(
                                        "起",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                      child: Text(
                                        data.length > 0
                                            ? '\$${doubleText(data[0].originalPrice)}'
                                            : '',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            data.length > 0
                                ? Container(
                                    padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 3),
                                            child: Text(
                                              "🔥爆款熱銷${numString(data[0].id)}件",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFF56211),
                                              ),
                                            )),
                                        Countdown(
                                            end_time: data[0]
                                                        .depletionEndTime !=
                                                    null
                                                ? '${data[0].depletionEndTime}'
                                                : "2020-12-25 06:00:00")
                                      ],
                                    ))
                                : Container(),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: <Widget>[
                            //     Container(
                            //       padding:
                            //           EdgeInsets.fromLTRB(0, 4, 0, 8),
                            //       child: Text(
                            //         '距離結束僅剩:',
                            //         style: TextStyle(
                            //           fontSize: 12,
                            //           color: Color(0xFFFFFFFF),
                            //         ),
                            //       ),
                            //     ),
                            //     lock
                            //         ?
                            //         : Container()
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      //标题
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                    data.length > 0&&isLimitProduct?  Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.fromLTRB( 0, 12, 0, 0),
                                            child: Image.asset(
                                              "assets/icons/icon-heed.png",
                                              width: 12,
                                              height: 12,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                4, 12, 0, 0),
                                            child: Text(
                                              '限量出清商品，不可退換',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFFED1B2E),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ):Container(),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 12, 12, 0),
                                        child: Text(
                                          data.length > 0
                                              ? '${data[0].title}'
                                              : '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF222222),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 6, 0, 11.5),
                                        child: Text(
                                          data.length > 0
                                              ? '${data[0].description}'
                                              : '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF777777),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 27,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(bottom: 0, top: data.length > 0&&isLimitProduct? 42:12),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF4F4F4),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(0),
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(0),
                                    ),
                                  ),
                                  child: Text(
                                    data.length > 0 ? '品號：${data[0].id}' : '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF777777),
                                    ),
                                  ),
                                )
                              ],
                            )),
                            MySeparator(height: 1, color: Color(0xFFEDEDED)),
                            renderTag()
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          padding: EdgeInsets.fromLTRB(12, 14, 12, 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                           
                                          ),
                                          child: Image.asset(
                                            "assets/icons/detail3.png",
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 6),
                                          child: Text('用戶下單',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF777777))),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 1,
                                          width: _width,
                                          decoration: BoxDecoration(
                                            border: new Border.all(
                                                width: 1,
                                                color: Color(0xFFBCBCBC)),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: _width,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                         
                                          child: Image.asset(
                                            "assets/icons/detail1.png",
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 6),
                                          child: Text('工廠備貨',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF777777))),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 1,
                                          width: _width,
                                          decoration: BoxDecoration(
                                            border: new Border.all(
                                                width: 1,
                                                color: Color(0xFFBCBCBC)),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: _width,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                         
                                          child: Image.asset(
                                            "assets/icons/detail2.png",
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(top: 6),
                                            child: Text('國際運輸',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF777777)))),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 1,
                                          width: _width,
                                          decoration: BoxDecoration(
                                            border: new Border.all(
                                                width: 1,
                                                color: Color(0xFFBCBCBC)),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: _width,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                         
                                          child: Image.asset(
                                            "assets/icons/detail4.png",
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(top: 6),
                                            child: Text('直達用戶',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF777777)))),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 17.5, 0, 0),
                                  child: MySeparator(
                                      height: 1, color: Color(0xFFEDEDED)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 17.5, 10, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('🚚 香港發出，滿\$699免運費'),
                                            Text(
                                                '     預計到達時間${nowText}~${endText}'),
                                          ],
                                        ))
                                  ],
                                )
                              ],
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          padding: EdgeInsets.fromLTRB(12, 15, 12, 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                                    child: Text(
                                      '優惠方案說明',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                      ),
                                    )),
                                Table(
                                  border: TableBorder.all(
                                    color: Color(0xFFEDEDED),
                                  ),
                                  columnWidths: <int, TableColumnWidth>{
                                    0: FixedColumnWidth(80),
                                    //1:FixedColumnWidth(20),
                                  },
                                  children: [
                                    TableRow(children: [
                                      new TableCell(
                                        child: Container(
                                          height: 60,
                                          color: Color(0xFFFBFBFB),
                                          alignment: Alignment.center,
                                          child: new Text('方案1'),
                                        ),
                                      ),
                                      new TableCell(
                                        child: Container(
                                            height: 60,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  12, 12, 5, 0),
                                                          child: Text(
                                                            "包裹10天內送達",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xFF222222)),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  12, 0, 5, 0),
                                                          child: Text(
                                                            data.length > 0
                                                                ? "單價\$${doubleText(isMax)} (${((isMax / data[0].originalPrice) * 10).toStringAsFixed(1)}折)"
                                                                : '',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xFFED1B2E)),
                                                          ),
                                                        ),
                                                      ])),
                                                  GestureDetector(
                                                      onTap: () {
                                                        //出清
                                                        if (data.length > 0) {
                                                          if (data[0].status ==
                                                              10) {
                                                            showModalBottomSheet(
                                                              context: context,
                                                              isScrollControlled:
                                                                  true,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                      side: BorderSide
                                                                          .none,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                      )),
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return ProductType(
                                                                    data: data,
                                                                    type: '0',
                                                                    isLimitProduct:isLimitProduct
                                                                    );
                                                              },
                                                            );
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width: 56,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 0, 10, 0),
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  14, 5, 14, 5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFED1B2E),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                          ),
                                                          child: Text(
                                                            "購買",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          )))
                                                ])),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      new TableCell(
                                          child: Stack(children: <Widget>[
                                        Container(
                                          height: 60,
                                          color: Color(0xFFFBFBFB),
                                          alignment: Alignment.center,
                                          child: new Text('方案2'),
                                        ),
                                        Positioned(
                                            child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    1, 1, 1, 1),
                                                padding: EdgeInsets.fromLTRB(
                                                    7, 0, 7, 1),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(13)),
                                                  border: new Border.all(
                                                      width: 0.5,
                                                      color: Color(0xFFED1B2E)),
                                                ),
                                                height: 20,
                                                child: Text(
                                                  "🔥推薦",
                                                  style: TextStyle(
                                                      color: Color(0xFFED1B2E),
                                                      fontSize: 11),
                                                )))
                                      ])),
                                      new TableCell(
                                        child: Container(
                                            height: 60,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  12, 12, 5, 0),
                                                          child: Text(
                                                            "包裹20天內送達",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xFF222222)),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  12, 0, 5, 0),
                                                          child: Text(
                                                            data.length > 0
                                                                ? "單價\$${doubleText(isMin)} (${((isMin / data[0].originalPrice) * 10).toStringAsFixed(1)}折)"
                                                                : '',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xFFED1B2E)),
                                                          ),
                                                        ),
                                                      ])),
                                                  GestureDetector(
                                                      onTap: () {
                                                        //出清
                                                        if (data.length > 0) {
                                                          if (data[0].status ==
                                                              10) {
                                                            showModalBottomSheet(
                                                              context: context,
                                                              isScrollControlled:
                                                                  true,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                      side: BorderSide
                                                                          .none,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                      )),
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return ProductType(
                                                                    data: data,
                                                                    type: '1',
                                                                    isLimitProduct:isLimitProduct
                                                                    );
                                                              },
                                                            );
                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                          width: 56,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 0, 10, 0),
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  14, 5, 14, 5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFED1B2E),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                          ),
                                                          child: Text(
                                                            "購買",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          )))
                                                ])),
                                      ),
                                    ]),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          padding: EdgeInsets.fromLTRB(12, 15, 12, 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                                    child: Text(
                                      '運費說明',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                      ),
                                    )),
                                Table(
                                  border: TableBorder.all(
                                    color: Color(0xFFEDEDED),
                                  ),
                                  columnWidths: <int, TableColumnWidth>{
                                    0: FixedColumnWidth(240),
                                    //1:FixedColumnWidth(20),
                                  },
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFBFBFB),
                                        ),
                                        children: [
                                          new TableCell(
                                              child: Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: new Text(
                                              '訂單總額',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                          new TableCell(
                                              child: Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: new Text(
                                              '運費',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )),
                                        ]),
                                    TableRow(children: [
                                      new TableCell(
                                        child: new Center(
                                            child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 13, 0, 13),
                                          child: new Text('訂單總額 < \$699'),
                                        )),
                                      ),
                                      new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: new Text('\$60'),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: new Text('訂單總額 ≥ \$699'),
                                        ),
                                      ),
                                      new TableCell(
                                        child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: new Text('\$0'),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    child: Text(
                                      '* 全站\$代表的是新台幣NT\$',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF777777)),
                                    )),
                              ],
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  )),
                              builder: (BuildContext context) {
                                return Container(
                                  height: _height * 0.7,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        child:
                                            Container(child: Refund(type: 1)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              padding: EdgeInsets.fromLTRB(12, 16, 0, 17),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Container(
                                                width: 4,
                                                height: 4,
                                                margin: EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: Color(0xFFED1B2E)),
                                                child: Text('·'),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '全站滿\$699免運',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xFF777777)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 5,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                width: 4,
                                                height: 4,
                                                margin: EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: Color(0xFFED1B2E)),
                                                child: Text('·'),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '支持7天無憂退換貨+運費補償',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xFF777777)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 12, 0),
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          "assets/icons/icon-back-right.png",
                                          width: 6,
                                          height: 10,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                      recommendProducts.length > 0
                          ? Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 0, 0, 12),
                                        child: Text(
                                          '買了該商品的人還買了',
                                          style: TextStyle(
                                            fontSize: 16,
                                             fontWeight: FontWeight.w500
                                          ),
                                        )),
                                    recommendProducts.length > 0
                                        ? Container(
                                            child: AspectRatio(
                                            aspectRatio: 2.3 / 1,
                                            child: Swiper(
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return new Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            6, 0, 15, 12),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushNamed(
                                                                            "/detail",
                                                                            arguments: {
                                                                          "id":
                                                                              recommendProducts[index][0].id
                                                                        });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .fromLTRB(
                                                                            9,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: recommendProducts[index].length >
                                                                            0
                                                                        ? Column(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                padding: EdgeInsets.only(bottom: 6),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                                  child: CachedNetworkImage(
                                                                                    fit: BoxFit.cover,
                                                                                    placeholder: (context, url) => Image.asset(
                                                                                      'assets/icons/placeholder.png',
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                    imageUrl: recommendProducts[index][0].productImageUrl != null ? "https:" + recommendProducts[index][0].productImageUrl : 'assets/icons/placeholder.png',
                                                                                    errorWidget: (context, url, error) => Image.asset(
                                                                                      'assets/icons/placeholder.png',
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                                                                    child: Text(
                                                                                      '\$',
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                        color: Color(0xFFED1B2E),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '${doubleText(recommendProducts[index][0].minPrice)}',
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Color(0xFFED1B2E),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.fromLTRB(6, 3, 0, 0),
                                                                                    child: Text(
                                                                                      '\$${doubleText(recommendProducts[index][0].originalPrice)}',
                                                                                      style: TextStyle(fontSize: 12, color: Color(0xFF777777), decoration: TextDecoration.lineThrough),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Container(),
                                                                  )),
                                                          flex: 1,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushNamed(
                                                                            "/detail",
                                                                            arguments: {
                                                                          "id":
                                                                              recommendProducts[index][1].id
                                                                        });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .fromLTRB(
                                                                            9,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: recommendProducts[index].length >
                                                                            1
                                                                        ? Column(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                padding: EdgeInsets.only(bottom: 6),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                                  child: CachedNetworkImage(
                                                                                    fit: BoxFit.cover,
                                                                                    placeholder: (context, url) => Image.asset(
                                                                                      'assets/icons/placeholder.png',
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                    imageUrl: "https:" + recommendProducts[index][1].productImageUrl,
                                                                                    errorWidget: (context, url, error) => Image.asset(
                                                                                      'assets/icons/placeholder.png',
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                                                                    child: Text(
                                                                                      '\$',
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                        color: Color(0xFFED1B2E),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '${doubleText(recommendProducts[index][1].minPrice)}',
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Color(0xFFED1B2E),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.fromLTRB(6, 3, 0, 0),
                                                                                    child: Text(
                                                                                      '\$${doubleText(recommendProducts[index][1].originalPrice)}',
                                                                                      style: TextStyle(fontSize: 12, color: Color(0xFF777777), decoration: TextDecoration.lineThrough),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Container(),
                                                                  )),
                                                          flex: 1,
                                                        ),
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushNamed(
                                                                            "/detail",
                                                                            arguments: {
                                                                          "id":
                                                                              recommendProducts[index][2].id
                                                                        });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .fromLTRB(
                                                                            9,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: recommendProducts[index].length >
                                                                            2
                                                                        ? Column(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                padding: EdgeInsets.only(bottom: 6),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                                  child: CachedNetworkImage(
                                                                                    fit: BoxFit.cover,
                                                                                    placeholder: (context, url) => Image.asset(
                                                                                      'assets/icons/placeholder.png',
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                    imageUrl: "https:" + recommendProducts[index][2].productImageUrl,
                                                                                    errorWidget: (context, url, error) => Image.asset(
                                                                                      'assets/icons/placeholder.png',
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                                                                    child: Text(
                                                                                      '\$',
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                        color: Color(0xFFED1B2E),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    '${doubleText(recommendProducts[index][2].minPrice)}',
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Color(0xFFED1B2E),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.fromLTRB(6, 3, 0, 0),
                                                                                    child: Text(
                                                                                      '\$${doubleText(recommendProducts[index][2].originalPrice)}',
                                                                                      style: TextStyle(fontSize: 12, color: Color(0xFF777777), decoration: TextDecoration.lineThrough),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Container(),
                                                                  )),
                                                          flex: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                itemCount:
                                                    recommendProducts.length,
                                                pagination:
                                                    new SwiperPagination(
                                                        margin: EdgeInsets.only(
                                                            bottom: 4),
                                                        builder:
                                                            DotSwiperPaginationBuilder(
                                                          color:
                                                              Color(0x40000000),
                                                          activeColor:
                                                              Color(0xFFED1B2E),
                                                        )),
                                                autoplay: true),
                                          ))
                                        : Text(''),
                                  ],
                                ),
                              ))
                          : Container(),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          padding: EdgeInsets.fromLTRB(15, 15, 0, 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      '商品參數',
                                      style: TextStyle(
                                        fontSize: 16,
                                         fontWeight: FontWeight.w500
                                      ),
                                    )),
                                SingleChildScrollView(
                                    child: Html(
                                        data: parameter,
                                        //Optional parameters:
                                        backgroundColor: Colors.white70,
                                        defaultTextStyle:
                                            TextStyle(fontFamily: 'serif'),
                                        linkStyle: const TextStyle(
                                          color: Colors.redAccent,
                                        )))
                              ],
                            ),
                          )),
                      renderImgList(detailImgList),
                      likeList.length > 0
                          ? Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(12, 12, 0, 12),
                              child: Text(
                                "相似商品推薦",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ))
                          : Container(),
                      likeList.length > 0
                          ? Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: GridView.builder(
                                  itemCount: likeList.length,
                                  shrinkWrap: true,
                                  physics: new NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2, //Grid按两列显示
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                          childAspectRatio:
                                              sizeHeight2(_height)),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed("/detail", arguments: {
                                            "id": likeList[index].id,
                                            "isIndex": 2
                                          });
                                        },
                                        child: GoodsMouldFour(
                                            data: [likeList[index]]));
                                  }),
                            )
                          : Container(),
                      Container(
                          //height: 10+ bottomPadding,
                          padding: EdgeInsets.fromLTRB(
                              0,
                              bottomPadding == 0 ? 20 : 0,
                              0,
                              bottomPadding == 0 ? 20 : 6 + bottomPadding),
                          child: Text("-- 我是有底線的 --",
                              style: TextStyle(color: Color(0xFFBCBCBC))))
                    ],
                  ),
                )
              ],
            ),
            // Container(
            //   height: 100,
            //   padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //           child: Row(
            //         children: <Widget>[
            //           GestureDetector(
            //             onTap: () {
            //               Navigator.of(context).pop();
            //             },
            //             child: Container(
            //                 height: 40,
            //                 width: 40,
            //                 alignment: Alignment.center,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(20),
            //                   color: Color(0x55000000),
            //                 ),
            //                 child: Icon(
            //                   Icons.keyboard_arrow_left,
            //                   color: Colors.white,
            //                 )),
            //           )
            //         ],
            //       )),
            //     ],
            //   ),
            // ),
            Positioned(
              bottom: bottomPadding + 57.5,
              right: 70,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      height: 44,
                      width: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 1.0), //阴影xy轴偏移量
                                blurRadius: 2, //阴影模糊程度
                                spreadRadius: 1.0 //阴影扩散程度
                                )
                          ]),
                      child: Image.asset(
                        "assets/icons/icon-back-dark.png",
                        width: 16,
                        height: 34,
                      )),
                ),
              ),
            ),
            Positioned(
              bottom: bottomPadding + 57.5,
              right: 10,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    _controller.animateTo(.0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.ease);
                  },
                  child: Container(
                      height: 44,
                      width: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 1.0), //阴影xy轴偏移量
                                blurRadius: 2, //阴影模糊程度
                                spreadRadius: 1.0 //阴影扩散程度
                                )
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 7),
                            child: Image.asset(
                              "assets/icons/icon-go-top.png",
                              width: 34,
                              height: 16,
                            ),
                          ),
                          Text('回頂部', style: TextStyle(fontSize: 9))
                        ],
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50.5 + bottomPadding,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                          width: 0.5, color: Color(0xFFDFDEDB)), //有边框
                    )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: GestureDetector(
                                      onTap: () {
                                        _fb();
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/customer-service.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                          Text('客服',
                                              style: TextStyle(fontSize: 10,color:Color(0xFF777777) ))
                                        ],
                                      )),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: GestureDetector(
                                    onTap: () async {
                                      if (data[0].status == 10) {
                                        String tel =
                                            Provide.value<LoginProvide>(context)
                                                .dataTel;
                                        if (tel != "" && tel != null) {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return new LoadingDialog(
                                                  text: "處理中…",
                                                );
                                              });
                                          if (isfavorite) {
                                            nofavoriteGood(data[0].id)
                                                .then((val) {
                                              Navigator.pop(context);
                                              Toast.toast(context,
                                                  msg: "已取消收藏",
                                                  position:
                                                      ToastPostion.bottom);

                                              setState(() {
                                                isfavorite = false;
                                              });
                                            });
                                          } else {
                                            favoriteGood(
                                                    {"productId": data[0].id})
                                                .then((val) {
                                              facebookAppEvents.logEvent(
                                                name:
                                                    'fb_mobile_add_to_wishlist',
                                                parameters: {
                                                  'fb_content_id': data[0].id,
                                                  'fb_content_type': 'product',
                                                  'fb_currency': 'TWD',
                                                  '_valueToSum':
                                                      data[0].minPrice
                                                },
                                              );
                                              Navigator.pop(context);
                                              Toast.toast(context,
                                                  msg: "收藏成功",
                                                  position:
                                                      ToastPostion.bottom);

                                              setState(() {
                                                isfavorite = true;
                                              });
                                            });
                                          }
                                        } else {
                                          collect();
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            isfavorite
                                                ? 'assets/icons/detail-favorite-c.png'
                                                : 'assets/icons/detail-favorite.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                          Text('收藏',
                                              style: TextStyle(fontSize: 10,color:Color(0xFF777777))),
                                        ],
                                      ),
                                    )),
                                flex: 1,
                              ),
                              Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed("/cat",arguments: {"type": 1});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Column(
                                        children: <Widget>[
                                          catNum > 0
                                              ? Badge(
                                                  badgeColor: Color(0xFFED1B2E),
                                                  borderRadius: catNum < 10
                                                      ? BorderRadius.circular(
                                                          10)
                                                      : BorderRadius.circular(
                                                          20),
                                                  elevation: 0,
                                                  padding: EdgeInsets.fromLTRB(
                                                      4,
                                                      catNum < 10 ? 2 : 4,
                                                      4,
                                                      catNum < 10 ? 2 : 4),
                                                  shape: catNum < 10
                                                      ? BadgeShape.circle
                                                      : BadgeShape.square,
                                                  position:
                                                      BadgePosition.topEnd(
                                                          top: -8,
                                                          end: catNum < 10
                                                              ? -10
                                                              : -15),
                                                  badgeContent: Text(
                                                    '${catNum}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                        fontSize: 10),
                                                  ),
                                                  child: Image.asset(
                                                    'assets/icons/detail-cart.png',
                                                    width: 20,
                                                    height: 20,
                                                  ))
                                              : Image.asset(
                                                  'assets/icons/detail-cart.png',
                                                  width: 20,
                                                  height: 20,
                                                ),
                                          Text('購物車',
                                              style: TextStyle(fontSize: 10,color:Color(0xFF777777)))
                                        ],
                                      ),
                                    )),
                                flex: 1,
                              ),
                            ],
                          )),
                    ),
                    GestureDetector(
                        onTap: () {
                          if (data.length > 0) {
                            if (data[0].status == 10) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    )),
                                builder: (BuildContext context) {
                                  return ProductType(data: data, type: '0',isLimitProduct:isLimitProduct);
                                },
                              );
                            }
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 108,
                            height: 50,
                            padding: EdgeInsets.fromLTRB(0, 6, 0, 2),
                            decoration: BoxDecoration(
                              color: Color(0xFFF47682),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  data.length > 0
                                      ? '\$${doubleText(isMax)}'
                                      : '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Text(
                                  '10天運達',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ))),
                    GestureDetector(
                      onTap: () {
                        //出清
                        if (data.length > 0) {
                          if (data[0].status == 10) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  )),
                              builder: (BuildContext context) {
                                return ProductType(data: data, type: '1',isLimitProduct:isLimitProduct);
                              },
                            );
                          }
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 108,
                          height: 50,
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 2),
                          decoration: BoxDecoration(color: Color(0xFFED1B2E)),
                          child: Column(
                            children: <Widget>[
                              Text(
                                data.length > 0 ? '\$${doubleText(isMin)}' : '',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                '20天運達',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ]));
        }));
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
