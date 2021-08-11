// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saleservice_delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

saleservice_delivery _$saleservice_deliveryFromJson(Map<String, dynamic> json) {
  return saleservice_delivery(
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

Map<String, dynamic> _$saleservice_deliveryToJson(
        saleservice_delivery instance) =>
    <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    (json['deliveryProducts'] as List)
        ?.map((e) => e == null
            ? null
            : DeliveryProducts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['saleServiceModules'] as List)
        ?.map((e) => e == null
            ? null
            : SaleServiceModules.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'deliveryProducts': instance.deliveryProducts,
      'saleServiceModules': instance.saleServiceModules,
    };

DeliveryProducts _$DeliveryProductsFromJson(Map<String, dynamic> json) {
  return DeliveryProducts(
    json['id'] as int,
    json['deliveryId'] as int,
    json['deliveryCode'] as String,
    json['orderId'] as int,
    json['orderCode'] as String,
    json['orderProductId'] as int,
    json['productId'] as int,
    json['productTitle'] as String,
    json['productSkuId'] as int,
    json['productSkuBarcode'] as String,
    json['productSkuName'] as String,
    (json['productSkuPrice'] as num)?.toDouble(),
    json['discountPrice'] as int,
    (json['originalPrice'] as num)?.toDouble(),
    json['deliveryQuantity'] as int,
    json['status'] as int,
    json['createdBy'] as String,
    json['updatedBy'] as String,
    json['updatedAt'] as String,
    json['createdAt'] as String,
    json['storehouseInventoryPositions'] as String,
    json['pickQuantity'] as int,
    json['productSkuImage'] as String,
    json['sourceProductSkuId'] as int,
    json['productStatus'] as int,
  );
}

Map<String, dynamic> _$DeliveryProductsToJson(DeliveryProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deliveryId': instance.deliveryId,
      'deliveryCode': instance.deliveryCode,
      'orderId': instance.orderId,
      'orderCode': instance.orderCode,
      'orderProductId': instance.orderProductId,
      'productId': instance.productId,
      'productTitle': instance.productTitle,
      'productSkuId': instance.productSkuId,
      'productSkuBarcode': instance.productSkuBarcode,
      'productSkuName': instance.productSkuName,
      'productSkuPrice': instance.productSkuPrice,
      'discountPrice': instance.discountPrice,
      'originalPrice': instance.originalPrice,
      'deliveryQuantity': instance.deliveryQuantity,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'storehouseInventoryPositions': instance.storehouseInventoryPositions,
      'pickQuantity': instance.pickQuantity,
      'productSkuImage': instance.productSkuImage,
      'sourceProductSkuId': instance.sourceProductSkuId,
      'productStatus': instance.productStatus,
    };

SaleServiceModules _$SaleServiceModulesFromJson(Map<String, dynamic> json) {
  return SaleServiceModules(
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
    json['returnTrackingNumber'] as int,
    json['lineAcount'] as String,
    (json['saleServiceTotalPrice'] as num)?.toDouble(),
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
    json['yn'] as int,
  );
}

Map<String, dynamic> _$SaleServiceModulesToJson(SaleServiceModules instance) =>
    <String, dynamic>{
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
      'serviceCustomerImgs': instance.serviceCustomerImgs,
      'serviceCustomerMsgs': instance.serviceCustomerMsgs,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'customerAddressInfo': instance.customerAddressInfo,
      'afterSaleServiceProducts': instance.afterSaleServiceProducts,
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
    (json['sourceOriginalPrice'] as num)?.toDouble(),
    json['sourceUnderlinePrice'] as int,
    json['serviceType'] as String,
    json['subServiceType'] as String,
    json['serviceDesc'] as String,
    json['handleStatus'] as int,
    json['createdBy'] as String,
    json['updatedBy'] as String,
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
      'sourceOriginalPrice': instance.sourceOriginalPrice,
      'sourceUnderlinePrice': instance.sourceUnderlinePrice,
      'serviceType': instance.serviceType,
      'subServiceType': instance.subServiceType,
      'serviceDesc': instance.serviceDesc,
      'handleStatus': instance.handleStatus,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'sourceProductIsLimit': instance.sourceProductIsLimit,
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
