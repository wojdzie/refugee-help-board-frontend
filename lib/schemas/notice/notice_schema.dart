import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part "notice_schema.freezed.dart";
part "notice_schema.g.dart";

@freezed
class Notice with _$Notice {
  const factory Notice({
    @JsonKey(name: "_id") String? id,
    String? author,
    required String type,
    required String description,
    required List<String> tags,
    String? creationData,
    bool? closed,
  }) = _Notice;

  factory Notice.fromJson(Map<String, Object?> json) => _$NoticeFromJson(json);
}
