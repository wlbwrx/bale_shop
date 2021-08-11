// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

cancel_order _$cancel_orderFromJson(Map<String, dynamic> json) {
  return cancel_order(
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

Map<String, dynamic> _$cancel_orderToJson(cancel_order instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['cancelProductCount'] as int,
    json['orderCode'] as String,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'cancelProductCount': instance.cancelProductCount,
      'orderCode': instance.orderCode,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
