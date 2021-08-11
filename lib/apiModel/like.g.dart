// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

like _$likeFromJson(Map<String, dynamic> json) {
  return like(
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

Map<String, dynamic> _$likeToJson(like instance) => <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['id'] as int,
    json['title'] as String,
    json['flag'] as String,
    (json['min_price'] as num)?.toDouble(),
    (json['max_price'] as num)?.toDouble(),
    (json['original_price'] as num)?.toDouble(),
    json['currency'] as String,
    json['product_sku_img'] as String,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'flag': instance.flag,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'original_price': instance.originalPrice,
      'currency': instance.currency,
      'product_sku_img': instance.productSkuImg,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
