import 'package:json_annotation/json_annotation.dart'; 
  
part 'logistics.g.dart';


@JsonSerializable()
  class logistics extends Object {

  @JsonKey(name: 'body')
  Body body;

  @JsonKey(name: 'headers')
  Headers headers;

  @JsonKey(name: 'statusCode')
  String statusCode;

  @JsonKey(name: 'statusCodeValue')
  int statusCodeValue;

  logistics(this.body,this.headers,this.statusCode,this.statusCodeValue,);

  factory logistics.fromJson(Map<String, dynamic> srcJson) => _$logisticsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$logisticsToJson(this);

}

  
@JsonSerializable()
  class Body extends Object {

  @JsonKey(name: 'eventInfos')
  List<EventInfos> eventInfos;

  @JsonKey(name: 'trackerInfo')
  TrackerInfo trackerInfo;

  Body(this.eventInfos,this.trackerInfo,);

  factory Body.fromJson(Map<String, dynamic> srcJson) => _$BodyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BodyToJson(this);

}

  
@JsonSerializable()
  class EventInfos extends Object {

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'event_name')
  String eventName;

  EventInfos(this.createdAt,this.eventName,);

  factory EventInfos.fromJson(Map<String, dynamic> srcJson) => _$EventInfosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EventInfosToJson(this);

}

  
@JsonSerializable()
  class TrackerInfo extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'agencyCompany')
  String agencyCompany;

  @JsonKey(name: 'trackingNumber')
  String trackingNumber;

  @JsonKey(name: 'carrierCode')
  String carrierCode;

  @JsonKey(name: 'orderCode')
  String orderCode;

  @JsonKey(name: 'destinationCode')
  String destinationCode;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'settlementStatus')
  int settlementStatus;

  @JsonKey(name: 'createdBy')
  String createdBy;

  @JsonKey(name: 'updatedBy')
  String updatedBy;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'createdAt')
  String createdAt;

  TrackerInfo(this.id,this.agencyCompany,this.trackingNumber,this.carrierCode,this.orderCode,this.destinationCode,this.status,this.settlementStatus,this.createdBy,this.updatedBy,this.updatedAt,this.createdAt,);

  factory TrackerInfo.fromJson(Map<String, dynamic> srcJson) => _$TrackerInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TrackerInfoToJson(this);

}

  
@JsonSerializable()
  class Headers extends Object {

  Headers();

  factory Headers.fromJson(Map<String, dynamic> srcJson) => _$HeadersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeadersToJson(this);

}

  
