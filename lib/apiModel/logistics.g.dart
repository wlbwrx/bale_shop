// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

logistics _$logisticsFromJson(Map<String, dynamic> json) {
  return logistics(
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

Map<String, dynamic> _$logisticsToJson(logistics instance) => <String, dynamic>{
      'body': instance.body,
      'headers': instance.headers,
      'statusCode': instance.statusCode,
      'statusCodeValue': instance.statusCodeValue,
    };

Body _$BodyFromJson(Map<String, dynamic> json) {
  return Body(
    (json['eventInfos'] as List)
        ?.map((e) =>
            e == null ? null : EventInfos.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['trackerInfo'] == null
        ? null
        : TrackerInfo.fromJson(json['trackerInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'eventInfos': instance.eventInfos,
      'trackerInfo': instance.trackerInfo,
    };

EventInfos _$EventInfosFromJson(Map<String, dynamic> json) {
  return EventInfos(
    json['created_at'] as String,
    json['event_name'] as String,
  );
}

Map<String, dynamic> _$EventInfosToJson(EventInfos instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt,
      'event_name': instance.eventName,
    };

TrackerInfo _$TrackerInfoFromJson(Map<String, dynamic> json) {
  return TrackerInfo(
    json['id'] as int,
    json['agencyCompany'] as String,
    json['trackingNumber'] as String,
    json['carrierCode'] as String,
    json['orderCode'] as String,
    json['destinationCode'] as String,
    json['status'] as String,
    json['settlementStatus'] as int,
    json['createdBy'] as String,
    json['updatedBy'] as String,
    json['updatedAt'] as String,
    json['createdAt'] as String,
  );
}

Map<String, dynamic> _$TrackerInfoToJson(TrackerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agencyCompany': instance.agencyCompany,
      'trackingNumber': instance.trackingNumber,
      'carrierCode': instance.carrierCode,
      'orderCode': instance.orderCode,
      'destinationCode': instance.destinationCode,
      'status': instance.status,
      'settlementStatus': instance.settlementStatus,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };

Headers _$HeadersFromJson(Map<String, dynamic> json) {
  return Headers();
}

Map<String, dynamic> _$HeadersToJson(Headers instance) => <String, dynamic>{};
