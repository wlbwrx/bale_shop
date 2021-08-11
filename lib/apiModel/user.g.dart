// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

user _$userFromJson(Map<String, dynamic> json) {
  return user(
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

Map<String, dynamic> _$userToJson(user instance) => <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['id'] as int,
    json['scopeId'] as int,
    json['tel'] as String,
    json['photo'] as String,
    json['nickname'] as String,
    json['sex'] as String,
    json['birthday'] as String,
    json['country'] as String,
    json['province'] as String,
    json['city'] as String,
    json['district'] as String,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'id': instance.id,
      'scopeId': instance.scopeId,
      'tel': instance.tel,
      'photo': instance.photo,
      'nickname': instance.nickname,
      'sex': instance.sex,
      'birthday': instance.birthday,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
