// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competence_check.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompetenceCheck _$CompetenceCheckFromJson(Map<String, dynamic> json) {
  return _CompetenceCheck.fromJson(json);
}

/// @nodoc
mixin _$CompetenceCheck {
  @JsonKey(name: 'check_id')
  String get checkId => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'competence_id')
  int get competenceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'competence_status')
  int get competenceStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_id')
  int get pupilId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_report')
  bool get isReport => throw _privateConstructorUsedError;
  @JsonKey(name: 'report_id')
  String? get reportId => throw _privateConstructorUsedError;
  @JsonKey(name: "competence_check_files")
  List<CompetenceCheckFile>? get competenceCheckFiles =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompetenceCheckCopyWith<CompetenceCheck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompetenceCheckCopyWith<$Res> {
  factory $CompetenceCheckCopyWith(
          CompetenceCheck value, $Res Function(CompetenceCheck) then) =
      _$CompetenceCheckCopyWithImpl<$Res, CompetenceCheck>;
  @useResult
  $Res call(
      {@JsonKey(name: 'check_id') String checkId,
      String comment,
      @JsonKey(name: 'competence_id') int competenceId,
      @JsonKey(name: 'competence_status') int competenceStatus,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'pupil_id') int pupilId,
      @JsonKey(name: 'is_report') bool isReport,
      @JsonKey(name: 'report_id') String? reportId,
      @JsonKey(name: "competence_check_files")
      List<CompetenceCheckFile>? competenceCheckFiles});
}

/// @nodoc
class _$CompetenceCheckCopyWithImpl<$Res, $Val extends CompetenceCheck>
    implements $CompetenceCheckCopyWith<$Res> {
  _$CompetenceCheckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkId = null,
    Object? comment = null,
    Object? competenceId = null,
    Object? competenceStatus = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? pupilId = null,
    Object? isReport = null,
    Object? reportId = freezed,
    Object? competenceCheckFiles = freezed,
  }) {
    return _then(_value.copyWith(
      checkId: null == checkId
          ? _value.checkId
          : checkId // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      competenceId: null == competenceId
          ? _value.competenceId
          : competenceId // ignore: cast_nullable_to_non_nullable
              as int,
      competenceStatus: null == competenceStatus
          ? _value.competenceStatus
          : competenceStatus // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      pupilId: null == pupilId
          ? _value.pupilId
          : pupilId // ignore: cast_nullable_to_non_nullable
              as int,
      isReport: null == isReport
          ? _value.isReport
          : isReport // ignore: cast_nullable_to_non_nullable
              as bool,
      reportId: freezed == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String?,
      competenceCheckFiles: freezed == competenceCheckFiles
          ? _value.competenceCheckFiles
          : competenceCheckFiles // ignore: cast_nullable_to_non_nullable
              as List<CompetenceCheckFile>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompetenceCheckImplCopyWith<$Res>
    implements $CompetenceCheckCopyWith<$Res> {
  factory _$$CompetenceCheckImplCopyWith(_$CompetenceCheckImpl value,
          $Res Function(_$CompetenceCheckImpl) then) =
      __$$CompetenceCheckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'check_id') String checkId,
      String comment,
      @JsonKey(name: 'competence_id') int competenceId,
      @JsonKey(name: 'competence_status') int competenceStatus,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'pupil_id') int pupilId,
      @JsonKey(name: 'is_report') bool isReport,
      @JsonKey(name: 'report_id') String? reportId,
      @JsonKey(name: "competence_check_files")
      List<CompetenceCheckFile>? competenceCheckFiles});
}

/// @nodoc
class __$$CompetenceCheckImplCopyWithImpl<$Res>
    extends _$CompetenceCheckCopyWithImpl<$Res, _$CompetenceCheckImpl>
    implements _$$CompetenceCheckImplCopyWith<$Res> {
  __$$CompetenceCheckImplCopyWithImpl(
      _$CompetenceCheckImpl _value, $Res Function(_$CompetenceCheckImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkId = null,
    Object? comment = null,
    Object? competenceId = null,
    Object? competenceStatus = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? pupilId = null,
    Object? isReport = null,
    Object? reportId = freezed,
    Object? competenceCheckFiles = freezed,
  }) {
    return _then(_$CompetenceCheckImpl(
      checkId: null == checkId
          ? _value.checkId
          : checkId // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      competenceId: null == competenceId
          ? _value.competenceId
          : competenceId // ignore: cast_nullable_to_non_nullable
              as int,
      competenceStatus: null == competenceStatus
          ? _value.competenceStatus
          : competenceStatus // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      pupilId: null == pupilId
          ? _value.pupilId
          : pupilId // ignore: cast_nullable_to_non_nullable
              as int,
      isReport: null == isReport
          ? _value.isReport
          : isReport // ignore: cast_nullable_to_non_nullable
              as bool,
      reportId: freezed == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String?,
      competenceCheckFiles: freezed == competenceCheckFiles
          ? _value._competenceCheckFiles
          : competenceCheckFiles // ignore: cast_nullable_to_non_nullable
              as List<CompetenceCheckFile>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompetenceCheckImpl implements _CompetenceCheck {
  _$CompetenceCheckImpl(
      {@JsonKey(name: 'check_id') required this.checkId,
      required this.comment,
      @JsonKey(name: 'competence_id') required this.competenceId,
      @JsonKey(name: 'competence_status') required this.competenceStatus,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'pupil_id') required this.pupilId,
      @JsonKey(name: 'is_report') required this.isReport,
      @JsonKey(name: 'report_id') this.reportId,
      @JsonKey(name: "competence_check_files")
      final List<CompetenceCheckFile>? competenceCheckFiles})
      : _competenceCheckFiles = competenceCheckFiles;

  factory _$CompetenceCheckImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompetenceCheckImplFromJson(json);

  @override
  @JsonKey(name: 'check_id')
  final String checkId;
  @override
  final String comment;
  @override
  @JsonKey(name: 'competence_id')
  final int competenceId;
  @override
  @JsonKey(name: 'competence_status')
  final int competenceStatus;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  @override
  @JsonKey(name: 'is_report')
  final bool isReport;
  @override
  @JsonKey(name: 'report_id')
  final String? reportId;
  final List<CompetenceCheckFile>? _competenceCheckFiles;
  @override
  @JsonKey(name: "competence_check_files")
  List<CompetenceCheckFile>? get competenceCheckFiles {
    final value = _competenceCheckFiles;
    if (value == null) return null;
    if (_competenceCheckFiles is EqualUnmodifiableListView)
      return _competenceCheckFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CompetenceCheck(checkId: $checkId, comment: $comment, competenceId: $competenceId, competenceStatus: $competenceStatus, createdAt: $createdAt, createdBy: $createdBy, pupilId: $pupilId, isReport: $isReport, reportId: $reportId, competenceCheckFiles: $competenceCheckFiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompetenceCheckImpl &&
            (identical(other.checkId, checkId) || other.checkId == checkId) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.competenceId, competenceId) ||
                other.competenceId == competenceId) &&
            (identical(other.competenceStatus, competenceStatus) ||
                other.competenceStatus == competenceStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.pupilId, pupilId) || other.pupilId == pupilId) &&
            (identical(other.isReport, isReport) ||
                other.isReport == isReport) &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            const DeepCollectionEquality()
                .equals(other._competenceCheckFiles, _competenceCheckFiles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      checkId,
      comment,
      competenceId,
      competenceStatus,
      createdAt,
      createdBy,
      pupilId,
      isReport,
      reportId,
      const DeepCollectionEquality().hash(_competenceCheckFiles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompetenceCheckImplCopyWith<_$CompetenceCheckImpl> get copyWith =>
      __$$CompetenceCheckImplCopyWithImpl<_$CompetenceCheckImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompetenceCheckImplToJson(
      this,
    );
  }
}

abstract class _CompetenceCheck implements CompetenceCheck {
  factory _CompetenceCheck(
      {@JsonKey(name: 'check_id') required final String checkId,
      required final String comment,
      @JsonKey(name: 'competence_id') required final int competenceId,
      @JsonKey(name: 'competence_status') required final int competenceStatus,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'created_by') required final String createdBy,
      @JsonKey(name: 'pupil_id') required final int pupilId,
      @JsonKey(name: 'is_report') required final bool isReport,
      @JsonKey(name: 'report_id') final String? reportId,
      @JsonKey(name: "competence_check_files")
      final List<CompetenceCheckFile>?
          competenceCheckFiles}) = _$CompetenceCheckImpl;

  factory _CompetenceCheck.fromJson(Map<String, dynamic> json) =
      _$CompetenceCheckImpl.fromJson;

  @override
  @JsonKey(name: 'check_id')
  String get checkId;
  @override
  String get comment;
  @override
  @JsonKey(name: 'competence_id')
  int get competenceId;
  @override
  @JsonKey(name: 'competence_status')
  int get competenceStatus;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'pupil_id')
  int get pupilId;
  @override
  @JsonKey(name: 'is_report')
  bool get isReport;
  @override
  @JsonKey(name: 'report_id')
  String? get reportId;
  @override
  @JsonKey(name: "competence_check_files")
  List<CompetenceCheckFile>? get competenceCheckFiles;
  @override
  @JsonKey(ignore: true)
  _$$CompetenceCheckImplCopyWith<_$CompetenceCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompetenceCheckFile _$CompetenceCheckFileFromJson(Map<String, dynamic> json) {
  return _CompetenceCheckFile.fromJson(json);
}

/// @nodoc
mixin _$CompetenceCheckFile {
  @JsonKey(name: "check_id")
  String get checkId => throw _privateConstructorUsedError;
  @JsonKey(name: "file_id")
  String get fileId => throw _privateConstructorUsedError;
  @JsonKey(name: "file_url")
  String get fileUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompetenceCheckFileCopyWith<CompetenceCheckFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompetenceCheckFileCopyWith<$Res> {
  factory $CompetenceCheckFileCopyWith(
          CompetenceCheckFile value, $Res Function(CompetenceCheckFile) then) =
      _$CompetenceCheckFileCopyWithImpl<$Res, CompetenceCheckFile>;
  @useResult
  $Res call(
      {@JsonKey(name: "check_id") String checkId,
      @JsonKey(name: "file_id") String fileId,
      @JsonKey(name: "file_url") String fileUrl});
}

/// @nodoc
class _$CompetenceCheckFileCopyWithImpl<$Res, $Val extends CompetenceCheckFile>
    implements $CompetenceCheckFileCopyWith<$Res> {
  _$CompetenceCheckFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkId = null,
    Object? fileId = null,
    Object? fileUrl = null,
  }) {
    return _then(_value.copyWith(
      checkId: null == checkId
          ? _value.checkId
          : checkId // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompetenceCheckFileImplCopyWith<$Res>
    implements $CompetenceCheckFileCopyWith<$Res> {
  factory _$$CompetenceCheckFileImplCopyWith(_$CompetenceCheckFileImpl value,
          $Res Function(_$CompetenceCheckFileImpl) then) =
      __$$CompetenceCheckFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "check_id") String checkId,
      @JsonKey(name: "file_id") String fileId,
      @JsonKey(name: "file_url") String fileUrl});
}

/// @nodoc
class __$$CompetenceCheckFileImplCopyWithImpl<$Res>
    extends _$CompetenceCheckFileCopyWithImpl<$Res, _$CompetenceCheckFileImpl>
    implements _$$CompetenceCheckFileImplCopyWith<$Res> {
  __$$CompetenceCheckFileImplCopyWithImpl(_$CompetenceCheckFileImpl _value,
      $Res Function(_$CompetenceCheckFileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkId = null,
    Object? fileId = null,
    Object? fileUrl = null,
  }) {
    return _then(_$CompetenceCheckFileImpl(
      checkId: null == checkId
          ? _value.checkId
          : checkId // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompetenceCheckFileImpl implements _CompetenceCheckFile {
  const _$CompetenceCheckFileImpl(
      {@JsonKey(name: "check_id") required this.checkId,
      @JsonKey(name: "file_id") required this.fileId,
      @JsonKey(name: "file_url") required this.fileUrl});

  factory _$CompetenceCheckFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompetenceCheckFileImplFromJson(json);

  @override
  @JsonKey(name: "check_id")
  final String checkId;
  @override
  @JsonKey(name: "file_id")
  final String fileId;
  @override
  @JsonKey(name: "file_url")
  final String fileUrl;

  @override
  String toString() {
    return 'CompetenceCheckFile(checkId: $checkId, fileId: $fileId, fileUrl: $fileUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompetenceCheckFileImpl &&
            (identical(other.checkId, checkId) || other.checkId == checkId) &&
            (identical(other.fileId, fileId) || other.fileId == fileId) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, checkId, fileId, fileUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompetenceCheckFileImplCopyWith<_$CompetenceCheckFileImpl> get copyWith =>
      __$$CompetenceCheckFileImplCopyWithImpl<_$CompetenceCheckFileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompetenceCheckFileImplToJson(
      this,
    );
  }
}

abstract class _CompetenceCheckFile implements CompetenceCheckFile {
  const factory _CompetenceCheckFile(
          {@JsonKey(name: "check_id") required final String checkId,
          @JsonKey(name: "file_id") required final String fileId,
          @JsonKey(name: "file_url") required final String fileUrl}) =
      _$CompetenceCheckFileImpl;

  factory _CompetenceCheckFile.fromJson(Map<String, dynamic> json) =
      _$CompetenceCheckFileImpl.fromJson;

  @override
  @JsonKey(name: "check_id")
  String get checkId;
  @override
  @JsonKey(name: "file_id")
  String get fileId;
  @override
  @JsonKey(name: "file_url")
  String get fileUrl;
  @override
  @JsonKey(ignore: true)
  _$$CompetenceCheckFileImplCopyWith<_$CompetenceCheckFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
