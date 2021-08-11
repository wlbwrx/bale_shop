import 'package:json_annotation/json_annotation.dart'; 
  
part 'product_sku.g.dart';


@JsonSerializable()
  class product_sku extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  product_sku(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory product_sku.fromJson(Map<String, dynamic> srcJson) => _$product_skuFromJson(srcJson);

  Map<String, dynamic> toJson() => _$product_skuToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'originalPrice')
  double originalPrice;

  @JsonKey(name: 'minPrice')
  double minPrice;

  @JsonKey(name: 'maxPrice')
  double maxPrice;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'tags')
  String tags;

  @JsonKey(name: 'flag')
  String flag;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'saleStrategy')
  String saleStrategy;

  @JsonKey(name: 'scopeIds')
  String scopeIds;

  @JsonKey(name: 'depletionStartTime')
  String depletionStartTime;

  @JsonKey(name: 'depletionEndTime')
  String depletionEndTime;

  @JsonKey(name: 'isNew')
  bool isNew;

  @JsonKey(name: 'isNewEndTime')
  String isNewEndTime;

  @JsonKey(name: 'productAttributes')
  List<ProductAttributes> productAttributes;

  @JsonKey(name: 'productSkus')
  List<ProductSkus> productSkus;

  Body(this.id,this.updatedAt,this.createdAt,this.title,this.description,this.currency,this.originalPrice,this.minPrice,this.maxPrice,this.status,this.tags,this.flag,this.gender,this.saleStrategy,this.scopeIds,this.depletionStartTime,this.depletionEndTime,this.isNew,this.isNewEndTime,this.productAttributes,this.productSkus,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class ProductAttributes extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'priority')
  int priority;

  @JsonKey(name: 'productAttributeValues')
  List<ProductAttributeValues> productAttributeValues;

  ProductAttributes(this.id,this.updatedAt,this.createdAt,this.productId,this.name,this.priority,this.productAttributeValues,);

  factory ProductAttributes.fromJson(Map<String, dynamic> srcJson) => _$ProductAttributesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductAttributesToJson(this);

}

  
@JsonSerializable()
  class ProductAttributeValues extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'value')
  String value;

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'productAttributeId')
  int productAttributeId;

  @JsonKey(name: 'priority')
  int priority;

  @JsonKey(name: 'productAttributeImageUrl')
  String productAttributeImageUrl;

  @JsonKey(name: 'isCheck')
  bool isCheck;
  

  ProductAttributeValues(this.id,this.updatedAt,this.createdAt,this.value,this.productId,this.productAttributeId,this.priority,this.productAttributeImageUrl,this.isCheck);

  factory ProductAttributeValues.fromJson(Map<String, dynamic> srcJson) => _$ProductAttributeValuesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductAttributeValuesToJson(this);

}

  
@JsonSerializable()
  class ProductSkus extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'barcode')
  String barcode;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'productAttributeValueId1')
  int productAttributeValueId1;

  @JsonKey(name: 'productAttributeValueId2')
  int productAttributeValueId2;

  @JsonKey(name: 'inventory')
  int inventory;

  @JsonKey(name: 'depletionPrice')
  int depletionPrice;

  @JsonKey(name: 'productAttributeValue1')
  String productAttributeValue1;

  @JsonKey(name: 'productAttributeValue2')
  String productAttributeValue2;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  @JsonKey(name: 'appPrice')
  double appPrice;

  ProductSkus(this.id,this.updatedAt,this.createdAt,this.code,this.name,this.barcode,this.price,this.productId,this.productAttributeValueId1,this.productAttributeValueId2,this.inventory,this.depletionPrice,this.productAttributeValue1,this.productAttributeValue2,this.productImageUrl,this.appPrice);

  factory ProductSkus.fromJson(Map<String, dynamic> srcJson) => _$ProductSkusFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductSkusToJson(this);

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

  
