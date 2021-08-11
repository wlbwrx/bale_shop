// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

product_detail _$product_detailFromJson(Map<String, dynamic> json) {
  return product_detail(
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

Map<String, dynamic> _$product_detailToJson(product_detail instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    (json['aggregateModules'] as List)
        ?.map((e) => e == null
            ? null
            : AggregateModules.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['similarProducts'] as List)
        ?.map((e) => e == null
            ? null
            : SimilarProducts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['productComments'] as List,
    json['productDetail'] == null
        ? null
        : ProductDetail.fromJson(json['productDetail'] as Map<String, dynamic>),
    json['isfavorite'] as bool,
    json['isLimitProduct'] as bool,
    (json['categories'] as List)?.map((e) => e as String)?.toList(),
    (json['recommendProducts'] as List)
        ?.map((e) => e == null
            ? null
            : RecommendProducts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'product': instance.product,
      'aggregateModules': instance.aggregateModules,
      'similarProducts': instance.similarProducts,
      'productComments': instance.productComments,
      'productDetail': instance.productDetail,
      'isfavorite': instance.isfavorite,
      'isLimitProduct': instance.isLimitProduct,
      'categories': instance.categories,
      'recommendProducts': instance.recommendProducts,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
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
    json['depletionStartTime'] as String,
    json['depletionEndTime'] as String,
    json['isNew'] as bool,
    json['isNewEndTime'] as String,
    json['productImageUrl'] as String,
    json['bannerImageUrl'] as String,
    (json['productAttributes'] as List)
        ?.map((e) => e == null
            ? null
            : ProductAttributes.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['productSkus'] as List)
        ?.map((e) =>
            e == null ? null : ProductSkus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['productCarouselImages'] as List)?.map((e) => e as String)?.toList(),
    json['productComments'] as List,
    json['isLimitProduct'] as bool,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
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
      'depletionStartTime': instance.depletionStartTime,
      'depletionEndTime': instance.depletionEndTime,
      'isNew': instance.isNew,
      'isNewEndTime': instance.isNewEndTime,
      'productImageUrl': instance.productImageUrl,
      'bannerImageUrl': instance.bannerImageUrl,
      'productAttributes': instance.productAttributes,
      'productSkus': instance.productSkus,
      'productCarouselImages': instance.productCarouselImages,
      'productComments': instance.productComments,
      'isLimitProduct': instance.isLimitProduct,
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
    (json['appPrice'] as num)?.toDouble(),
    json['productId'] as int,
    json['productAttributeValueId1'] as int,
    json['productAttributeValueId2'] as int,
    json['inventory'] as int,
    (json['depletionPrice'] as num)?.toDouble(),
    json['productAttributeValue1'] as String,
    json['productAttributeValue2'] as String,
    json['productImageUrl'] as String,
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
      'appPrice': instance.appPrice,
      'productId': instance.productId,
      'productAttributeValueId1': instance.productAttributeValueId1,
      'productAttributeValueId2': instance.productAttributeValueId2,
      'inventory': instance.inventory,
      'depletionPrice': instance.depletionPrice,
      'productAttributeValue1': instance.productAttributeValue1,
      'productAttributeValue2': instance.productAttributeValue2,
      'productImageUrl': instance.productImageUrl,
    };

AggregateModules _$AggregateModulesFromJson(Map<String, dynamic> json) {
  return AggregateModules(
    json['name'] as String,
    json['priority'] as int,
    json['scopeId'] as int,
    json['isTopNavigation'] as bool,
    json['isLeftNavigation'] as bool,
    json['parentId'] as int,
    json['thumb'] as String,
    json['isShow'] as bool,
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
  );
}

Map<String, dynamic> _$AggregateModulesToJson(AggregateModules instance) =>
    <String, dynamic>{
      'name': instance.name,
      'priority': instance.priority,
      'scopeId': instance.scopeId,
      'isTopNavigation': instance.isTopNavigation,
      'isLeftNavigation': instance.isLeftNavigation,
      'parentId': instance.parentId,
      'thumb': instance.thumb,
      'isShow': instance.isShow,
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };

SimilarProducts _$SimilarProductsFromJson(Map<String, dynamic> json) {
  return SimilarProducts(
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

Map<String, dynamic> _$SimilarProductsToJson(SimilarProducts instance) =>
    <String, dynamic>{
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

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) {
  return ProductDetail(
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['productId'] as int,
    json['productParams'] as String,
    json['productDetails'] as String,
  );
}

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'productId': instance.productId,
      'productParams': instance.productParams,
      'productDetails': instance.productDetails,
    };

RecommendProducts _$RecommendProductsFromJson(Map<String, dynamic> json) {
  return RecommendProducts(
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

Map<String, dynamic> _$RecommendProductsToJson(RecommendProducts instance) =>
    <String, dynamic>{
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

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
