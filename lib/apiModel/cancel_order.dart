import 'package:json_annotation/json_annotation.dart'; 
  
part 'cancel_order.g.dart';


@JsonSerializable()
  class cancel_order extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  cancel_order(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory cancel_order.fromJson(Map<String, dynamic> srcJson) => _$cancel_orderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$cancel_orderToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'cancelProductCount')
  int cancelProductCount;

  @JsonKey(name: 'orderCode')
  String orderCode;

  Body(this.cancelProductCount,this.orderCode,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

