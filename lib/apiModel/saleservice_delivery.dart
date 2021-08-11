import 'package:json_annotation/json_annotation.dart'; 
  
part 'saleservice_delivery.g.dart';


@JsonSerializable()
  class saleservice_delivery extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  saleservice_delivery(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory saleservice_delivery.fromJson(Map<String, dynamic> srcJson) => _$saleservice_deliveryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$saleservice_deliveryToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'deliveryProducts')
  List<DeliveryProducts> deliveryProducts;

  @JsonKey(name: 'saleServiceModules')
  List<SaleServiceModules> saleServiceModules;

  Body(this.deliveryProducts,this.saleServiceModules,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class DeliveryProducts extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'deliveryId')
  int deliveryId;

  @JsonKey(name: 'deliveryCode')
  String deliveryCode;

  @JsonKey(name: 'orderId')
  int orderId;

  @JsonKey(name: 'orderCode')
  String orderCode;

  @JsonKey(name: 'orderProductId')
  int orderProductId;

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'productTitle')
  String productTitle;

  @JsonKey(name: 'productSkuId')
  int productSkuId;

  @JsonKey(name: 'productSkuBarcode')
  String productSkuBarcode;

  @JsonKey(name: 'productSkuName')
  String productSkuName;

  @JsonKey(name: 'productSkuPrice')
  double productSkuPrice;

   @JsonKey(name: 'discountPrice')
  int discountPrice;

   @JsonKey(name: 'originalPrice')
  double originalPrice;

  @JsonKey(name: 'deliveryQuantity')
  int deliveryQuantity;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'createdBy')
  String createdBy;

  @JsonKey(name: 'updatedBy')
  String updatedBy;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'storehouseInventoryPositions')
  String storehouseInventoryPositions;

  @JsonKey(name: 'pickQuantity')
  int pickQuantity;

  @JsonKey(name: 'productSkuImage')
  String productSkuImage;

  @JsonKey(name: 'sourceProductSkuId')
  int sourceProductSkuId;

  @JsonKey(name: 'productStatus')
  int productStatus;

  DeliveryProducts(this.id,this.deliveryId,this.deliveryCode,this.orderId,this.orderCode,this.orderProductId,this.productId,this.productTitle,this.productSkuId,this.productSkuBarcode,this.productSkuName,this.productSkuPrice,this.discountPrice,this.originalPrice,this.deliveryQuantity,this.status,this.createdBy,this.updatedBy,this.updatedAt,this.createdAt,this.storehouseInventoryPositions,this.pickQuantity,this.productSkuImage,this.sourceProductSkuId,this.productStatus);

  factory DeliveryProducts.fromJson(Map<String, dynamic> srcJson) => _$DeliveryProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeliveryProductsToJson(this);

}

  
@JsonSerializable()
  class SaleServiceModules extends Object {

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
  int returnTrackingNumber;

  @JsonKey(name: 'lineAcount')
  String lineAcount;

  @JsonKey(name: 'saleServiceTotalPrice')
  double saleServiceTotalPrice;

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

  @JsonKey(name: 'yn')
  int yn;

  SaleServiceModules(this.id,this.serviceType,this.serviceSource,this.orderId,this.orderCode,this.scopeId,this.paymentType,this.consignee,this.tel,this.deliveryCode,this.trackingNumber,this.storehouseId,this.accountInfo,this.accountName,this.accountNumber,this.accountBank,this.accountBankImgs,this.handleType,this.handleResult,this.handleStatus,this.newOrderCode,this.returnTrackingNumber,this.lineAcount,this.saleServiceTotalPrice,this.serviceCustomerImgs,this.serviceCustomerMsgs,this.createdBy,this.updatedBy,this.updatedAt,this.createdAt,this.customerAddressInfo,this.afterSaleServiceProducts,this.yn,);

  factory SaleServiceModules.fromJson(Map<String, dynamic> srcJson) => _$SaleServiceModulesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SaleServiceModulesToJson(this);

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

  @JsonKey(name: 'sourceOriginalPrice')
  double sourceOriginalPrice;

  @JsonKey(name: 'sourceUnderlinePrice')
  int sourceUnderlinePrice;

  @JsonKey(name: 'serviceType')
  String serviceType;
  @JsonKey(name: 'subServiceType')
  String subServiceType;

  @JsonKey(name: 'serviceDesc')
  String serviceDesc;

  @JsonKey(name: 'handleStatus')
  int handleStatus;

  @JsonKey(name: 'createdBy')
  String createdBy;

  @JsonKey(name: 'updatedBy')
  String updatedBy;

  @JsonKey(name: 'sourceProductIsLimit')
  int sourceProductIsLimit;

  AfterSaleServiceProducts(this.id,this.updatedAt,this.createdAt,this.saleServiceId,this.deliveryCode,this.productId,this.quantity,this.sourceProductSkuId,this.sourceProductSkuBarcode,this.sourceDiscountPrice,this.sourceOriginalPrice,this.sourceUnderlinePrice,this.serviceType,this.subServiceType,this.serviceDesc,this.handleStatus,this.createdBy,this.updatedBy,this.sourceProductIsLimit,);

  factory AfterSaleServiceProducts.fromJson(Map<String, dynamic> srcJson) => _$AfterSaleServiceProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AfterSaleServiceProductsToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  @JsonKey(name: 'requestTime')
  List<String> requestTime;

  @JsonKey(name: 'responseTime')
  List<String> responseTime;

  Headers(this.requestTime,this.responseTime,);

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
