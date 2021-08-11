import 'package:json_annotation/json_annotation.dart'; 
  
part 'order_price.g.dart';


@JsonSerializable()
  class order_price extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  order_price(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory order_price.fromJson(Map<String, dynamic> srcJson) => _$order_priceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$order_priceToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'price')
  Price price;

  @JsonKey(name: 'products')
  List<Products> products;

  Body(this.price,this.products,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Price extends Object {

  @JsonKey(name: 'originalTotalPrice')
  double originalTotalPrice;

  @JsonKey(name: 'freight')
  int freight;

  @JsonKey(name: 'discountTotalCouponPrice')
  double discountTotalCouponPrice;

  @JsonKey(name: 'underlineTotalPrice')
  double underlineTotalPrice;

  @JsonKey(name: 'discountTotalPrice')
  double discountTotalPrice;

  @JsonKey(name: 'spreadPrice')
  double spreadPrice;

  Price(this.originalTotalPrice,this.freight,this.discountTotalCouponPrice,this.underlineTotalPrice,this.discountTotalPrice,this.spreadPrice,);

  factory Price.fromJson(Map<String, dynamic> srcJson) => _$PriceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PriceToJson(this);

}

  
@JsonSerializable()
  class Products extends Object {

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

  @JsonKey(name: 'isSelect')
  bool isSelect;

  @JsonKey(name: 'productPrice')
  double productPrice;

  @JsonKey(name: 'cleanStoreInventoryEnough')
  bool cleanStoreInventoryEnough;

  @JsonKey(name: 'shoppingType')
  int shoppingType;
  
  @JsonKey(name: 'isLimitProduct')
  bool isLimitProduct;

  Products(this.productId,this.productTitle,this.productSkuId,this.productSkuBarcode,this.productSkuName,this.originalPrice,this.underlinePrice,this.discountPrice,this.couponPrice,this.price,this.originalTotalPrice,this.conditionPrice,this.underlineTotalPrice,this.discountTotalPrice,this.quantity,this.productImageUrl,this.isSelect,this.productPrice,this.cleanStoreInventoryEnough,this.shoppingType,this.isLimitProduct);

  factory Products.fromJson(Map<String, dynamic> srcJson) => _$ProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);

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

  
