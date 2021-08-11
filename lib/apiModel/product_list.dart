import 'package:json_annotation/json_annotation.dart'; 
  
part 'product_list.g.dart';


@JsonSerializable()
  class product_list extends Object {

  @JsonKey(name: 'body')
  List<Body> body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  product_list(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory product_list.fromJson(Map<String, dynamic> srcJson) => _$product_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$product_listToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'banners')
  List<Banners> banners;

  @JsonKey(name: 'products')
  List<Products> products;

  @JsonKey(name: 'present')
  Present present;

  @JsonKey(name: 'priority')
  int priority;

  @JsonKey(name: 'productCounts')
  int productCounts;

  Body(this.id,this.name,this.link,this.banners,this.products,this.present,this.priority,this.productCounts,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Banners extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'imageUrl')
  String imageUrl;

  @JsonKey(name: 'locationUrl')
  String locationUrl;

  @JsonKey(name: 'appLocationUrl')
  String appLocationUrl;

  Banners(this.id,this.imageUrl,this.locationUrl,this.appLocationUrl);

  factory Banners.fromJson(Map<String, dynamic> srcJson) => _$BannersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannersToJson(this);

}

  
@JsonSerializable()
  class Products extends Object {

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

  Products(this.id,this.title,this.description,this.currency,this.originalPrice,this.minPrice,this.maxPrice,this.tags,this.flag,this.depletionStartTime,this.depletionEndTime,this.isNew,this.productImageUrl,);

  factory Products.fromJson(Map<String, dynamic> srcJson) => _$ProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);

}

  
@JsonSerializable()
  class Present extends Object {

  @JsonKey(name: 'css')
  String css;

  @JsonKey(name: 'js')
  String js;

  @JsonKey(name: 'html')
  String html;

  Present(this.css,this.js,this.html,);

  factory Present.fromJson(Map<String, dynamic> srcJson) => _$PresentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PresentToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  @JsonKey(name: 'digest')
  List<String> digest;

  Headers(this.digest,);

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
