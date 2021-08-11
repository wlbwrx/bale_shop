import 'package:json_annotation/json_annotation.dart'; 
  
part 'order.g.dart';


@JsonSerializable()
  class order extends Object {

  @JsonKey(name: 'body')
  List<Body> body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  order(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory order.fromJson(Map<String, dynamic> srcJson) => _$orderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$orderToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'freight')
  double freight;

  @JsonKey(name: 'originalTotalPrice')
  double originalTotalPrice;

  @JsonKey(name: 'discountTotalPrice')
  double discountTotalPrice;

  @JsonKey(name: 'randomReductionPrice')
  double randomReductionPrice;

  @JsonKey(name: 'totalPrice')
  double totalPrice;

  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'pixelId')
  String pixelId;

  @JsonKey(name: 'affiliate')
  String affiliate;

  @JsonKey(name: 'scopeId')
  int scopeId;

  @JsonKey(name: 'paymentType')
  int paymentType;

  @JsonKey(name: 'orderType')
  int orderType;

  @JsonKey(name: 'priority')
  int priority;

  @JsonKey(name: 'ip')
  String ip;

  @JsonKey(name: 'mergeType')
  int mergeType;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'storehouseId')
  int storehouseId;

  @JsonKey(name: 'version')
  int version;

  @JsonKey(name: 'orderAddress')
  OrderAddress orderAddress;

  @JsonKey(name: 'packageInfos')
  List<PackageInfos> packageInfos;

  Body(this.id,this.code,this.freight,this.originalTotalPrice,this.discountTotalPrice,this.randomReductionPrice,this.totalPrice,this.currency,this.status,this.message,this.pixelId,this.affiliate,this.scopeId,this.paymentType,this.orderType,this.priority,this.ip,this.mergeType,this.updatedAt,this.createdAt,this.storehouseId,this.version,this.orderAddress,this.packageInfos,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class OrderAddress extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'consignee')
  String consignee;

  @JsonKey(name: 'tel')
  String tel;

  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'province')
  String province;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'district')
  String district;

  @JsonKey(name: 'detail')
  String detail;

  @JsonKey(name: 'orderId')
  int orderId;

  @JsonKey(name: 'type')
  int type;

  OrderAddress(this.id,this.updatedAt,this.createdAt,this.consignee,this.tel,this.country,this.province,this.city,this.district,this.detail,this.orderId,this.type,);

  factory OrderAddress.fromJson(Map<String, dynamic> srcJson) => _$OrderAddressFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderAddressToJson(this);

}

  
@JsonSerializable()
  class PackageInfos extends Object {

  @JsonKey(name: 'delivery_quantity')
  int deliveryQuantity;

  @JsonKey(name: 'sku_quantity')
  int skuQuantity;

  @JsonKey(name: 'sku_infos')
  List<Sku_infos> skuInfos;

  PackageInfos(this.deliveryQuantity,this.skuQuantity,this.skuInfos,);

  factory PackageInfos.fromJson(Map<String, dynamic> srcJson) => _$PackageInfosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PackageInfosToJson(this);

}

  
@JsonSerializable()
  class Sku_infos extends Object {

  @JsonKey(name: 'product_sku_barcode')
  String productSkuBarcode;

  @JsonKey(name: 'sale_service_in')
  String saleServiceIn;

  @JsonKey(name: 'quantity')
  String quantity;

  @JsonKey(name: 'sale_service_reject')
  String saleServiceReject;

  @JsonKey(name: 'discount_price')
  String discountPrice;

  @JsonKey(name: 'product_id')
  String productId;

  @JsonKey(name: 'product_sku_id')
  String productSkuId;

  @JsonKey(name: 'product_sku_name')
  String productSkuName;

  @JsonKey(name: 'order_product_status')
  String orderProductStatus;

  @JsonKey(name: 'product_image_url')
  String productImageUrl;

  @JsonKey(name: 'sale_service_pass')
  String saleServicePass;

  @JsonKey(name: 'product_title')
  String productTitle;

  @JsonKey(name: 'cancel_product_count')
  String cancelProductCount;

  @JsonKey(name: 'cancel_product_count')
  String isLimitProduct;

  Sku_infos(this.productSkuBarcode,this.saleServiceIn,this.quantity,this.saleServiceReject,this.discountPrice,this.productId,this.productSkuId,this.productSkuName,this.orderProductStatus,this.productImageUrl,this.saleServicePass,this.productTitle,this.cancelProductCount,this.isLimitProduct);

  factory Sku_infos.fromJson(Map<String, dynamic> srcJson) => _$Sku_infosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Sku_infosToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
