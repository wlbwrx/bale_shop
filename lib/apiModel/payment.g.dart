// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

payment _$paymentFromJson(Map<String, dynamic> json) {
  return payment(
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

Map<String, dynamic> _$paymentToJson(payment instance) => <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['dataKey'] as String,
    json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'dataKey': instance.dataKey,
      'order': instance.order,
    };

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['id'] as int,
    json['code'] as String,
    json['freight'] as int,
    (json['originalTotalPrice'] as num)?.toDouble(),
    (json['discountTotalPrice'] as num)?.toDouble(),
    (json['randomReductionPrice'] as num)?.toDouble(),
    (json['totalPrice'] as num)?.toDouble(),
    json['currency'] as String,
    json['status'] as int,
    json['message'] as String,
    json['pixelId'] as String,
    json['scopeId'] as int,
    json['paymentType'] as int,
    json['couponCode'] as String,
    json['orderType'] as int,
    json['priority'] as int,
    json['ip'] as String,
    json['mergeType'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['version'] as int,
    (json['orderProducts'] as List)
        ?.map((e) => e == null
            ? null
            : OrderProducts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['orderAddress'] == null
        ? null
        : OrderAddress.fromJson(json['orderAddress'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
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
      'scopeId': instance.scopeId,
      'paymentType': instance.paymentType,
      'couponCode': instance.couponCode,
      'orderType': instance.orderType,
      'priority': instance.priority,
      'ip': instance.ip,
      'mergeType': instance.mergeType,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'version': instance.version,
      'orderProducts': instance.orderProducts,
      'orderAddress': instance.orderAddress,
    };

OrderProducts _$OrderProductsFromJson(Map<String, dynamic> json) {
  return OrderProducts(
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['orderId'] as int,
    json['orderCode'] as String,
    json['productId'] as int,
    json['productTitle'] as String,
    json['productSkuId'] as int,
    json['productSkuBarcode'] as String,
    json['productSkuName'] as String,
    (json['originalPrice'] as num)?.toDouble(),
    (json['discountPrice'] as num)?.toDouble(),
    (json['price'] as num)?.toDouble(),
    (json['originalTotalPrice'] as num)?.toDouble(),
    json['discountTotalPrice'] as int,
    json['quantity'] as int,
    json['productImageUrl'] as String,
    json['status'] as int,
    json['isSelect'] as bool,
    (json['productPrice'] as num)?.toDouble(),
    json['cleanStoreInventoryEnough'] as bool,
  );
}

Map<String, dynamic> _$OrderProductsToJson(OrderProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'orderId': instance.orderId,
      'orderCode': instance.orderCode,
      'productId': instance.productId,
      'productTitle': instance.productTitle,
      'productSkuId': instance.productSkuId,
      'productSkuBarcode': instance.productSkuBarcode,
      'productSkuName': instance.productSkuName,
      'originalPrice': instance.originalPrice,
      'discountPrice': instance.discountPrice,
      'price': instance.price,
      'originalTotalPrice': instance.originalTotalPrice,
      'discountTotalPrice': instance.discountTotalPrice,
      'quantity': instance.quantity,
      'productImageUrl': instance.productImageUrl,
      'status': instance.status,
      'isSelect': instance.isSelect,
      'productPrice': instance.productPrice,
      'cleanStoreInventoryEnough': instance.cleanStoreInventoryEnough,
    };

OrderAddress _$OrderAddressFromJson(Map<String, dynamic> json) {
  return OrderAddress(
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['consignee'] as String,
    json['tel'] as String,
    json['email'] as String,
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
      'email': instance.email,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'detail': instance.detail,
      'orderId': instance.orderId,
      'type': instance.type,
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
