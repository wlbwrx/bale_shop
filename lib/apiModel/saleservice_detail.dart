import 'package:json_annotation/json_annotation.dart'; 
  
part 'saleservice_detail.g.dart';


@JsonSerializable()
  class saleservice_detail extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  saleservice_detail(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory saleservice_detail.fromJson(Map<String, dynamic> srcJson) => _$saleservice_detailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$saleservice_detailToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'serviceType')
  int serviceType;

  @JsonKey(name: 'serviceSource')
  int serviceSource;

  @JsonKey(name: 'orderId')
  int orderId;

  @JsonKey(name: 'orderCode')
  String orderCode;

  @JsonKey(name: 'scopeId')
  int scopeId;

  @JsonKey(name: 'paymentType')
  int paymentType;

  @JsonKey(name: 'consignee')
  String consignee;

  @JsonKey(name: 'tel')
  String tel;

  @JsonKey(name: 'deliveryCode')
  String deliveryCode;

  @JsonKey(name: 'trackingNumber')
  String trackingNumber;

  @JsonKey(name: 'storehouseId')
  int storehouseId;

  @JsonKey(name: 'accountInfo')
  String accountInfo;

  @JsonKey(name: 'accountName')
  String accountName;

  @JsonKey(name: 'accountNumber')
  String accountNumber;

  @JsonKey(name: 'accountBank')
  String accountBank;

  @JsonKey(name: 'accountBankImgs')
  String accountBankImgs;

  @JsonKey(name: 'handleType')
  String handleType;

  @JsonKey(name: 'handleResult')
  String handleResult;

  @JsonKey(name: 'handleStatus')
  int handleStatus;

  @JsonKey(name: 'newOrderCode')
  String newOrderCode;

  @JsonKey(name: 'returnTrackingNumber')
  String returnTrackingNumber;

  @JsonKey(name: 'lineAcount')
  String lineAcount;

  @JsonKey(name: 'saleServiceTotalPrice')
  double saleServiceTotalPrice;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'serviceCustomerImgs')
  String serviceCustomerImgs;

  @JsonKey(name: 'serviceCustomerMsgs')
  String serviceCustomerMsgs;

  @JsonKey(name: 'createdBy')
  String createdBy;

  @JsonKey(name: 'updatedBy')
  String updatedBy;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'customerAddressInfo')
  String customerAddressInfo;

  @JsonKey(name: 'afterSaleServiceProducts')
  List<AfterSaleServiceProducts> afterSaleServiceProducts;

  @JsonKey(name: 'trackerInfo')
  String trackerInfo;

  @JsonKey(name: 'createBeginTime')
  String createBeginTime;

  @JsonKey(name: 'createEndTime')
  String createEndTime;

  @JsonKey(name: 'sourceAddress')
  String sourceAddress;

  @JsonKey(name: 'yn')
  int yn;

  Body(this.id,this.serviceType,this.serviceSource,this.orderId,this.orderCode,this.scopeId,this.paymentType,this.consignee,this.tel,this.deliveryCode,this.trackingNumber,this.storehouseId,this.accountInfo,this.accountName,this.accountNumber,this.accountBank,this.accountBankImgs,this.handleType,this.handleResult,this.handleStatus,this.newOrderCode,this.returnTrackingNumber,this.lineAcount,this.saleServiceTotalPrice,this.userId,this.serviceCustomerImgs,this.serviceCustomerMsgs,this.createdBy,this.updatedBy,this.updatedAt,this.createdAt,this.customerAddressInfo,this.afterSaleServiceProducts,this.trackerInfo,this.createBeginTime,this.createEndTime,this.sourceAddress,this.yn,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class AfterSaleServiceProducts extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'saleServiceId')
  int saleServiceId;

  @JsonKey(name: 'deliveryCode')
  String deliveryCode;

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'sourceProductSkuId')
  int sourceProductSkuId;

  @JsonKey(name: 'sourceProductSkuBarcode')
  String sourceProductSkuBarcode;

  @JsonKey(name: 'sourceDiscountPrice')
  double sourceDiscountPrice;

  @JsonKey(name: 'discountPrice')
  double discountPrice;

  @JsonKey(name: 'originalPrice')
  double originalPrice;

  @JsonKey(name: 'sourceOriginalPrice')
  double sourceOriginalPrice;

  @JsonKey(name: 'sourceUnderlinePrice')
  int sourceUnderlinePrice;

  @JsonKey(name: 'productSkuId')
  int productSkuId;

  @JsonKey(name: 'productSkuBarcode')
  String productSkuBarcode;

  @JsonKey(name: 'underlinePrice')
  int underlinePrice;

  @JsonKey(name: 'serviceType')
  String serviceType;

  @JsonKey(name: 'subServiceType')
  String subServiceType;


  @JsonKey(name: 'handleStatus')
  int handleStatus;

  @JsonKey(name: 'createdBy')
  String createdBy;

  @JsonKey(name: 'updatedBy')
  String updatedBy;

  @JsonKey(name: 'sourceProductTitle')
  String sourceProductTitle;

  @JsonKey(name: 'productTitle')
  String productTitle;

  @JsonKey(name: 'productSkuImage')
  String productSkuImage;

  @JsonKey(name: 'sourceProductSkuImage')
  String sourceProductSkuImage;

  @JsonKey(name: 'productSkuName')
  String productSkuName;

  @JsonKey(name: 'sourceProductSkuName')
  String sourceProductSkuName;

  @JsonKey(name: 'sourceProductIsLimit')
  int sourceProductIsLimit;

  AfterSaleServiceProducts(this.id,this.updatedAt,this.createdAt,this.saleServiceId,this.deliveryCode,this.productId,this.quantity,this.sourceProductSkuId,this.sourceProductSkuBarcode,this.sourceDiscountPrice,this.discountPrice,this.originalPrice,this.sourceOriginalPrice,this.sourceUnderlinePrice,this.productSkuId,this.productSkuBarcode,this.underlinePrice,this.serviceType,this.subServiceType,this.handleStatus,this.createdBy,this.updatedBy,this.sourceProductTitle,this.productTitle,this.productSkuImage,this.sourceProductSkuImage,this.productSkuName,this.sourceProductSkuName,this.sourceProductIsLimit,);

  factory AfterSaleServiceProducts.fromJson(Map<String, dynamic> srcJson) => _$AfterSaleServiceProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AfterSaleServiceProductsToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
