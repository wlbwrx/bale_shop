import 'package:json_annotation/json_annotation.dart'; 
  
part 'version.g.dart';


@JsonSerializable()
  class version extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  version(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory version.fromJson(Map<String, dynamic> srcJson) => _$versionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$versionToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'appName')
  String appName;

  @JsonKey(name: 'appVersion')
  String appVersion;

  @JsonKey(name: 'appLastVersion')
  String appLastVersion;

  @JsonKey(name: 'isMustUpdate')
  bool isMustUpdate;

  @JsonKey(name: 'isNeedUpdate')
  bool isNeedUpdate;

  Body(this.appName,this.appVersion,this.appLastVersion,this.isMustUpdate,this.isNeedUpdate,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
