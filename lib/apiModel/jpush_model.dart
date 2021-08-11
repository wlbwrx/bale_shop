import 'package:json_annotation/json_annotation.dart'; 
  
part 'jpush_model.g.dart';


@JsonSerializable()
  class jpush_model extends Object {

  @JsonKey(name: 'product')
  String product;

  jpush_model(this.product,);

  factory jpush_model.fromJson(Map<String, dynamic> srcJson) => _$jpush_modelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$jpush_modelToJson(this);

}

  
