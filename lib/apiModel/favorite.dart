import 'package:json_annotation/json_annotation.dart'; 
  
part 'favorite.g.dart';


@JsonSerializable()
  class favorite extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  favorite(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory favorite.fromJson(Map<String, dynamic> srcJson) => _$favoriteFromJson(srcJson);

  Map<String, dynamic> toJson() => _$favoriteToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'productId')
  int productId;

  Body(this.id,this.updatedAt,this.createdAt,this.userId,this.productId,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
