// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

search_list _$search_listFromJson(Map<String, dynamic> json) {
  return search_list(
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

Map<String, dynamic> _$search_listToJson(search_list instance) =>
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
    json['pageable'] == null
        ? null
        : Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
    json['facets'] as List,
    json['aggregations'] as String,
    json['scrollId'] as String,
    json['maxScore'] as String,
    json['totalElements'] as int,
    json['totalPages'] as int,
    json['first'] as bool,
    json['sort'] == null
        ? null
        : Sort.fromJson(json['sort'] as Map<String, dynamic>),
    json['numberOfElements'] as int,
    json['last'] as bool,
    json['size'] as int,
    json['number'] as int,
    json['empty'] as bool,
  );
}

Map<String, dynamic> _$BodyToJson(Body instance) => <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'facets': instance.facets,
      'aggregations': instance.aggregations,
      'scrollId': instance.scrollId,
      'maxScore': instance.maxScore,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'first': instance.first,
      'sort': instance.sort,
      'numberOfElements': instance.numberOfElements,
      'last': instance.last,
      'size': instance.size,
      'number': instance.number,
      'empty': instance.empty,
    };

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
    json['productId'] as int,
    json['title'] as String,
    json['productImageUrl'] as String,
    json['flag'] as String,
    json['isNew'] as bool,
    (json['maxPrice'] as num)?.toDouble(),
    (json['minPrice'] as num)?.toDouble(),
    (json['originalPrice'] as num)?.toDouble(),
    json['description'] as String,
    json['version'] as int,
  );
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'productImageUrl': instance.productImageUrl,
      'flag': instance.flag,
      'isNew': instance.isNew,
      'maxPrice': instance.maxPrice,
      'minPrice': instance.minPrice,
      'originalPrice': instance.originalPrice,
      'description': instance.description,
      'version': instance.version,
    };

Pageable _$PageableFromJson(Map<String, dynamic> json) {
  return Pageable(
    json['sort'] == null
        ? null
        : Sort.fromJson(json['sort'] as Map<String, dynamic>),
    json['pageSize'] as int,
    json['pageNumber'] as int,
    json['offset'] as int,
    json['paged'] as bool,
    json['unpaged'] as bool,
  );
}

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
      'sort': instance.sort,
      'pageSize': instance.pageSize,
      'pageNumber': instance.pageNumber,
      'offset': instance.offset,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };

Sort _$SortFromJson(Map<String, dynamic> json) {
  return Sort(
    json['sorted'] as bool,
    json['unsorted'] as bool,
    json['empty'] as bool,
  );
}

Map<String, dynamic> _$SortToJson(Sort instance) => <String, dynamic>{
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
      'empty': instance.empty,
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
