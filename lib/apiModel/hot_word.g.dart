// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

hot_word _$hot_wordFromJson(Map<String, dynamic> json) {
  return hot_word(
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

Map<String, dynamic> _$hot_wordToJson(hot_word instance) => <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['keyword'] as String,
    json['isHot'] as bool,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'keyword': instance.keyword,
      'isHot': instance.isHot,
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
