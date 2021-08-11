// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

my_favorite _$my_favoriteFromJson(Map<String, dynamic> json) {
  return my_favorite(
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

Map<String, dynamic> _$my_favoriteToJson(my_favorite instance) =>
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
    (json['originalPrice'] as num)?.toDouble(),
    (json['minPrice'] as num)?.toDouble(),
    json['tags'] as String,
    json['flag'] as String,
    json['productImageUrl'] as String,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'originalPrice': instance.originalPrice,
      'minPrice': instance.minPrice,
      'tags': instance.tags,
      'flag': instance.flag,
      'productImageUrl': instance.productImageUrl,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
