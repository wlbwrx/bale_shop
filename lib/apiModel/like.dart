import 'package:json_annotation/json_annotation.dart'; 
  
part 'like.g.dart';


@JsonSerializable()
  class like extends Object {

  @JsonKey(name: 'body')
  List<Body> body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  like(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory like.fromJson(Map<String, dynamic> srcJson) => _$likeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$likeToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'title')
  String flag;

  @JsonKey(name: 'min_price')
  double minPrice;

  @JsonKey(name: 'max_price')
  double maxPrice;

  @JsonKey(name: 'original_price')
  double originalPrice;

  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'product_sku_img')
  String productSkuImg;

  Body(this.id,this.title,this.flag,this.minPrice,this.maxPrice,this.originalPrice,this.currency,this.productSkuImg,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
