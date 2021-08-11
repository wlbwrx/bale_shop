import 'package:json_annotation/json_annotation.dart'; 
  
part 'order_price_a.g.dart';


@JsonSerializable()
  class order_price_a extends Object {

  @JsonKey(name: 'statusCodeValue')
  String statusCodeValue;

  @JsonKey(name: 'body')
  String body;

  order_price_a(this.statusCodeValue,this.body,);

  factory order_price_a.fromJson(Map<String, dynamic> srcJson) => _$order_price_aFromJson(srcJson);

  Map<String, dynamic> toJson() => _$order_price_aToJson(this);

}

  
