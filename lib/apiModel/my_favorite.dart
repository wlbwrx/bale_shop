import 'package:json_annotation/json_annotation.dart'; 
  
part 'my_favorite.g.dart';


@JsonSerializable()
  class my_favorite extends Object {

  @JsonKey(name: 'body')
  List<Body> body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  my_favorite(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory my_favorite.fromJson(Map<String, dynamic> srcJson) => _$my_favoriteFromJson(srcJson);

  Map<String, dynamic> toJson() => _$my_favoriteToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'originalPrice')
  double originalPrice;

  @JsonKey(name: 'minPrice')
  double minPrice;

  @JsonKey(name: 'tags')
  String tags;

  @JsonKey(name: 'flag')
  String flag;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  Body(this.id,this.title,this.description,this.originalPrice,this.minPrice,this.tags,this.flag,this.productImageUrl,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
