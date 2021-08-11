// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

version _$versionFromJson(Map<String, dynamic> json) {
  return version(
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

Map<String, dynamic> _$versionToJson(version instance) => <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['appName'] as String,
    json['appVersion'] as String,
    json['appLastVersion'] as String,
    json['isMustUpdate'] as bool,
    json['isNeedUpdate'] as bool,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'appName': instance.appName,
      'appVersion': instance.appVersion,
      'appLastVersion': instance.appLastVersion,
      'isMustUpdate': instance.isMustUpdate,
      'isNeedUpdate': instance.isNeedUpdate,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
