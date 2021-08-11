import 'package:json_annotation/json_annotation.dart'; 
  
part 'error.g.dart';


@JsonSerializable()
  class error extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  error(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory error.fromJson(Map<String, dynamic> srcJson) => _$errorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$errorToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'timestamp')
  String timestamp;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'error')
  String error;

  @JsonKey(name: 'exception')
  String exception;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'path')
  String path;

  Body(this.timestamp,this.status,this.error,this.exception,this.message,this.path,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
