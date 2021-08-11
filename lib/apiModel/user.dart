import 'package:json_annotation/json_annotation.dart'; 
  
part 'user.g.dart';


@JsonSerializable()
  class user extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  user(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory user.fromJson(Map<String, dynamic> srcJson) => _$userFromJson(srcJson);

  Map<String, dynamic> toJson() => _$userToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'scopeId')
  int scopeId;

  @JsonKey(name: 'tel')
  String tel;

  @JsonKey(name: 'photo')
  String photo;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'sex')
  String sex;

  @JsonKey(name: 'birthday')
  String birthday;

  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'province')
  String province;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'district')
  String district;

  Body(this.id,this.scopeId,this.tel,this.photo,this.nickname,this.sex,this.birthday,this.country,this.province,this.city,this.district,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
