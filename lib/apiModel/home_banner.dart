import 'package:json_annotation/json_annotation.dart'; 
  
part 'home_banner.g.dart';


@JsonSerializable()
  class home_banner extends Object {

  @JsonKey(name: 'body')
  List<Body> body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  home_banner(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory home_banner.fromJson(Map<String, dynamic> srcJson) => _$home_bannerFromJson(srcJson);

  Map<String, dynamic> toJson() => _$home_bannerToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'priority')
  int priority;

  @JsonKey(name: 'scopeId')
  int scopeId;

  @JsonKey(name: 'isTopNavigation')
  bool isTopNavigation;

  @JsonKey(name: 'isLeftNavigation')
  bool isLeftNavigation;

  @JsonKey(name: 'parentId')
  int parentId;

  @JsonKey(name: 'thumb')
  String thumb;

  @JsonKey(name: 'isShow')
  bool isShow;

  @JsonKey(name: 'childrens')
  List<Childrens> childrens;

  @JsonKey(name: 'id')
  int id;

  Body(this.name,this.priority,this.scopeId,this.isTopNavigation,this.isLeftNavigation,this.parentId,this.thumb,this.isShow,this.childrens,this.id,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class Childrens extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'priority')
  int priority;

  @JsonKey(name: 'scopeId')
  int scopeId;

  @JsonKey(name: 'isTopNavigation')
  bool isTopNavigation;

  @JsonKey(name: 'isLeftNavigation')
  bool isLeftNavigation;

  @JsonKey(name: 'parentId')
  int parentId;

  @JsonKey(name: 'thumb')
  String thumb;

  @JsonKey(name: 'isShow')
  bool isShow;

  @JsonKey(name: 'childrens')
  List<dynamic> childrens;

  @JsonKey(name: 'id')
  int id;

  Childrens(this.name,this.priority,this.scopeId,this.isTopNavigation,this.isLeftNavigation,this.parentId,this.thumb,this.isShow,this.childrens,this.id,);

  factory Childrens.fromJson(Map<String, dynamic> srcJson) => _$ChildrensFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChildrensToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  @JsonKey(name: 'digest')
  List<String> digest;

  Headers(this.digest,);

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}


  
