import 'package:flutter/material.dart';
import 'package:bale_shop/widgets/cart/cartCount.dart';
import 'package:provide/provide.dart';
import 'package:bale_shop/provide/cart.dart';
import 'package:bale_shop/provide/currentIndex.dart';
import 'package:bale_shop/widgets/cart/toast.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/utils/tool.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'dart:convert';
class ProductType extends StatefulWidget {
  ProductType({Key key, this.data, this.type, this.isLimitProduct,this.callBack}) : super(key: key);
  final List data;
  String type;
  bool isLimitProduct;
  final callBack;
  @override
  _ProductTypeState createState() => _ProductTypeState();
}

class _ProductTypeState extends State<ProductType> {
  Map product;
  List data;
  String type;
  String price;
  double checkPrice;
  String checkImg = '';
  List checkSku = [];
  int checkSkuIndex = -1;
  String checkSkuCode = '';
  String checkName = '';
  String indexName = '';
  int checkIndex = -1;
  int selectIndex = 0;
  List checkList = [];
  int skuAttrImage = -1;
  int skuType = 0;
  int num = 1;
  bool lock = false;

  bool isInventory = false;
  bool isLimitProduct = false;
  List<String> skuList = [];

  List disableList = [];
  
  static final facebookAppEvents = FacebookAppEvents();
  @override
  void initState() {
    data = widget.data;
    type = widget.type;
    isLimitProduct = widget.isLimitProduct;
    price = '${doubleText(data[0].minPrice)}~${doubleText(data[0].maxPrice)}';
    super.initState();
    List codeList = [];
    List noInventorySkuList = [];
    
    double minPrice = 99999;
    var minIndex = 0;
    
    for(var x=0;x<data[0].productAttributes.length;x++){
      for(var y=0;y<data[0].productAttributes[x].productAttributeValues.length;y++){
           data[0].productAttributes[x].productAttributeValues[y].isCheck = null; 
      }
    } 

    for (var i = 0; i < data[0].productSkus.length; i++) {
      if (data[0].productSkus[i].inventory>0) {
        if(data[0].productSkus[i].appPrice<minPrice){
          minIndex = i;
          minPrice = data[0].productSkus[i].appPrice;
        }
        setState(() {
           isInventory = true;
        });
      }
    }
    if(minPrice!=99999){
      codeList = data[0].productSkus[minIndex].code.split('-');
    }
     


    for(var i=1;i<codeList.length;i++){
      for(var x = 0; x < data[0].productSkus.length; x++ ){
        if(data[0].productSkus[x].inventory==0&&data[0].productSkus[x].code.contains("${codeList[i]}")){
          noInventorySkuList.add(data[0].productSkus[x]);
        }
      }
    }

    

    for(var i=0;i<noInventorySkuList.length;i++){
      for(var o=0;o<noInventorySkuList[i].code.split('-').length;o++){
        for(var x=0;x<data[0].productAttributes.length;x++){
          for(var y=0;y<data[0].productAttributes[x].productAttributeValues.length;y++){
            if(data[0].productAttributes[x].productAttributeValues[y].id == int.parse(noInventorySkuList[i].code.split('-')[o]) ){
              data[0].productAttributes[x].productAttributeValues[y].isCheck = true;
            }
          }
        } 
      }
    }

    if(data[0].productAttributes.length==1){
      for(var i=0;i<data[0].productAttributes[0].productAttributeValues.length;i++){
          for(var x = 0; x < data[0].productSkus.length; x++ ){
            if(data[0].productSkus[x].inventory==0&&data[0].productSkus[x].code.split('-')[1] == "${data[0].productAttributes[0].productAttributeValues[i].id}"){
                print(data[0].productAttributes[0].productAttributeValues[i].id);
            print(data[0].productSkus[x].code);
              data[0].productAttributes[0].productAttributeValues[i].isCheck = true;
            }
          }
      }
    }

    for (var i = 0; i < data[0].productAttributes.length; i++) {
      if (data[0].productAttributes[i].productAttributeValues.length == 1) {
        checkSku.add('${data[0].productAttributes[i].productAttributeValues[0].id}');
        checkList.add(0);
      } else {
        if(codeList.length>0){
           for (var x = 0;x < data[0].productAttributes[i].productAttributeValues.length;x++) {
            if (data[0].productAttributes[i].productAttributeValues[x].id.toString() == codeList[i + 1]) {
              checkSku.add(codeList[i + 1]);
              checkList.add(x);
              selectIndex = x;
            }
          }
        }
      }
      indexName += '${data[0].productAttributes[i].name} ';
      if (data[0].productAttributes[i].productAttributeValues[0].productAttributeImageUrl !=null && data[0].productAttributes[i].productAttributeValues[0].productAttributeImageUrl !='' &&data[0].productAttributes[i].productAttributeValues.length > 1) {
        skuType = 1;
        skuAttrImage = i;
      }
    }
    selectSku();
  }

  onSkuChange(index,code) {
    
    List noInventorySkuList = [];


    for(var x=0;x<data[0].productAttributes.length;x++){
      for(var y=0;y<data[0].productAttributes[x].productAttributeValues.length;y++){
        setState(() {
          data[0].productAttributes[x].productAttributeValues[y].isCheck = false;
        });
      }
    }

    for(var i=0;i<checkSku.length;i++){
        for(var x = 0; x < data[0].productSkus.length; x++ ){
          if(index==i){
            if(data[0].productSkus[x].inventory==0&&data[0].productSkus[x].code.contains("${code}")){
              noInventorySkuList.add(data[0].productSkus[x]);
            }
          }else{
            if(data[0].productSkus[x].inventory==0&&data[0].productSkus[x].code.contains("${checkSku[i]}")){
              noInventorySkuList.add(data[0].productSkus[x]);
            }
          }
        }
    }
    for(var i=0;i<noInventorySkuList.length;i++){
      for(var o=0;o<noInventorySkuList[i].code.split('-').length;o++){
        for(var x=0;x<data[0].productAttributes.length;x++){
          for(var y=0;y<data[0].productAttributes[x].productAttributeValues.length;y++){
            if(data[0].productAttributes[x].productAttributeValues[y].id == int.parse(noInventorySkuList[i].code.split('-')[o]) ){
              setState(() {
                data[0].productAttributes[x].productAttributeValues[y].isCheck = true;
              });
            }
          }
        } 
      }
    }
     if(data[0].productAttributes.length==1){
      for(var i=0;i<data[0].productAttributes[0].productAttributeValues.length;i++){
          for(var x = 0; x < data[0].productSkus.length; x++ ){
            if(data[0].productSkus[x].inventory==0&&data[0].productSkus[x].code.split('-')[1] == "${data[0].productAttributes[0].productAttributeValues[i].id}"){
                setState(() { 
                  data[0].productAttributes[0].productAttributeValues[i].isCheck = true;
                });
            }
          }
      }
    }
  }

  void selectSku() {
    setState(() {
      lock = false;
      checkSkuIndex = -1;
    });
    if (checkSku.length == data[0].productAttributes.length) {
      String skuCode = "${data[0].id}";
      for (var i = 0; i < checkSku.length; i++) {
        if (checkSku[i] != '0') {
          skuCode += "-${checkSku[i]}";
        }
      }
      String text = "";
      for (var i = 0; i < checkList.length; i++) {
        if (checkList[i] == "-1") {
          text += "${data[0].productAttributes[i].name}";
        }
      }
      setState(() {
        indexName = text;
      });
      for (var i = 0; i < data[0].productSkus.length; i++) {
        if (skuCode == data[0].productSkus[i].code) {
          checkName = data[0].productSkus[i].name;
          checkSkuCode = data[0].productSkus[i].code;
          checkSkuIndex = i;
          setState(() {
            lock = true;
          });
          price = widget.type == '0'
              ? '${doubleText(data[0].productSkus[i].depletionPrice)}'
              : '${doubleText(data[0].productSkus[i].appPrice)}';

          checkPrice = widget.type == '0'? data[0].productSkus[i].depletionPrice.toDouble(): data[0].productSkus[i].appPrice;

          checkImg = data[0].productSkus[i].productImageUrl;
        }
      }
    }
  }

  void onNumChange(val) {
    setState(() {
      num = val;
    });
  }

  Widget renderType(String text, int index, _index,isCheck) {
    if (index != _index) {
      return Container(
        padding: EdgeInsets.fromLTRB(20, 6.5, 20, 6.5),
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, 
          color:isCheck==true?Color(0xFFBCBCBC) :Color(0xFF222222), 
          decoration: isCheck==true?TextDecoration.lineThrough:null,
          decorationColor:isCheck==true?Color(0xFFBCBCBC):null, ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(20, 6.5, 20, 6.5),
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        decoration: BoxDecoration(
          color: Color(0xFFFEF2F3),
          border: new Border.all(width: 0.5, color: Color(0xFFED1B2E)),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFFED1B2E)),
        ),
      );
    }
  }

  Widget tag(int index,isCheck) {
    String isUrl = data[0]
        .productAttributes[skuAttrImage]
        .productAttributeValues[index]
        .productAttributeImageUrl;
    if (!isUrl.startsWith("http")) {
      isUrl = "https:" +
          data[0]
              .productAttributes[skuAttrImage]
              .productAttributeValues[index]
              .productAttributeImageUrl;
    }
    if (checkList.length>0&&index == checkList[skuAttrImage]) {
      return Stack(children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
             Container(
          decoration: BoxDecoration(
            color: Color(0xFFFEF2F3),
            border: new Border.all(width: 0.5, color: Color(0xFFED1B2E)),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child:  ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(
                    'assets/icons/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                  imageUrl: isUrl,
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/icons/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )),
              
              Container(
                padding: EdgeInsets.fromLTRB(0, 6.5, 0,6.5 ),
                margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                decoration: BoxDecoration(
                color: Color(0xFFFEF2F3),
                border: new Border.all(width: 0.5, color: Color(0xFFED1B2E)),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                  data[0]
                      .productAttributes[skuAttrImage]
                      .productAttributeValues[index]
                      .value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xFFED1B2E), fontSize: 13),
                ),
                  ],
                )
              )
            ],
          ),
        ),
        Container(
          height: 30,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("")),
                ],
              )),
              renderSearch()
            ],
          ),
        ),
      ]);
    } else {
      return Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: new Border.all(width: 0.5, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(
                    'assets/icons/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                  imageUrl: isUrl,
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/icons/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
               Container(
                padding: EdgeInsets.fromLTRB(0, 6.5, 0,6.5 ),
                margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: new Border.all(width: 0.5, color: Color(0xFFF6F6F6)),
              ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Text(
                  data[0].productAttributes[skuAttrImage].productAttributeValues[index].value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13,
                    color:isCheck==true?Color(0xFFBCBCBC) :Color(0xFF222222), 
                    decoration: isCheck==true?TextDecoration.lineThrough:null,
                    decorationColor:isCheck==true?Color(0xFFBCBCBC):null,
                  ),
                )]),
              )
            ],
          ),
        ),
        Container(
          height: 30,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container()),
                ],
              )),
              renderSearch()
            ],
          ),
        ),
      ]);
    }
  }

  Widget renderSearch() {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
        height: 30,
        width: 30,
        margin: EdgeInsets.fromLTRB(0, 1, 1, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
          color: Color(0x7A000000),
        ),
        child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context1, state) {
                    return GestureDetector(
                        onTap: () {
                          state(() {
                            checkList[skuAttrImage] = selectIndex;
                            checkSku[skuAttrImage] = data[0].productAttributes[skuAttrImage].productAttributeValues[selectIndex].id;
                            selectSku();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            color: Colors.black,
                            child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 100, 0, 30),
                                child: Text(
                                  "${selectIndex + 1}/${data[0].productAttributes[skuAttrImage].productAttributeValues.length}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              Container(
                                  color: Colors.black,
                                  child: AspectRatio(
                                      aspectRatio: 16 / 13,
                                      child: Swiper(
                                        index: selectIndex,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/icons/placeholder.png',
                                              fit: BoxFit.cover,
                                            ),
                                            imageUrl: data[0]
                                                    .productAttributes[
                                                        skuAttrImage]
                                                    .productAttributeValues[
                                                        index]
                                                    .productAttributeImageUrl
                                                    .startsWith("http")
                                                ? data[0]
                                                    .productAttributes[
                                                        skuAttrImage]
                                                    .productAttributeValues[
                                                        index]
                                                    .productAttributeImageUrl
                                                : "http:" +
                                                    data[0]
                                                        .productAttributes[
                                                            skuAttrImage]
                                                        .productAttributeValues[
                                                            index]
                                                        .productAttributeImageUrl,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/icons/placeholder.png',
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                        onIndexChanged: (index) {
                                          state(() {
                                            selectIndex = index;
                                          });
                                        },
                                        onTap: (index) {
                                          state(() {
                                            selectIndex = index;
                                            checkList[skuAttrImage] = index;
                                            checkSku[skuAttrImage] = data[0]
                                                .productAttributes[skuAttrImage]
                                                .productAttributeValues[index]
                                                .id;
                                            selectSku();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        itemCount: data[0]
                                            .productAttributes[skuAttrImage]
                                            .productAttributeValues
                                            .length,
                                        viewportFraction: 0.8,
                                        scale: 0.9,
                                      ))),
                              Container(
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                                    height: 44,
                                    width: data[0]
                                                .productAttributes[skuAttrImage]
                                                .productAttributeValues[
                                                    selectIndex]
                                                .value
                                                .length *
                                            16 +
                                        74.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(25.0),
                                      border: new Border.all(
                                          width: 1, color: Colors.white),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 18, 0),
                                          child: Image.asset(
                                            "assets/icons/icon-success.png",
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        Text(
                                          data[0]
                                              .productAttributes[skuAttrImage]
                                              .productAttributeValues[
                                                  selectIndex]
                                              .value,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, 0, 18 + bottomPadding),
                                      child: Text(
                                        "左右滑動圖片查看規格，點擊圖片關閉並選中規格",
                                        style: TextStyle(color: Colors.white),
                                      )))
                            ])));
                  });
                },
              );
            },
            child: Image.asset(
              "assets/icons/search-light.png",
              width: 20,
              height: 20,
            )));
  }

  Widget renderBanner() {
    final size = MediaQuery.of(context).size;
    final _width =data[0].productAttributes[skuAttrImage].productAttributeValues.length <= 3 ? (size.width - 40) / 3 : (size.width - 60) / 3;
    print(_width);
    print("宽度");
    return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount:data[0].productAttributes[skuAttrImage].productAttributeValues.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            if(data[0].productAttributes[skuAttrImage].productAttributeValues[index].isCheck == true){
 
            }else{
              onSkuChange(skuAttrImage,data[0].productAttributes[skuAttrImage].productAttributeValues[index].id);
              setState(() {
                selectIndex = index;
                checkList[skuAttrImage] = index;
                checkSku[skuAttrImage] = data[0].productAttributes[skuAttrImage].productAttributeValues[index].id;
              selectSku();
            });
            }
           
          },
          child: Container(
              margin: EdgeInsets.fromLTRB(10,0,index ==data[0].productAttributes[skuAttrImage].productAttributeValues.length -1? 10: 0,0),
              width: _width,
              child: tag(index,data[0].productAttributes[skuAttrImage].productAttributeValues[index].isCheck)),
        );
      },
    );
  }


  List<Widget> boxs(pIndex) => List.generate(
          data[0].productAttributes[pIndex].productAttributeValues.length,(index) {
        return GestureDetector(
            onTap: () {
              if(data[0].productAttributes[pIndex].productAttributeValues[index].isCheck==true){
                  print("不能选");
              }else{
                  onSkuChange(pIndex,data[0].productAttributes[pIndex].productAttributeValues[index].id);
                  setState(() {
                    checkList[pIndex] = index;
                    checkSku[pIndex] = data[0].productAttributes[pIndex].productAttributeValues[index].id;
                  selectSku();
              });
              }
            },
            child: renderType(data[0].productAttributes[pIndex].productAttributeValues[index].value,index,checkList[pIndex],data[0].productAttributes[pIndex].productAttributeValues[index].isCheck));
      });

  Widget priceModel(double _height, double _width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, _height, 10, 0),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFED1B2E),
                  ),
                ),
              ),
              Text(
                data.length > 0 ? price : '',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFFED1B2E),
                ),
              ),
              _height == 10
                  ? Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              'assets/icons/icon-close.png',
                              width: 15,
                              height: 15,
                              color: Color(0xFF222222),
                            ),
                          )))
                  : Container()
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 3),
          width: _height == 45?_width-180:null,
          alignment: Alignment.centerLeft,
          child: checkName == ''
              ? Text(
                  "請選擇：${indexName}",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                )
              : Text("已選擇：${checkName}",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 25),
          height: size.height * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: new ListView(shrinkWrap: true, children: <Widget>[
            Container(
                margin: EdgeInsets.only(
                    top: skuType == 1 ? 40 : 125, bottom: 58 + bottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    skuType == 1
                        ? Container(
                            height: (data[0].productAttributes[skuAttrImage].productAttributeValues.length <= 3 ? (size.width - 40) / 3 : (size.width - 60) / 3)+40,
                            child: renderBanner(),
                          )
                        : Container(),
                    Container(
                      child: Column(
                        children: modelList(),
                      ),
                    ),
                  widget.callBack==null?Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                      alignment: Alignment.centerLeft,
                      child: Text("数量",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                    ):Container(),
                   widget.callBack==null? Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                      child: CartCount(
                          val: num,
                          max: 10,
                          callback: (val) => onNumChange(val)),
                    ):Container(),
                    // Row(
                    //   children: <Widget>[
                    //     Expanded(
                    //         child: GestureDetector(
                    //             onTap: () {

                    //               if (checkSkuIndex >= 0) {
                    //                 Provide.value<CartProvide>(context)
                    //                     .save(
                    //                         data[0]
                    //                             .productSkus[checkSkuIndex]
                    //                             .productId,
                    //                         data[0].title,
                    //                         num,
                    //                         data[0]
                    //                             .productSkus[checkSkuIndex]
                    //                             .id,
                    //                         data[0]
                    //                             .productSkus[checkSkuIndex]
                    //                             .barcode,
                    //                         data[0]
                    //                             .productSkus[checkSkuIndex]
                    //                             .name,
                    //                         data[0]
                    //                             .productSkus[checkSkuIndex]
                    //                             .productImageUrl,
                    //                         true,
                    //                         checkPrice,
                    //                         data[0]
                    //                             .productSkus[checkSkuIndex]
                    //                             .price, //原价
                    //                         data[0]
                    //                             .productSkus[checkSkuIndex]
                    //                             .depletionPrice //折扣价
                    //                         );
                    //                 Toast.toast(context,
                    //                     msg: "添加成功，在购物车等您～",
                    //                     position: ToastPostion.bottom);
                    //                 Navigator.pop(context);
                    //               }else{

                    //                 String text = "";
                    //                 for(var i=0;i<checkList.length;i++){
                    //                     if(checkList[i]=="-1"){
                    //                       text += "${data[0].productAttributes[i].name} ";
                    //                     }
                    //                 }
                    //                  Toast.toast(context,
                    //                     msg: "请选择${text}",
                    //                     position: ToastPostion.bottom);
                    //               }
                    //             },
                    //             child: new Container(
                    //               margin: EdgeInsets.only(
                    //                   left: 20, right: 20, top: 20),
                    //               height: 38.0,
                    //               alignment: Alignment.center,
                    //               decoration: BoxDecoration(
                    //                 shape: BoxShape.rectangle,
                    //                 borderRadius: BorderRadius.circular(23.0),
                    //                 color: Color(0xFFED1B2E),
                    //               ),
                    //               child: Text(
                    //                 "確定",
                    //                 style: TextStyle(
                    //                     color: Colors.white, fontSize: 16),
                    //               ),
                    //               // 设置按钮圆角
                    //             )))
                    //   ],
                    // )
                  ],
                ))
          ]),
        ),
        Positioned(
            child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          height: skuType == 1 ? 63 : 160,
          child: Column(
            children: <Widget>[
              skuType == 1
                  ? priceModel(10,size.width)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                'assets/icons/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                              imageUrl: checkImg != ""
                                  ? checkImg.startsWith("http")
                                      ? checkImg
                                      : 'http:' + checkImg
                                  : data[0]
                                          .productSkus[0]
                                          .productImageUrl
                                          .stseartsWith("http")
                                      ? data[0].productSkus[0].productImageUrl
                                      : 'http:' +
                                          data[0]
                                              .productSkus[0]
                                              .productImageUrl,
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/icons/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        priceModel(45,size.width),
                        Expanded(
                            child: Container(
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.only(right: 15, top: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Image.asset(
                                    'assets/icons/icon-close.png',
                                    width: 15,
                                    height: 15,
                                    color: Color(0xFF222222),
                                  ),
                                )))
                      ],
                    )
            ],
          ),
        )),
        Row(
          children: <Widget>[
          Expanded(
                child: isInventory?Container(
                    child: GestureDetector(
                        onTap: () {
                          if (checkSkuIndex >= 0) {
                            if(widget.callBack!=null){
                              var orderProductData = {
                                 "productSkuId" :data[0].productSkus[checkSkuIndex].id,
                                 "productSkuBarcode" :data[0].productSkus[checkSkuIndex].barcode,
                                 "discountPrice" : data[0].productSkus[checkSkuIndex].depletionPrice,
                                 "originalPrice" :data[0].productSkus[checkSkuIndex].appPrice,
                                 "productSkuPrice":data[0].productSkus[checkSkuIndex].appPrice,
                                 "productSkuName":data[0].productSkus[checkSkuIndex].name,
                                 "productSkuImage":data[0].productSkus[checkSkuIndex].productImageUrl
                              };
                              widget.callBack(orderProductData);
                               Navigator.pop(context);
                            }else{

                              Provide.value<CartProvide>(context).save(
                                  data[0].productSkus[checkSkuIndex].productId,
                                  data[0].title,
                                  num,
                                  data[0].productSkus[checkSkuIndex].id,
                                  data[0].productSkus[checkSkuIndex].barcode,
                                  data[0].productSkus[checkSkuIndex].name,
                                  data[0].productSkus[checkSkuIndex].productImageUrl,
                                  true,
                                  checkPrice,
                                  data[0].productSkus[checkSkuIndex].price, //原价
                                  data[0].productSkus[checkSkuIndex].depletionPrice, //折扣价
                                  type == "1" ? 4 : 3,
                                  isLimitProduct
                                );
                                Toast.toast(context,msg: "添加成功，在購物車等您～",position: ToastPostion.bottom);
                              
                                facebookAppEvents.logEvent(
                                  name: 'fb_mobile_add_to_cart',
                                  parameters: {
                                    'fb_content_id':data[0].id,
                                    'fb_content_type': 'product',
                                    'fb_description': data[0].title,
                                    'fb_currency': 'TWD',
                                    'contents':json.encode({
                                        "id":  data[0].productSkus[checkSkuIndex].id,
                                        "quantity": num,
                                        "item_price": type == "1" ? data[0].productSkus[checkSkuIndex].appPrice : data[0].productSkus[checkSkuIndex].depletionPrice
                                    })
                                  },
                                );
                              int catNum =Provide.value<CurrentIndexProvide>(context).catNum;
                              Provide.value<CurrentIndexProvide>(context).changeCatNum(catNum + num);
                              Navigator.pop(context);
                            }
                            
                          } else {
                            String text = "";
                            for (var i = 0; i < checkList.length; i++) {
                              if (checkList[i] == "-1") {
                                text += "${data[0].productAttributes[i].name} ";
                              }
                            }
                            Toast.toast(context,
                                msg: "請選擇${text}",
                                position: ToastPostion.bottom);
                          }
                        },
                        child: new Container(
                          margin: EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: size.height * 0.7 - (58 + bottomPadding)),
                          padding:
                              EdgeInsets.fromLTRB(0, 10, 0, 10 + bottomPadding),
                          height: 58.0 + bottomPadding,
                          color: Colors.white,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(23.0),
                              color: Color(0xFFED1B2E),
                            ),
                            child: Text(
                              "確定",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          // 设置按钮圆角
                        ))):Container(
                    child: new Container(
                          margin: EdgeInsets.only(
                              left: 0,
                              right: 0,
                              top: size.height * 0.7 - (58 + bottomPadding)),
                          padding:
                              EdgeInsets.fromLTRB(0, 10, 0, 10 + bottomPadding),
                          height: 58.0 + bottomPadding,
                          color: Colors.white,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(23.0),
                              color: Color(0xFFACACAC),
                            ),
                            child: Text(
                              "商品已售罄",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          // 设置按钮圆角
                        )))
          ],
        )
      ],
    );
  }

  List<Widget> modelList() =>
      List.generate(data[0].productAttributes.length, (index) {
        return index != skuAttrImage
            ? Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                      alignment: Alignment.centerLeft,
                      child: Text(data[0].productAttributes[index].name,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                        child: Container(
                            child: Wrap(
                          spacing: 2, //主轴上子控件的间距
                          runSpacing: 5, //交叉轴上子控件之间的间距
                          children: boxs(index), //要显示的子控��集合
                        ))),
                  ]))
            : Container();
      });

  
}
