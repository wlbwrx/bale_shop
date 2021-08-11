import 'package:json_annotation/json_annotation.dart'; 
  
part 'saleservice_list.g.dart';


@JsonSerializable()
  class saleservice_list extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  saleservice_list(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory saleservice_list.fromJson(Map<String, dynamic> srcJson) => _$saleservice_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$saleservice_listToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'content')
  List<Content> content;

  @JsonKey(name: 'totalElements')
  int totalElements;

  @JsonKey(name: 'last')
  bool last;

  @JsonKey(name: 'totalPages')
  int totalPages;

  @JsonKey(name: 'number')
  int number;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'sort')
  List<Sort> sort;

  @JsonKey(name: 'first')
  bool first;

  @JsonKey(name: 'numberOfElements')
  int numberOfElements;

  Body(this.content,this.totalElements,this.last,this.totalPages,this.number,this.size,this.sort,this.first,this.numberOfElements,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Content extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'orderCode')
  String orderCode;

  @JsonKey(name: 'deliveryCode')
  String deliveryCode;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'handleStatus')
  int handleStatus;

  @JsonKey(name: 'serviceType')
  int serviceType;

  @JsonKey(name: 'afterSaleServiceProducts')
  List<AfterSaleServiceProducts> afterSaleServiceProducts;

  Content(this.id,this.orderCode,this.deliveryCode,this.createdAt,this.handleStatus,this.serviceType,this.afterSaleServiceProducts);

  factory Content.fromJson(Map<String, dynamic> srcJson) => _$ContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

}

  
@JsonSerializable()
  class AfterSaleServiceProducts extends Object {

  @JsonKey(name: 'saleServiceId')
  int saleServiceId;

  @JsonKey(name: 'sourceProductSkuId')
  int sourceProductSkuId;

  @JsonKey(name: 'sourceProductSkuBarcode')
  String sourceProductSkuBarcode;

  @JsonKey(name: 'quantity')
  int quantity;

  @JsonKey(name: 'sourceProductSkuImage')
  String sourceProductSkuImage;

  AfterSaleServiceProducts(this.saleServiceId,this.sourceProductSkuId,this.sourceProductSkuBarcode,this.quantity,this.sourceProductSkuImage,);

  factory AfterSaleServiceProducts.fromJson(Map<String, dynamic> srcJson) => _$AfterSaleServiceProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AfterSaleServiceProductsToJson(this);

}

  
@JsonSerializable()
  class Sort extends Object {

  @JsonKey(name: 'direction')
  String direction;

  @JsonKey(name: 'property')
  String property;

  @JsonKey(name: 'ignoreCase')
  bool ignoreCase;

  @JsonKey(name: 'nullHandling')
  String nullHandling;

  @JsonKey(name: 'ascending')
  bool ascending;

  @JsonKey(name: 'descending')
  bool descending;

  Sort(this.direction,this.property,this.ignoreCase,this.nullHandling,this.ascending,this.descending,);

  factory Sort.fromJson(Map<String, dynamic> srcJson) => _$SortFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SortToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
