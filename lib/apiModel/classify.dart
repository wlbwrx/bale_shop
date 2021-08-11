import 'package:json_annotation/json_annotation.dart'; 
  
part 'classify.g.dart';


@JsonSerializable()
  class classify extends Object {

  @JsonKey(name: 'body')
  List<Body> body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  classify(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory classify.fromJson(Map<String, dynamic> srcJson) => _$classifyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$classifyToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'originalPrice')
  double originalPrice;

  @JsonKey(name: 'minPrice')
  double minPrice;

  @JsonKey(name: 'maxPrice')
  double maxPrice;

  @JsonKey(name: 'tags')
  String tags;

  @JsonKey(name: 'flag')
  String flag;

  @JsonKey(name: 'depletionStartTime')
  String depletionStartTime;

  @JsonKey(name: 'depletionEndTime')
  String depletionEndTime;

  @JsonKey(name: 'isNew')
  bool isNew;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  @JsonKey(name: 'salesVolume')
  int salesVolume;

  Body(this.id,this.title,this.description,this.currency,this.originalPrice,this.minPrice,this.maxPrice,this.tags,this.flag,this.depletionStartTime,this.depletionEndTime,this.isNew,this.productImageUrl,this.salesVolume,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
