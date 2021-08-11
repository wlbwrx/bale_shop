import 'package:json_annotation/json_annotation.dart'; 
  
part 'submit.g.dart';


@JsonSerializable()
  class submit extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  submit(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory submit.fromJson(Map<String, dynamic> srcJson) => _$submitFromJson(srcJson);

  Map<String, dynamic> toJson() => _$submitToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'freight')
  int freight;

  @JsonKey(name: 'originalTotalPrice')
  double originalTotalPrice;

  @JsonKey(name: 'discountTotalPrice')
  double discountTotalPrice;

  @JsonKey(name: 'discountTotalCouponPrice')
  double discountTotalCouponPrice;

  @JsonKey(name: 'randomReductionPrice')
  double randomReductionPrice;

  @JsonKey(name: 'totalPrice')
  double totalPrice;

  @JsonKey(name: 'underlineTotalPrice')
  double underlineTotalPrice;

  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'pixelId')
  String pixelId;

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

  @JsonKey(name: 'mergeType')
  int mergeType;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'version')
  int version;

  @JsonKey(name: 'orderProducts')
  List<OrderProducts> orderProducts;

  @JsonKey(name: 'orderAddress')
  OrderAddress orderAddress;

  Body(this.id,this.code,this.freight,this.originalTotalPrice,this.discountTotalPrice,this.discountTotalCouponPrice,this.randomReductionPrice,this.totalPrice,this.underlineTotalPrice,this.currency,this.status,this.message,this.remark,this.pixelId,this.scopeId,this.paymentType,this.couponCode,this.orderType,this.priority,this.ip,this.mergeType,this.updatedAt,this.createdAt,this.version,this.orderProducts,this.orderAddress,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class OrderProducts extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'orderId')
  int orderId;

  @JsonKey(name: 'orderCode')
  String orderCode;

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

  @JsonKey(name: 'originalPrice')
  double originalPrice;

  @JsonKey(name: 'underlinePrice')
  double underlinePrice;

  @JsonKey(name: 'discountPrice')
  double discountPrice;

  @JsonKey(name: 'couponPrice')
  double couponPrice;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'originalTotalPrice')
  double originalTotalPrice;

  @JsonKey(name: 'conditionPrice')
  double conditionPrice;

  @JsonKey(name: 'underlineTotalPrice')
  double underlineTotalPrice;

  @JsonKey(name: 'discountTotalPrice')
  double discountTotalPrice;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'isSelect')
  bool isSelect;

  @JsonKey(name: 'productPrice')
  double productPrice;

  @JsonKey(name: 'cleanStoreInventoryEnough')
  bool cleanStoreInventoryEnough;

  @JsonKey(name: 'shoppingType')
  int shoppingType;

  OrderProducts(this.id,this.updatedAt,this.createdAt,this.orderId,this.orderCode,this.productId,this.productTitle,this.productSkuId,this.productSkuBarcode,this.productSkuName,this.originalPrice,this.underlinePrice,this.discountPrice,this.couponPrice,this.price,this.originalTotalPrice,this.conditionPrice,this.underlineTotalPrice,this.discountTotalPrice,this.quantity,this.productImageUrl,this.status,this.isSelect,this.productPrice,this.cleanStoreInventoryEnough,this.shoppingType,);

  factory OrderProducts.fromJson(Map<String, dynamic> srcJson) => _$OrderProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderProductsToJson(this);

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
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
