// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saleservice_order_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

saleservice_order_list _$saleservice_order_listFromJson(
    Map<String, dynamic> json) {
  return saleservice_order_list(
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

Map<String, dynamic> _$saleservice_order_listToJson(
        saleservice_order_list instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    json['id'] as int,
    json['serviceType'] as int,
    json['serviceSource'] as int,
    json['orderId'] as int,
    json['orderCode'] as String,
    json['scopeId'] as int,
    json['paymentType'] as int,
    json['consignee'] as String,
    json['tel'] as String,
    json['deliveryCode'] as String,
    json['trackingNumber'] as String,
    json['storehouseId'] as int,
    json['accountInfo'] as String,
    json['accountName'] as String,
    json['accountNumber'] as String,
    json['accountBank'] as String,
    json['accountBankImgs'] as String,
    json['handleType'] as String,
    json['handleResult'] as String,
    json['handleStatus'] as int,
    json['newOrderCode'] as String,
    json['returnTrackingNumber'] as String,
    json['lineAcount'] as String,
    (json['saleServiceTotalPrice'] as num)?.toDouble(),
    json['userId'] as int,
    json['serviceCustomerImgs'] as String,
    json['serviceCustomerMsgs'] as String,
    json['createdBy'] as String,
    json['updatedBy'] as String,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['customerAddressInfo'] as String,
    (json['afterSaleServiceProducts'] as List)
        ?.map((e) => e == null
            ? null
            : AfterSaleServiceProducts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['trackerInfo'] as String,
    json['createBeginTime'] as String,
    json['createEndTime'] as String,
    json['sourceAddress'] as String,
    json['yn'] as int,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'id': instance.id,
      'serviceType': instance.serviceType,
      'serviceSource': instance.serviceSource,
      'orderId': instance.orderId,
      'orderCode': instance.orderCode,
      'scopeId': instance.scopeId,
      'paymentType': instance.paymentType,
      'consignee': instance.consignee,
      'tel': instance.tel,
      'deliveryCode': instance.deliveryCode,
      'trackingNumber': instance.trackingNumber,
      'storehouseId': instance.storehouseId,
      'accountInfo': instance.accountInfo,
      'accountName': instance.accountName,
      'accountNumber': instance.accountNumber,
      'accountBank': instance.accountBank,
      'accountBankImgs': instance.accountBankImgs,
      'handleType': instance.handleType,
      'handleResult': instance.handleResult,
      'handleStatus': instance.handleStatus,
      'newOrderCode': instance.newOrderCode,
      'returnTrackingNumber': instance.returnTrackingNumber,
      'lineAcount': instance.lineAcount,
      'saleServiceTotalPrice': instance.saleServiceTotalPrice,
      'userId': instance.userId,
      'serviceCustomerImgs': instance.serviceCustomerImgs,
      'serviceCustomerMsgs': instance.serviceCustomerMsgs,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'customerAddressInfo': instance.customerAddressInfo,
      'afterSaleServiceProducts': instance.afterSaleServiceProducts,
      'trackerInfo': instance.trackerInfo,
      'createBeginTime': instance.createBeginTime,
      'createEndTime': instance.createEndTime,
      'sourceAddress': instance.sourceAddress,
      'yn': instance.yn,
    };

AfterSaleServiceProducts _$AfterSaleServiceProductsFromJson(
    Map<String, dynamic> json) {
  return AfterSaleServiceProducts(
    json['id'] as int,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['saleServiceId'] as int,
    json['deliveryCode'] as String,
    json['productId'] as int,
    json['quantity'] as int,
    json['sourceProductSkuId'] as int,
    json['sourceProductSkuBarcode'] as String,
    (json['sourceDiscountPrice'] as num)?.toDouble(),
    (json['discountPrice'] as num)?.toDouble(),
    (json['originalPrice'] as num)?.toDouble(),
    (json['sourceOriginalPrice'] as num)?.toDouble(),
    json['sourceUnderlinePrice'] as int,
    json['productSkuId'] as int,
    json['productSkuBarcode'] as String,
    json['underlinePrice'] as int,
    json['serviceType'] as String,
    json['subServiceType'] as String,
    json['handleStatus'] as int,
    json['createdBy'] as String,
    json['updatedBy'] as String,
    json['sourceProductTitle'] as String,
    json['productTitle'] as String,
    json['productSkuImage'] as String,
    json['sourceProductSkuImage'] as String,
    json['productSkuName'] as String,
    json['sourceProductSkuName'] as String,
    json['sourceProductIsLimit'] as int,
  );
}

Map<String, dynamic> _$AfterSaleServiceProductsToJson(
        AfterSaleServiceProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'saleServiceId': instance.saleServiceId,
      'deliveryCode': instance.deliveryCode,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'sourceProductSkuId': instance.sourceProductSkuId,
      'sourceProductSkuBarcode': instance.sourceProductSkuBarcode,
      'sourceDiscountPrice': instance.sourceDiscountPrice,
      'discountPrice': instance.discountPrice,
      'originalPrice': instance.originalPrice,
      'sourceOriginalPrice': instance.sourceOriginalPrice,
      'sourceUnderlinePrice': instance.sourceUnderlinePrice,
      'productSkuId': instance.productSkuId,
      'productSkuBarcode': instance.productSkuBarcode,
      'underlinePrice': instance.underlinePrice,
      'serviceType': instance.serviceType,
      'subServiceType': instance.subServiceType,
      'handleStatus': instance.handleStatus,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'sourceProductTitle': instance.sourceProductTitle,
      'productTitle': instance.productTitle,
      'productSkuImage': instance.productSkuImage,
      'sourceProductSkuImage': instance.sourceProductSkuImage,
      'productSkuName': instance.productSkuName,
      'sourceProductSkuName': instance.sourceProductSkuName,
      'sourceProductIsLimit': instance.sourceProductIsLimit,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
