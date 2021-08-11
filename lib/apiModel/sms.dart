import 'package:json_annotation/json_annotation.dart'; 
  
part 'sms.g.dart';


@JsonSerializable()
  class sms extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  sms(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory sms.fromJson(Map<String, dynamic> srcJson) => _$smsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$smsToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'msg')
  String msg;

  Body(this.msg,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
