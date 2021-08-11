import 'package:json_annotation/json_annotation.dart'; 
  
part 'order_list.g.dart';


@JsonSerializable()
  class order_list extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  order_list(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory order_list.fromJson(Map<String, dynamic> srcJson) => _$order_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$order_listToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'content')
  List<Content> content;

  @JsonKey(name: 'last')
  bool last;

  @JsonKey(name: 'totalElements')
  int totalElements;

  @JsonKey(name: 'totalPages')
  int totalPages;

  @JsonKey(name: 'number')
  int number;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'first')
  bool first;

  @JsonKey(name: 'numberOfElements')
  int numberOfElements;

  Body(this.content,this.last,this.totalElements,this.totalPages,this.number,this.size,this.first,this.numberOfElements,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Content extends Object {

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

  @JsonKey(name: 'couponCode')
  String couponCode;

  @JsonKey(name: 'orderType')
  int orderType;

  @JsonKey(name: 'priority')
  int priority;

  @JsonKey(name: 'ip')
  String ip;

  @JsonKey(name: 'userId')
  int userId;

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

  Content(this.id,this.code,this.freight,this.originalTotalPrice,this.discountTotalPrice,this.randomReductionPrice,this.totalPrice,this.currency,this.status,this.message,this.pixelId,this.affiliate,this.scopeId,this.paymentType,this.couponCode,this.orderType,this.priority,this.ip,this.userId,this.updatedAt,this.createdAt,this.storehouseId,this.version,this.orderAddress,this.packageInfos,);

  factory Content.fromJson(Map<String, dynamic> srcJson) => _$ContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

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

  @JsonKey(name: 'delivery_id')
  int deliveryId;

  @JsonKey(name: 'delivery_code')
  String deliveryCode;

  @JsonKey(name: 'last_event')
  String lastEvent;

  @JsonKey(name: 'last_update_time')
  String lastUpdateTime;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'delivery_price')
  double deliveryPrice;

  @JsonKey(name: 'delivery_quantity')
  int deliveryQuantity;

  @JsonKey(name: 'sku_quantity')
  int skuQuantity;

  @JsonKey(name: 'sku_infos')
  List<Sku_infos> skuInfos;
  
  @JsonKey(name: 'orderCode')
  String orderCode;

  @JsonKey(name: 'userCanCancel')
  bool userCanCancel;

  @JsonKey(name: 'tracker_updated_at')
  String trackerUpdatedAt;

  PackageInfos(this.deliveryId,this.deliveryCode,this.lastEvent,this.lastUpdateTime,this.status,this.deliveryPrice,this.deliveryQuantity,this.skuQuantity,this.skuInfos,this.userCanCancel,this.orderCode,this.trackerUpdatedAt);

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

  Sku_infos(this.productSkuBarcode,this.saleServiceIn,this.quantity,this.saleServiceReject,this.discountPrice,this.productId,this.productSkuId,this.productSkuName,this.orderProductStatus,this.productImageUrl,this.saleServicePass,this.productTitle,);

  factory Sku_infos.fromJson(Map<String, dynamic> srcJson) => _$Sku_infosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Sku_infosToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
