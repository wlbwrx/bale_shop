// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sku.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

product_sku _$product_skuFromJson(Map<String, dynamic> json) {
  return product_sku(
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

Map<String, dynamic> _$product_skuToJson(product_sku instance) =>
    <String, dynamic>{
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
    json['title'] as String,
    json['description'] as String,
    json['currency'] as String,
    (json['originalPrice'] as num)?.toDouble(),
    (json['minPrice'] as num)?.toDouble(),
    (json['maxPrice'] as num)?.toDouble(),
    json['status'] as int,
    json['tags'] as String,
    json['flag'] as String,
    json['gender'] as int,
    json['saleStrategy'] as String,
    json['scopeIds'] as String,
    json['depletionStartTime'] as String,
    json['depletionEndTime'] as String,
    json['isNew'] as bool,
    json['isNewEndTime'] as String,
    (json['productAttributes'] as List)
        ?.map((e) => e == null
            ? null
            : ProductAttributes.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['productSkus'] as List)
        ?.map((e) =>
            e == null ? null : ProductSkus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'description': instance.description,
      'currency': instance.currency,
      'originalPrice': instance.originalPrice,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'status': instance.status,
      'tags': instance.tags,
      'flag': instance.flag,
      'gender': instance.gender,
      'saleStrategy': instance.saleStrategy,
      'scopeIds': instance.scopeIds,
      'depletionStartTime': instance.depletionStartTime,
      'depletionEndTime': instance.depletionEndTime,
      'isNew': instance.isNew,
      'isNewEndTime': instance.isNewEndTime,
      'productAttributes': instance.productAttributes,
      'productSkus': instance.productSkus,
    };

ProductAttributes _$ProductAttributesFromJson(Map<String, dynamic> json) {
  return ProductAttributes(
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['productId'] as int,
    json['name'] as String,
    json['priority'] as int,
    (json['productAttributeValues'] as List)
        ?.map((e) => e == null
            ? null
            : ProductAttributeValues.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductAttributesToJson(ProductAttributes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'productId': instance.productId,
      'name': instance.name,
      'priority': instance.priority,
      'productAttributeValues': instance.productAttributeValues,
    };

ProductAttributeValues _$ProductAttributeValuesFromJson(
    Map<String, dynamic> json) {
  return ProductAttributeValues(
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['value'] as String,
    json['productId'] as int,
    json['productAttributeId'] as int,
    json['priority'] as int,
    json['productAttributeImageUrl'] as String,
    json['isCheck'] as bool,
  );
}

Map<String, dynamic> _$ProductAttributeValuesToJson(
        ProductAttributeValues instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'value': instance.value,
      'productId': instance.productId,
      'productAttributeId': instance.productAttributeId,
      'priority': instance.priority,
      'productAttributeImageUrl': instance.productAttributeImageUrl,
      'isCheck': instance.isCheck,
    };

ProductSkus _$ProductSkusFromJson(Map<String, dynamic> json) {
  return ProductSkus(
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['code'] as String,
    json['name'] as String,
    json['barcode'] as String,
    (json['price'] as num)?.toDouble(),
    json['productId'] as int,
    json['productAttributeValueId1'] as int,
    json['productAttributeValueId2'] as int,
    json['inventory'] as int,
    json['depletionPrice'] as int,
    json['productAttributeValue1'] as String,
    json['productAttributeValue2'] as String,
    json['productImageUrl'] as String,
    (json['appPrice'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProductSkusToJson(ProductSkus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'code': instance.code,
      'name': instance.name,
      'barcode': instance.barcode,
      'price': instance.price,
      'productId': instance.productId,
      'productAttributeValueId1': instance.productAttributeValueId1,
      'productAttributeValueId2': instance.productAttributeValueId2,
      'inventory': instance.inventory,
      'depletionPrice': instance.depletionPrice,
      'productAttributeValue1': instance.productAttributeValue1,
      'productAttributeValue2': instance.productAttributeValue2,
      'productImageUrl': instance.productImageUrl,
      'appPrice': instance.appPrice,
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
