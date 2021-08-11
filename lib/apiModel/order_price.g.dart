// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

order_price _$order_priceFromJson(Map<String, dynamic> json) {
  return order_price(
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

Map<String, dynamic> _$order_priceToJson(order_price instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['price'] == null
        ? null
        : Price.fromJson(json['price'] as Map<String, dynamic>),
    (json['products'] as List)
        ?.map((e) =>
            e == null ? null : Products.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'price': instance.price,
      'products': instance.products,
    };

Price _$PriceFromJson(Map<String, dynamic> json) {
  return Price(
    (json['originalTotalPrice'] as num)?.toDouble(),
    json['freight'] as int,
    (json['discountTotalCouponPrice'] as num)?.toDouble(),
    (json['underlineTotalPrice'] as num)?.toDouble(),
    (json['discountTotalPrice'] as num)?.toDouble(),
    (json['spreadPrice'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'originalTotalPrice': instance.originalTotalPrice,
      'freight': instance.freight,
      'discountTotalCouponPrice': instance.discountTotalCouponPrice,
      'underlineTotalPrice': instance.underlineTotalPrice,
      'discountTotalPrice': instance.discountTotalPrice,
      'spreadPrice': instance.spreadPrice,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products(
    json['productId'] as int,
    json['productTitle'] as String,
    json['productSkuId'] as int,
    json['productSkuBarcode'] as String,
    json['productSkuName'] as String,
    (json['originalPrice'] as num)?.toDouble(),
    (json['underlinePrice'] as num)?.toDouble(),
    (json['discountPrice'] as num)?.toDouble(),
    (json['couponPrice'] as num)?.toDouble(),
    (json['price'] as num)?.toDouble(),
    (json['originalTotalPrice'] as num)?.toDouble(),
    (json['conditionPrice'] as num)?.toDouble(),
    (json['underlineTotalPrice'] as num)?.toDouble(),
    (json['discountTotalPrice'] as num)?.toDouble(),
    json['quantity'] as int,
    json['productImageUrl'] as String,
    json['isSelect'] as bool,
    (json['productPrice'] as num)?.toDouble(),
    json['cleanStoreInventoryEnough'] as bool,
    json['shoppingType'] as int,
    json['isLimitProduct'] as bool,
  );
}

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'productId': instance.productId,
      'productTitle': instance.productTitle,
      'productSkuId': instance.productSkuId,
      'productSkuBarcode': instance.productSkuBarcode,
      'productSkuName': instance.productSkuName,
      'originalPrice': instance.originalPrice,
      'underlinePrice': instance.underlinePrice,
      'discountPrice': instance.discountPrice,
      'couponPrice': instance.couponPrice,
      'price': instance.price,
      'originalTotalPrice': instance.originalTotalPrice,
      'conditionPrice': instance.conditionPrice,
      'underlineTotalPrice': instance.underlineTotalPrice,
      'discountTotalPrice': instance.discountTotalPrice,
      'quantity': instance.quantity,
      'productImageUrl': instance.productImageUrl,
      'isSelect': instance.isSelect,
      'productPrice': instance.productPrice,
      'cleanStoreInventoryEnough': instance.cleanStoreInventoryEnough,
      'shoppingType': instance.shoppingType,
      'isLimitProduct': instance.isLimitProduct,
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
