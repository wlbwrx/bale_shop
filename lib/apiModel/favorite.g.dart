// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

favorite _$favoriteFromJson(Map<String, dynamic> json) {
  return favorite(
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

Map<String, dynamic> _$favoriteToJson(favorite instance) => <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['userId'] as int,
    json['productId'] as int,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'userId': instance.userId,
      'productId': instance.productId,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
