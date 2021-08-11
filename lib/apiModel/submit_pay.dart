import 'package:json_annotation/json_annotation.dart'; 
  
part 'submit_pay.g.dart';


@JsonSerializable()
  class submit_pay extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  submit_pay(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory submit_pay.fromJson(Map<String, dynamic> srcJson) => _$submit_payFromJson(srcJson);

  Map<String, dynamic> toJson() => _$submit_payToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'code')
  String code;

  Body(this.code,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
