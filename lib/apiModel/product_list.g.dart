// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

product_list _$product_listFromJson(Map<String, dynamic> json) {
  return product_list(
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

Map<String, dynamic> _$product_listToJson(product_list instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['id'] as int,
    json['name'] as String,
    json['link'] as String,
    (json['banners'] as List)
        ?.map((e) =>
            e == null ? null : Banners.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['products'] as List)
        ?.map((e) =>
            e == null ? null : Products.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['present'] == null
        ? null
        : Present.fromJson(json['present'] as Map<String, dynamic>),
    json['priority'] as int,
    json['productCounts'] as int,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'link': instance.link,
      'banners': instance.banners,
      'products': instance.products,
      'present': instance.present,
      'priority': instance.priority,
      'productCounts': instance.productCounts,
    };

Banners _$BannersFromJson(Map<String, dynamic> json) {
  return Banners(
    json['id'] as int,
    json['imageUrl'] as String,
    json['locationUrl'] as String,
    json['appLocationUrl'] as String,
  );
}

Map<String, dynamic> _$BannersToJson(Banners instance) => <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'locationUrl': instance.locationUrl,
      'appLocationUrl': instance.appLocationUrl,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products(
    json['id'] as int,
    json['title'] as String,
    json['description'] as String,
    json['currency'] as String,
    (json['originalPrice'] as num)?.toDouble(),
    (json['minPrice'] as num)?.toDouble(),
    (json['maxPrice'] as num)?.toDouble(),
    json['tags'] as String,
    json['flag'] as String,
    json['depletionStartTime'] as String,
    json['depletionEndTime'] as String,
    json['isNew'] as bool,
    json['productImageUrl'] as String,
  );
}

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'currency': instance.currency,
      'originalPrice': instance.originalPrice,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'tags': instance.tags,
      'flag': instance.flag,
      'depletionStartTime': instance.depletionStartTime,
      'depletionEndTime': instance.depletionEndTime,
      'isNew': instance.isNew,
      'productImageUrl': instance.productImageUrl,
    };

Present _$PresentFromJson(Map<String, dynamic> json) {
  return Present(
    json['css'] as String,
    json['js'] as String,
    json['html'] as String,
  );
}

Map<String, dynamic> _$PresentToJson(Present instance) => <String, dynamic>{
      'css': instance.css,
      'js': instance.js,
      'html': instance.html,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers(
    (json['digest'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{
      'digest': instance.digest,
    };
