import 'package:json_annotation/json_annotation.dart'; 
  
part 'login.g.dart';


@JsonSerializable()
  class login extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  login(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory login.fromJson(Map<String, dynamic> srcJson) => _$loginFromJson(srcJson);

  Map<String, dynamic> toJson() => _$loginToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'userInfo')
  UserInfo userInfo;

  @JsonKey(name: 'isNeedSync')
  bool isNeedSync;

  @JsonKey(name: 'token')
  String token;

  Body(this.userInfo,this.isNeedSync,this.token,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class UserInfo extends Object {

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

  UserInfo(this.id,this.scopeId,this.tel,this.photo,this.nickname,this.sex,this.birthday,this.country,this.province,this.city,this.district,);

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) => _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
