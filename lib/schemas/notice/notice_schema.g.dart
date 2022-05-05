// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Notice _$$_NoticeFromJson(Map<String, dynamic> json) => _$_Notice(
      author: json['author'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$_NoticeToJson(_$_Notice instance) => <String, dynamic>{
      'author': instance.author,
      'type': instance.type,
      'description': instance.description,
    };
