// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

home_banner _$home_bannerFromJson(Map<String, dynamic> json) {
  return home_banner(
    (json['body'] as List)
        ?.map(
            (e) => e == null ? null : Body.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['headers'] == null
        ? null
        : Headers.fromJson(json['headers'] as Map<String, dynamic>),
    json['statusCode'] as String,
    json['statusCodeValue'] as int,
  );
}

Map<String, dynamic> _$home_bannerToJson(home_banner instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['name'] as String,
    json['priority'] as int,
    json['scopeId'] as int,
    json['isTopNavigation'] as bool,
    json['isLeftNavigation'] as bool,
    json['parentId'] as int,
    json['thumb'] as String,
    json['isShow'] as bool,
    (json['childrens'] as List)
        ?.map((e) =>
            e == null ? null : Childrens.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['id'] as int,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'name': instance.name,
      'priority': instance.priority,
      'scopeId': instance.scopeId,
      'isTopNavigation': instance.isTopNavigation,
      'isLeftNavigation': instance.isLeftNavigation,
      'parentId': instance.parentId,
      'thumb': instance.thumb,
      'isShow': instance.isShow,
      'childrens': instance.childrens,
      'id': instance.id,
    };

Childrens _$ChildrensFromJson(Map<String, dynamic> json) {
  return Childrens(
    json['name'] as String,
    json['priority'] as int,
    json['scopeId'] as int,
    json['isTopNavigation'] as bool,
    json['isLeftNavigation'] as bool,
    json['parentId'] as int,
    json['thumb'] as String,
    json['isShow'] as bool,
    json['childrens'] as List,
    json['id'] as int,
  );
}

Map<String, dynamic> _$ChildrensToJson(Childrens instance) => <String, dynamic>{
      'name': instance.name,
      'priority': instance.priority,
      'scopeId': instance.scopeId,
      'isTopNavigation': instance.isTopNavigation,
      'isLeftNavigation': instance.isLeftNavigation,
      'parentId': instance.parentId,
      'thumb': instance.thumb,
      'isShow': instance.isShow,
      'childrens': instance.childrens,
      'id': instance.id,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers(
    (json['digest'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{
      'digest': instance.digest,
    };
