import 'package:json_annotation/json_annotation.dart'; 
  
part 'search_word.g.dart';


@JsonSerializable()
  class search_word extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  search_word(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory search_word.fromJson(Map<String, dynamic> srcJson) => _$search_wordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$search_wordToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'associateList')
  List<AssociateList> associateList;

  Body(this.associateList,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class AssociateList extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'count')
  int count;

  AssociateList(this.name,this.count,);

  factory AssociateList.fromJson(Map<String, dynamic> srcJson) => _$AssociateListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AssociateListToJson(this);

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

  
