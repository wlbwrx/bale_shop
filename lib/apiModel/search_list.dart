import 'package:json_annotation/json_annotation.dart'; 
  
part 'search_list.g.dart';


@JsonSerializable()
  class search_list extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  search_list(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory search_list.fromJson(Map<String, dynamic> srcJson) => _$search_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$search_listToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'content')
  List<Content> content;

  @JsonKey(name: 'pageable')
  Pageable pageable;

  @JsonKey(name: 'facets')
  List<dynamic> facets;

  @JsonKey(name: 'aggregations')
  String aggregations;

  @JsonKey(name: 'scrollId')
  String scrollId;

  @JsonKey(name: 'maxScore')
  String maxScore;

  @JsonKey(name: 'totalElements')
  int totalElements;

  @JsonKey(name: 'totalPages')
  int totalPages;

  @JsonKey(name: 'first')
  bool first;

  @JsonKey(name: 'sort')
  Sort sort;

  @JsonKey(name: 'numberOfElements')
  int numberOfElements;

  @JsonKey(name: 'last')
  bool last;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'number')
  int number;

  @JsonKey(name: 'empty')
  bool empty;

  Body(this.content,this.pageable,this.facets,this.aggregations,this.scrollId,this.maxScore,this.totalElements,this.totalPages,this.first,this.sort,this.numberOfElements,this.last,this.size,this.number,this.empty,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Content extends Object {

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'productImageUrl')
  String productImageUrl;

  @JsonKey(name: 'flag')
  String flag;

  @JsonKey(name: 'isNew')
  bool isNew;

  @JsonKey(name: 'maxPrice')
  double maxPrice;

  @JsonKey(name: 'minPrice')
  double minPrice;

  @JsonKey(name: 'originalPrice')
  double originalPrice;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'version')
  int version;

  Content(this.productId,this.title,this.productImageUrl,this.flag,this.isNew,this.maxPrice,this.minPrice,this.originalPrice,this.description,this.version,);

  factory Content.fromJson(Map<String, dynamic> srcJson) => _$ContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

}

  
@JsonSerializable()
  class Pageable extends Object {

  @JsonKey(name: 'sort')
  Sort sort;

  @JsonKey(name: 'pageSize')
  int pageSize;

  @JsonKey(name: 'pageNumber')
  int pageNumber;

  @JsonKey(name: 'offset')
  int offset;

  @JsonKey(name: 'paged')
  bool paged;

  @JsonKey(name: 'unpaged')
  bool unpaged;

  Pageable(this.sort,this.pageSize,this.pageNumber,this.offset,this.paged,this.unpaged,);

  factory Pageable.fromJson(Map<String, dynamic> srcJson) => _$PageableFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PageableToJson(this);

}

  
@JsonSerializable()
  class Sort extends Object {

  @JsonKey(name: 'sorted')
  bool sorted;

  @JsonKey(name: 'unsorted')
  bool unsorted;

  @JsonKey(name: 'empty')
  bool empty;

  Sort(this.sorted,this.unsorted,this.empty,);

  factory Sort.fromJson(Map<String, dynamic> srcJson) => _$SortFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SortToJson(this);

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

  
