// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Notice _$$_NoticeFromJson(Map<String, dynamic> json) => _$_Notice(
      id: json['_id'] as String?,
      author: json['author'] as String?,
      type: json['type'] as String,
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      creationData: json['creationData'] as String?,
      closed: json['closed'] as bool?,
    );

Map<String, dynamic> _$$_NoticeToJson(_$_Notice instance) => <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'type': instance.type,
      'description': instance.description,
      'tags': instance.tags,
      'creationData': instance.creationData,
      'closed': instance.closed,
    };
