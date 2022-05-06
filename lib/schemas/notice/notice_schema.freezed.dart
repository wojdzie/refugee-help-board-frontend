// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notice_schema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Notice _$NoticeFromJson(Map<String, dynamic> json) {
  return _Notice.fromJson(json);
}

/// @nodoc
class _$NoticeTearOff {
  const _$NoticeTearOff();

  _Notice call(
      {String? author,
      required String type,
      required String description,
      required List<String> tags}) {
    return _Notice(
      author: author,
      type: type,
      description: description,
      tags: tags,
    );
  }

  Notice fromJson(Map<String, Object?> json) {
    return Notice.fromJson(json);
  }
}

/// @nodoc
const $Notice = _$NoticeTearOff();

/// @nodoc
mixin _$Notice {
  String? get author => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoticeCopyWith<Notice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeCopyWith<$Res> {
  factory $NoticeCopyWith(Notice value, $Res Function(Notice) then) =
      _$NoticeCopyWithImpl<$Res>;
  $Res call(
      {String? author, String type, String description, List<String> tags});
}

/// @nodoc
class _$NoticeCopyWithImpl<$Res> implements $NoticeCopyWith<$Res> {
  _$NoticeCopyWithImpl(this._value, this._then);

  final Notice _value;
  // ignore: unused_field
  final $Res Function(Notice) _then;

  @override
  $Res call({
    Object? author = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$NoticeCopyWith<$Res> implements $NoticeCopyWith<$Res> {
  factory _$NoticeCopyWith(_Notice value, $Res Function(_Notice) then) =
      __$NoticeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? author, String type, String description, List<String> tags});
}

/// @nodoc
class __$NoticeCopyWithImpl<$Res> extends _$NoticeCopyWithImpl<$Res>
    implements _$NoticeCopyWith<$Res> {
  __$NoticeCopyWithImpl(_Notice _value, $Res Function(_Notice) _then)
      : super(_value, (v) => _then(v as _Notice));

  @override
  _Notice get _value => super._value as _Notice;

  @override
  $Res call({
    Object? author = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? tags = freezed,
  }) {
    return _then(_Notice(
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Notice with DiagnosticableTreeMixin implements _Notice {
  const _$_Notice(
      {this.author,
      required this.type,
      required this.description,
      required this.tags});

  factory _$_Notice.fromJson(Map<String, dynamic> json) =>
      _$$_NoticeFromJson(json);

  @override
  final String? author;
  @override
  final String type;
  @override
  final String description;
  @override
  final List<String> tags;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Notice(author: $author, type: $type, description: $description, tags: $tags)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Notice'))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('tags', tags));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Notice &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(author),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(tags));

  @JsonKey(ignore: true)
  @override
  _$NoticeCopyWith<_Notice> get copyWith =>
      __$NoticeCopyWithImpl<_Notice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoticeToJson(this);
  }
}

abstract class _Notice implements Notice {
  const factory _Notice(
      {String? author,
      required String type,
      required String description,
      required List<String> tags}) = _$_Notice;

  factory _Notice.fromJson(Map<String, dynamic> json) = _$_Notice.fromJson;

  @override
  String? get author;
  @override
  String get type;
  @override
  String get description;
  @override
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$NoticeCopyWith<_Notice> get copyWith => throw _privateConstructorUsedError;
}
