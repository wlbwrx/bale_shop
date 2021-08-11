// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_pay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

submit_pay _$submit_payFromJson(Map<String, dynamic> json) {
  return submit_pay(
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

Map<String, dynamic> _$submit_payToJson(submit_pay instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['code'] as String,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'code': instance.code,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
