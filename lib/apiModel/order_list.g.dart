// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

order_list _$order_listFromJson(Map<String, dynamic> json) {
  return order_list(
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

Map<String, dynamic> _$order_listToJson(order_list instance) =>
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
    json['last'] as bool,
    json['totalElements'] as int,
    json['totalPages'] as int,
    json['number'] as int,
    json['size'] as int,
    json['first'] as bool,
    json['numberOfElements'] as int,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'content': instance.content,
      'last': instance.last,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'number': instance.number,
      'size': instance.size,
      'first': instance.first,
      'numberOfElements': instance.numberOfElements,
    };

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
    json['id'] as int,
    json['code'] as String,
    (json['freight'] as num)?.toDouble(),
    (json['originalTotalPrice'] as num)?.toDouble(),
    (json['discountTotalPrice'] as num)?.toDouble(),
    (json['randomReductionPrice'] as num)?.toDouble(),
    (json['totalPrice'] as num)?.toDouble(),
    json['currency'] as String,
    json['status'] as int,
    json['message'] as String,
    json['pixelId'] as String,
    json['affiliate'] as String,
    json['scopeId'] as int,
    json['paymentType'] as int,
    json['couponCode'] as String,
    json['orderType'] as int,
    json['priority'] as int,
    json['ip'] as String,
    json['userId'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['storehouseId'] as int,
    json['version'] as int,
    json['orderAddress'] == null
        ? null
        : OrderAddress.fromJson(json['orderAddress'] as Map<String, dynamic>),
    (json['packageInfos'] as List)
        ?.map((e) =>
            e == null ? null : PackageInfos.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'freight': instance.freight,
      'originalTotalPrice': instance.originalTotalPrice,
      'discountTotalPrice': instance.discountTotalPrice,
      'randomReductionPrice': instance.randomReductionPrice,
      'totalPrice': instance.totalPrice,
      'currency': instance.currency,
      'status': instance.status,
      'message': instance.message,
      'pixelId': instance.pixelId,
      'affiliate': instance.affiliate,
      'scopeId': instance.scopeId,
      'paymentType': instance.paymentType,
      'couponCode': instance.couponCode,
      'orderType': instance.orderType,
      'priority': instance.priority,
      'ip': instance.ip,
      'userId': instance.userId,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'storehouseId': instance.storehouseId,
      'version': instance.version,
      'orderAddress': instance.orderAddress,
      'packageInfos': instance.packageInfos,
    };

OrderAddress _$OrderAddressFromJson(Map<String, dynamic> json) {
  return OrderAddress(
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['consignee'] as String,
    json['tel'] as String,
    json['country'] as String,
    json['province'] as String,
    json['city'] as String,
    json['district'] as String,
    json['detail'] as String,
    json['orderId'] as int,
    json['type'] as int,
  );
}

Map<String, dynamic> _$OrderAddressToJson(OrderAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'consignee': instance.consignee,
      'tel': instance.tel,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'detail': instance.detail,
      'orderId': instance.orderId,
      'type': instance.type,
    };

PackageInfos _$PackageInfosFromJson(Map<String, dynamic> json) {
  return PackageInfos(
    json['delivery_id'] as int,
    json['delivery_code'] as String,
    json['last_event'] as String,
    json['last_update_time'] as String,
    json['status'] as int,
    (json['delivery_price'] as num)?.toDouble(),
    json['delivery_quantity'] as int,
    json['sku_quantity'] as int,
    (json['sku_infos'] as List)
        ?.map((e) =>
            e == null ? null : Sku_infos.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['userCanCancel'] as bool,
    json['orderCode'] as String,
    json['tracker_updated_at'] as String,
  );
}

Map<String, dynamic> _$PackageInfosToJson(PackageInfos instance) =>
    <String, dynamic>{
      'delivery_id': instance.deliveryId,
      'delivery_code': instance.deliveryCode,
      'last_event': instance.lastEvent,
      'last_update_time': instance.lastUpdateTime,
      'status': instance.status,
      'delivery_price': instance.deliveryPrice,
      'delivery_quantity': instance.deliveryQuantity,
      'sku_quantity': instance.skuQuantity,
      'sku_infos': instance.skuInfos,
      'orderCode': instance.orderCode,
      'userCanCancel': instance.userCanCancel,
      'tracker_updated_at': instance.trackerUpdatedAt,
    };

Sku_infos _$Sku_infosFromJson(Map<String, dynamic> json) {
  return Sku_infos(
    json['product_sku_barcode'] as String,
    json['sale_service_in'] as String,
    json['quantity'] as String,
    json['sale_service_reject'] as String,
    json['discount_price'] as String,
    json['product_id'] as String,
    json['product_sku_id'] as String,
    json['product_sku_name'] as String,
    json['order_product_status'] as String,
    json['product_image_url'] as String,
    json['sale_service_pass'] as String,
    json['product_title'] as String,
  );
}

Map<String, dynamic> _$Sku_infosToJson(Sku_infos instance) => <String, dynamic>{
      'product_sku_barcode': instance.productSkuBarcode,
      'sale_service_in': instance.saleServiceIn,
      'quantity': instance.quantity,
      'sale_service_reject': instance.saleServiceReject,
      'discount_price': instance.discountPrice,
      'product_id': instance.productId,
      'product_sku_id': instance.productSkuId,
      'product_sku_name': instance.productSkuName,
      'order_product_status': instance.orderProductStatus,
      'product_image_url': instance.productImageUrl,
      'sale_service_pass': instance.saleServicePass,
      'product_title': instance.productTitle,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
