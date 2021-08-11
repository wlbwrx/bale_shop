import 'package:json_annotation/json_annotation.dart'; 
  
part 'cart_recommend.g.dart';


@JsonSerializable()
  class cart_recommend extends Object {

  @JsonKey(name: 'body')
  List<Body> body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  cart_recommend(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory cart_recommend.fromJson(Map<String, dynamic> srcJson) => _$cart_recommendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$cart_recommendToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'flag')
  String flag;

  @JsonKey(name: 'tags')
  String tags;

  @JsonKey(name: 'minPrice')
  double minPrice;

  @JsonKey(name: 'maxPrice')
  double maxPrice;

  @JsonKey(name: 'originalPrice')
  double originalPrice;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  Body(this.id,this.title,this.description,this.flag,this.tags,this.minPrice,this.maxPrice,this.originalPrice,this.productImageUrl,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

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

  
