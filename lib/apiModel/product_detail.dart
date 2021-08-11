import 'package:json_annotation/json_annotation.dart'; 
  
part 'product_detail.g.dart';


@JsonSerializable()
  class product_detail extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  product_detail(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory product_detail.fromJson(Map<String, dynamic> srcJson) => _$product_detailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$product_detailToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'product')
  Product product;

  @JsonKey(name: 'aggregateModules')
  List<AggregateModules> aggregateModules;

  @JsonKey(name: 'similarProducts')
  List<SimilarProducts> similarProducts;

  @JsonKey(name: 'productComments')
  List<dynamic> productComments;

  @JsonKey(name: 'productDetail')
  ProductDetail productDetail;

  @JsonKey(name: 'isfavorite')
  bool isfavorite;

  @JsonKey(name: 'isLimitProduct')
  bool isLimitProduct; 

  @JsonKey(name: 'categories')
  List<String> categories;

  @JsonKey(name: 'recommendProducts')
  List<RecommendProducts> recommendProducts;

  Body(this.product,this.aggregateModules,this.similarProducts,this.productComments,this.productDetail,this.isfavorite,this.isLimitProduct,this.categories,this.recommendProducts,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Product extends Object {

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

  @JsonKey(name: 'depletionStartTime')
  String depletionStartTime;

  @JsonKey(name: 'depletionEndTime')
  String depletionEndTime;

  @JsonKey(name: 'isNew')
  bool isNew;

  @JsonKey(name: 'isNewEndTime')
  String isNewEndTime;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  @JsonKey(name: 'bannerImageUrl')
  String bannerImageUrl;

  @JsonKey(name: 'productAttributes')
  List<ProductAttributes> productAttributes;

  @JsonKey(name: 'productSkus')
  List<ProductSkus> productSkus;

  @JsonKey(name: 'productCarouselImages')
  List<String> productCarouselImages;

  @JsonKey(name: 'productComments')
  List<dynamic> productComments;

  @JsonKey(name: 'isLimitProduct')
  bool isLimitProduct; 

  Product(this.id,this.updatedAt,this.createdAt,this.title,this.description,this.currency,this.originalPrice,this.minPrice,this.maxPrice,this.status,this.tags,this.flag,this.gender,this.depletionStartTime,this.depletionEndTime,this.isNew,this.isNewEndTime,this.productImageUrl,this.bannerImageUrl,this.productAttributes,this.productSkus,this.productCarouselImages,this.productComments,this.isLimitProduct);

  factory Product.fromJson(Map<String, dynamic> srcJson) => _$ProductFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

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

  @JsonKey(name: 'appPrice')
  double appPrice;


  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'productAttributeValueId1')
  int productAttributeValueId1;

  @JsonKey(name: 'productAttributeValueId2')
  int productAttributeValueId2;

  @JsonKey(name: 'inventory')
  int inventory;

  @JsonKey(name: 'depletionPrice')
  double depletionPrice;

  @JsonKey(name: 'productAttributeValue1')
  String productAttributeValue1;

  @JsonKey(name: 'productAttributeValue2')
  String productAttributeValue2;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  ProductSkus(this.id,this.updatedAt,this.createdAt,this.code,this.name,this.barcode,this.price,this.appPrice,this.productId,this.productAttributeValueId1,this.productAttributeValueId2,this.inventory,this.depletionPrice,this.productAttributeValue1,this.productAttributeValue2,this.productImageUrl,);

  factory ProductSkus.fromJson(Map<String, dynamic> srcJson) => _$ProductSkusFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductSkusToJson(this);

}

  
@JsonSerializable()
  class AggregateModules extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'priority')
  int priority;

  @JsonKey(name: 'scopeId')
  int scopeId;

  @JsonKey(name: 'isTopNavigation')
  bool isTopNavigation;

  @JsonKey(name: 'isLeftNavigation')
  bool isLeftNavigation;

  @JsonKey(name: 'parentId')
  int parentId;

  @JsonKey(name: 'thumb')
  String thumb;

  @JsonKey(name: 'isShow')
  bool isShow;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  AggregateModules(this.name,this.priority,this.scopeId,this.isTopNavigation,this.isLeftNavigation,this.parentId,this.thumb,this.isShow,this.id,this.updatedAt,this.createdAt,);

  factory AggregateModules.fromJson(Map<String, dynamic> srcJson) => _$AggregateModulesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AggregateModulesToJson(this);

}

  
@JsonSerializable()
  class SimilarProducts extends Object {

  @JsonKey(name: 'id')
  int id;

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

  @JsonKey(name: 'tags')
  String tags;

  @JsonKey(name: 'flag')
  String flag;

  @JsonKey(name: 'depletionStartTime')
  String depletionStartTime;

  @JsonKey(name: 'depletionEndTime')
  String depletionEndTime;

  @JsonKey(name: 'isNew')
  bool isNew;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  SimilarProducts(this.id,this.title,this.description,this.currency,this.originalPrice,this.minPrice,this.maxPrice,this.tags,this.flag,this.depletionStartTime,this.depletionEndTime,this.isNew,this.productImageUrl,);

  factory SimilarProducts.fromJson(Map<String, dynamic> srcJson) => _$SimilarProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SimilarProductsToJson(this);

}

  
@JsonSerializable()
  class ProductDetail extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'productParams')
  String productParams;

  @JsonKey(name: 'productDetails')
  String productDetails;

  ProductDetail(this.id,this.updatedAt,this.createdAt,this.productId,this.productParams,this.productDetails,);

  factory ProductDetail.fromJson(Map<String, dynamic> srcJson) => _$ProductDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);

}

  
@JsonSerializable()
  class RecommendProducts extends Object {

  @JsonKey(name: 'id')
  int id;

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

  @JsonKey(name: 'tags')
  String tags;

  @JsonKey(name: 'flag')
  String flag;

  @JsonKey(name: 'depletionStartTime')
  String depletionStartTime;

  @JsonKey(name: 'depletionEndTime')
  String depletionEndTime;

  @JsonKey(name: 'isNew')
  bool isNew;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  RecommendProducts(this.id,this.title,this.description,this.currency,this.originalPrice,this.minPrice,this.maxPrice,this.tags,this.flag,this.depletionStartTime,this.depletionEndTime,this.isNew,this.productImageUrl,);

  factory RecommendProducts.fromJson(Map<String, dynamic> srcJson) => _$RecommendProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendProductsToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
