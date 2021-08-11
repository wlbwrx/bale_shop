// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_recommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

cart_recommend _$cart_recommendFromJson(Map<String, dynamic> json) {
  return cart_recommend(
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

Map<String, dynamic> _$cart_recommendToJson(cart_recommend instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String,
    json['flag'] as String,
    json['tags'] as String,
    (json['minPrice'] as num)?.toDouble(),
    (json['maxPrice'] as num)?.toDouble(),
    (json['originalPrice'] as num)?.toDouble(),
    json['productImageUrl'] as String,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'flag': instance.flag,
      'tags': instance.tags,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'originalPrice': instance.originalPrice,
      'productImageUrl': instance.productImageUrl,
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
