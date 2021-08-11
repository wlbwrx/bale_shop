// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

classify _$classifyFromJson(Map<String, dynamic> json) {
  return classify(
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

Map<String, dynamic> _$classifyToJson(classify instance) => <String, dynamic>{
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
    json['salesVolume'] as int,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
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
      'salesVolume': instance.salesVolume,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
