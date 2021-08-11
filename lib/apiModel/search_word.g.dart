// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

search_word _$search_wordFromJson(Map<String, dynamic> json) {
  return search_word(
    json['body'] == null
        ? null
        : Body.fromJson(json['body'] as Map<String, dynamic>),
    json['headers'] == null
        ? null
        : Headers.fromJson(json['headers'] as Map<String, dynamic>),
    json['statusCode'] as String,
    json['statusCodeValue'] as int,
  );
}

Map<String, dynamic> _$search_wordToJson(search_word instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    (json['associateList'] as List)
        ?.map((e) => e == null
            ? null
            : AssociateList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'associateList': instance.associateList,
    };

AssociateList _$AssociateListFromJson(Map<String, dynamic> json) {
  return AssociateList(
    json['name'] as String,
    json['count'] as int,
  );
}

Map<String, dynamic> _$AssociateListToJson(AssociateList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers(
    (json['requestTime'] as List)?.map((e) => e as String)?.toList(),
    (json['responseTime'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{
      'requestTime': instance.requestTime,
      'responseTime': instance.responseTime,
    };
