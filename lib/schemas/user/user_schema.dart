import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part "user_schema.freezed.dart";
part "user_schema.g.dart";

@freezed
class User with _$User {
  const factory User({
    required String login,
    required String password,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
