// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saleservice_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

saleservice_list _$saleservice_listFromJson(Map<String, dynamic> json) {
  return saleservice_list(
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

Map<String, dynamic> _$saleservice_listToJson(saleservice_list instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    (json['content'] as List)
        ?.map((e) =>
            e == null ? null : Content.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['totalElements'] as int,
    json['last'] as bool,
    json['totalPages'] as int,
    json['number'] as int,
    json['size'] as int,
    (json['sort'] as List)
        ?.map(
            (e) => e == null ? null : Sort.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['first'] as bool,
    json['numberOfElements'] as int,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'content': instance.content,
      'totalElements': instance.totalElements,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'number': instance.number,
      'size': instance.size,
      'sort': instance.sort,
      'first': instance.first,
      'numberOfElements': instance.numberOfElements,
    };

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
    json['id'] as int,
    json['orderCode'] as String,
    json['deliveryCode'] as String,
    json['createdAt'] as String,
    json['handleStatus'] as int,
    json['serviceType'] as int,
    (json['afterSaleServiceProducts'] as List)
        ?.map((e) => e == null
            ? null
            : AfterSaleServiceProducts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'orderCode': instance.orderCode,
      'deliveryCode': instance.deliveryCode,
      'createdAt': instance.createdAt,
      'handleStatus': instance.handleStatus,
      'serviceType': instance.serviceType,
      'afterSaleServiceProducts': instance.afterSaleServiceProducts,
    };

AfterSaleServiceProducts _$AfterSaleServiceProductsFromJson(
    Map<String, dynamic> json) {
  return AfterSaleServiceProducts(
    json['saleServiceId'] as int,
    json['sourceProductSkuId'] as int,
    json['sourceProductSkuBarcode'] as String,
    json['quantity'] as int,
    json['sourceProductSkuImage'] as String,
  );
}

Map<String, dynamic> _$AfterSaleServiceProductsToJson(
        AfterSaleServiceProducts instance) =>
    <String, dynamic>{
      'saleServiceId': instance.saleServiceId,
      'sourceProductSkuId': instance.sourceProductSkuId,
      'sourceProductSkuBarcode': instance.sourceProductSkuBarcode,
      'quantity': instance.quantity,
      'sourceProductSkuImage': instance.sourceProductSkuImage,
    };

Sort _$SortFromJson(Map<String, dynamic> json) {
  return Sort(
    json['direction'] as String,
    json['property'] as String,
    json['ignoreCase'] as bool,
    json['nullHandling'] as String,
    json['ascending'] as bool,
    json['descending'] as bool,
  );
}

Map<String, dynamic> _$SortToJson(Sort instance) => <String, dynamic>{
      'direction': instance.direction,
      'property': instance.property,
      'ignoreCase': instance.ignoreCase,
      'nullHandling': instance.nullHandling,
      'ascending': instance.ascending,
      'descending': instance.descending,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
