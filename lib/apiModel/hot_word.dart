import 'package:json_annotation/json_annotation.dart'; 
  
part 'hot_word.g.dart';


@JsonSerializable()
  class hot_word extends Object {

  @JsonKey(name: 'body')
  List<Body> body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  hot_word(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory hot_word.fromJson(Map<String, dynamic> srcJson) => _$hot_wordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$hot_wordToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'keyword')
  String keyword;

  @JsonKey(name: 'isHot')
  bool isHot;

  Body(this.keyword,this.isHot,);

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

  
