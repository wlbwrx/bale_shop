import 'package:json_annotation/json_annotation.dart'; 
  
part 'home_model.g.dart';


@JsonSerializable()
  class home_model extends Object {

  @JsonKey(name: 'body')
  List<Body> body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  home_model(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory home_model.fromJson(Map<String, dynamic> srcJson) => _$home_modelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$home_modelToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'aggregate_module_id')
  int aggregateModuleId;

  @JsonKey(name: 'product_count')
  int productCount;

  Body(this.type,this.aggregateModuleId,this.productCount);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  @JsonKey(name: 'digest')
  List<String> digest;

  Headers(this.digest,);

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
