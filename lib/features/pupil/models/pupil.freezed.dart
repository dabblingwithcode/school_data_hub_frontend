// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pupil.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Pupil _$PupilFromJson(Map<String, dynamic> json) {
  return _Pupil.fromJson(json);
}

/// @nodoc
mixin _$Pupil {
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get group => throw _privateConstructorUsedError;
  String? get schoolyear => throw _privateConstructorUsedError;
  String? get specialNeeds => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  String? get family => throw _privateConstructorUsedError;
  DateTime? get birthday => throw _privateConstructorUsedError;
  DateTime? get migrationSupportEnds => throw _privateConstructorUsedError;
  DateTime? get pupilSince => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'communication_pupil')
  String? get communicationPupil => throw _privateConstructorUsedError;
  @JsonKey(name: 'communication_tutor1')
  String? get communicationTutor1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'communication_tutor2')
  String? get communicationTutor2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact')
  String? get contact => throw _privateConstructorUsedError;
  @JsonKey(name: 'parents_contact')
  String? get parentsContact => throw _privateConstructorUsedError;
  int get credit => throw _privateConstructorUsedError;
  @JsonKey(name: 'credit_earned')
  int get creditEarned => throw _privateConstructorUsedError;
  @JsonKey(name: 'five_years')
  String? get fiveYears => throw _privateConstructorUsedError;
  @JsonKey(name: 'individual_development_plan')
  int get individualDevelopmentPlan => throw _privateConstructorUsedError;
  @JsonKey(name: 'internal_id')
  int get internalId => throw _privateConstructorUsedError;
  bool get ogs => throw _privateConstructorUsedError;
  @JsonKey(name: 'ogs_info')
  String? get ogsInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'pick_up_time')
  String? get pickUpTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'preschool_revision')
  int? get preschoolRevision => throw _privateConstructorUsedError;
  @JsonKey(name: 'special_information')
  String? get specialInformation => throw _privateConstructorUsedError;
  @JsonKey(name: 'competence_checks')
  List<CompetenceCheck>? get competenceChecks =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_category_statuses')
  List<PupilCategoryStatus>? get pupilCategoryStatuses =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_admonitions')
  List<Admonition>? get pupilAdmonitions => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_books')
  List<PupilBook>? get pupilBooks => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_lists')
  List<PupilList>? get pupilLists => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_goals')
  List<PupilGoal>? get pupilGoals => throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_missed_classes')
  List<MissedClass>? get pupilMissedClasses =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'pupil_workbooks')
  List<PupilWorkbook>? get pupilWorkbooks => throw _privateConstructorUsedError;
  List<PupilAuthorization>? get authorizations =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "credit_history_logs")
  List<CreditHistoryLog>? get creditHistoryLogs =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "competence_goals")
  List<CompetenceGoal>? get competenceGoals =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PupilCopyWith<Pupil> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PupilCopyWith<$Res> {
  factory $PupilCopyWith(Pupil value, $Res Function(Pupil) then) =
      _$PupilCopyWithImpl<$Res, Pupil>;
  @useResult
  $Res call(
      {String? firstName,
      String? lastName,
      String? group,
      String? schoolyear,
      String? specialNeeds,
      String? gender,
      String? language,
      String? family,
      DateTime? birthday,
      DateTime? migrationSupportEnds,
      DateTime? pupilSince,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'communication_pupil') String? communicationPupil,
      @JsonKey(name: 'communication_tutor1') String? communicationTutor1,
      @JsonKey(name: 'communication_tutor2') String? communicationTutor2,
      @JsonKey(name: 'contact') String? contact,
      @JsonKey(name: 'parents_contact') String? parentsContact,
      int credit,
      @JsonKey(name: 'credit_earned') int creditEarned,
      @JsonKey(name: 'five_years') String? fiveYears,
      @JsonKey(name: 'individual_development_plan')
      int individualDevelopmentPlan,
      @JsonKey(name: 'internal_id') int internalId,
      bool ogs,
      @JsonKey(name: 'ogs_info') String? ogsInfo,
      @JsonKey(name: 'pick_up_time') String? pickUpTime,
      @JsonKey(name: 'preschool_revision') int? preschoolRevision,
      @JsonKey(name: 'special_information') String? specialInformation,
      @JsonKey(name: 'competence_checks')
      List<CompetenceCheck>? competenceChecks,
      @JsonKey(name: 'pupil_category_statuses')
      List<PupilCategoryStatus>? pupilCategoryStatuses,
      @JsonKey(name: 'pupil_admonitions') List<Admonition>? pupilAdmonitions,
      @JsonKey(name: 'pupil_books') List<PupilBook>? pupilBooks,
      @JsonKey(name: 'pupil_lists') List<PupilList>? pupilLists,
      @JsonKey(name: 'pupil_goals') List<PupilGoal>? pupilGoals,
      @JsonKey(name: 'pupil_missed_classes')
      List<MissedClass>? pupilMissedClasses,
      @JsonKey(name: 'pupil_workbooks') List<PupilWorkbook>? pupilWorkbooks,
      List<PupilAuthorization>? authorizations,
      @JsonKey(name: "credit_history_logs")
      List<CreditHistoryLog>? creditHistoryLogs,
      @JsonKey(name: "competence_goals")
      List<CompetenceGoal>? competenceGoals});
}

/// @nodoc
class _$PupilCopyWithImpl<$Res, $Val extends Pupil>
    implements $PupilCopyWith<$Res> {
  _$PupilCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? group = freezed,
    Object? schoolyear = freezed,
    Object? specialNeeds = freezed,
    Object? gender = freezed,
    Object? language = freezed,
    Object? family = freezed,
    Object? birthday = freezed,
    Object? migrationSupportEnds = freezed,
    Object? pupilSince = freezed,
    Object? avatarUrl = freezed,
    Object? communicationPupil = freezed,
    Object? communicationTutor1 = freezed,
    Object? communicationTutor2 = freezed,
    Object? contact = freezed,
    Object? parentsContact = freezed,
    Object? credit = null,
    Object? creditEarned = null,
    Object? fiveYears = freezed,
    Object? individualDevelopmentPlan = null,
    Object? internalId = null,
    Object? ogs = null,
    Object? ogsInfo = freezed,
    Object? pickUpTime = freezed,
    Object? preschoolRevision = freezed,
    Object? specialInformation = freezed,
    Object? competenceChecks = freezed,
    Object? pupilCategoryStatuses = freezed,
    Object? pupilAdmonitions = freezed,
    Object? pupilBooks = freezed,
    Object? pupilLists = freezed,
    Object? pupilGoals = freezed,
    Object? pupilMissedClasses = freezed,
    Object? pupilWorkbooks = freezed,
    Object? authorizations = freezed,
    Object? creditHistoryLogs = freezed,
    Object? competenceGoals = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      schoolyear: freezed == schoolyear
          ? _value.schoolyear
          : schoolyear // ignore: cast_nullable_to_non_nullable
              as String?,
      specialNeeds: freezed == specialNeeds
          ? _value.specialNeeds
          : specialNeeds // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      family: freezed == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      migrationSupportEnds: freezed == migrationSupportEnds
          ? _value.migrationSupportEnds
          : migrationSupportEnds // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pupilSince: freezed == pupilSince
          ? _value.pupilSince
          : pupilSince // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      communicationPupil: freezed == communicationPupil
          ? _value.communicationPupil
          : communicationPupil // ignore: cast_nullable_to_non_nullable
              as String?,
      communicationTutor1: freezed == communicationTutor1
          ? _value.communicationTutor1
          : communicationTutor1 // ignore: cast_nullable_to_non_nullable
              as String?,
      communicationTutor2: freezed == communicationTutor2
          ? _value.communicationTutor2
          : communicationTutor2 // ignore: cast_nullable_to_non_nullable
              as String?,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String?,
      parentsContact: freezed == parentsContact
          ? _value.parentsContact
          : parentsContact // ignore: cast_nullable_to_non_nullable
              as String?,
      credit: null == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as int,
      creditEarned: null == creditEarned
          ? _value.creditEarned
          : creditEarned // ignore: cast_nullable_to_non_nullable
              as int,
      fiveYears: freezed == fiveYears
          ? _value.fiveYears
          : fiveYears // ignore: cast_nullable_to_non_nullable
              as String?,
      individualDevelopmentPlan: null == individualDevelopmentPlan
          ? _value.individualDevelopmentPlan
          : individualDevelopmentPlan // ignore: cast_nullable_to_non_nullable
              as int,
      internalId: null == internalId
          ? _value.internalId
          : internalId // ignore: cast_nullable_to_non_nullable
              as int,
      ogs: null == ogs
          ? _value.ogs
          : ogs // ignore: cast_nullable_to_non_nullable
              as bool,
      ogsInfo: freezed == ogsInfo
          ? _value.ogsInfo
          : ogsInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      pickUpTime: freezed == pickUpTime
          ? _value.pickUpTime
          : pickUpTime // ignore: cast_nullable_to_non_nullable
              as String?,
      preschoolRevision: freezed == preschoolRevision
          ? _value.preschoolRevision
          : preschoolRevision // ignore: cast_nullable_to_non_nullable
              as int?,
      specialInformation: freezed == specialInformation
          ? _value.specialInformation
          : specialInformation // ignore: cast_nullable_to_non_nullable
              as String?,
      competenceChecks: freezed == competenceChecks
          ? _value.competenceChecks
          : competenceChecks // ignore: cast_nullable_to_non_nullable
              as List<CompetenceCheck>?,
      pupilCategoryStatuses: freezed == pupilCategoryStatuses
          ? _value.pupilCategoryStatuses
          : pupilCategoryStatuses // ignore: cast_nullable_to_non_nullable
              as List<PupilCategoryStatus>?,
      pupilAdmonitions: freezed == pupilAdmonitions
          ? _value.pupilAdmonitions
          : pupilAdmonitions // ignore: cast_nullable_to_non_nullable
              as List<Admonition>?,
      pupilBooks: freezed == pupilBooks
          ? _value.pupilBooks
          : pupilBooks // ignore: cast_nullable_to_non_nullable
              as List<PupilBook>?,
      pupilLists: freezed == pupilLists
          ? _value.pupilLists
          : pupilLists // ignore: cast_nullable_to_non_nullable
              as List<PupilList>?,
      pupilGoals: freezed == pupilGoals
          ? _value.pupilGoals
          : pupilGoals // ignore: cast_nullable_to_non_nullable
              as List<PupilGoal>?,
      pupilMissedClasses: freezed == pupilMissedClasses
          ? _value.pupilMissedClasses
          : pupilMissedClasses // ignore: cast_nullable_to_non_nullable
              as List<MissedClass>?,
      pupilWorkbooks: freezed == pupilWorkbooks
          ? _value.pupilWorkbooks
          : pupilWorkbooks // ignore: cast_nullable_to_non_nullable
              as List<PupilWorkbook>?,
      authorizations: freezed == authorizations
          ? _value.authorizations
          : authorizations // ignore: cast_nullable_to_non_nullable
              as List<PupilAuthorization>?,
      creditHistoryLogs: freezed == creditHistoryLogs
          ? _value.creditHistoryLogs
          : creditHistoryLogs // ignore: cast_nullable_to_non_nullable
              as List<CreditHistoryLog>?,
      competenceGoals: freezed == competenceGoals
          ? _value.competenceGoals
          : competenceGoals // ignore: cast_nullable_to_non_nullable
              as List<CompetenceGoal>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PupilImplCopyWith<$Res> implements $PupilCopyWith<$Res> {
  factory _$$PupilImplCopyWith(
          _$PupilImpl value, $Res Function(_$PupilImpl) then) =
      __$$PupilImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? firstName,
      String? lastName,
      String? group,
      String? schoolyear,
      String? specialNeeds,
      String? gender,
      String? language,
      String? family,
      DateTime? birthday,
      DateTime? migrationSupportEnds,
      DateTime? pupilSince,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'communication_pupil') String? communicationPupil,
      @JsonKey(name: 'communication_tutor1') String? communicationTutor1,
      @JsonKey(name: 'communication_tutor2') String? communicationTutor2,
      @JsonKey(name: 'contact') String? contact,
      @JsonKey(name: 'parents_contact') String? parentsContact,
      int credit,
      @JsonKey(name: 'credit_earned') int creditEarned,
      @JsonKey(name: 'five_years') String? fiveYears,
      @JsonKey(name: 'individual_development_plan')
      int individualDevelopmentPlan,
      @JsonKey(name: 'internal_id') int internalId,
      bool ogs,
      @JsonKey(name: 'ogs_info') String? ogsInfo,
      @JsonKey(name: 'pick_up_time') String? pickUpTime,
      @JsonKey(name: 'preschool_revision') int? preschoolRevision,
      @JsonKey(name: 'special_information') String? specialInformation,
      @JsonKey(name: 'competence_checks')
      List<CompetenceCheck>? competenceChecks,
      @JsonKey(name: 'pupil_category_statuses')
      List<PupilCategoryStatus>? pupilCategoryStatuses,
      @JsonKey(name: 'pupil_admonitions') List<Admonition>? pupilAdmonitions,
      @JsonKey(name: 'pupil_books') List<PupilBook>? pupilBooks,
      @JsonKey(name: 'pupil_lists') List<PupilList>? pupilLists,
      @JsonKey(name: 'pupil_goals') List<PupilGoal>? pupilGoals,
      @JsonKey(name: 'pupil_missed_classes')
      List<MissedClass>? pupilMissedClasses,
      @JsonKey(name: 'pupil_workbooks') List<PupilWorkbook>? pupilWorkbooks,
      List<PupilAuthorization>? authorizations,
      @JsonKey(name: "credit_history_logs")
      List<CreditHistoryLog>? creditHistoryLogs,
      @JsonKey(name: "competence_goals")
      List<CompetenceGoal>? competenceGoals});
}

/// @nodoc
class __$$PupilImplCopyWithImpl<$Res>
    extends _$PupilCopyWithImpl<$Res, _$PupilImpl>
    implements _$$PupilImplCopyWith<$Res> {
  __$$PupilImplCopyWithImpl(
      _$PupilImpl _value, $Res Function(_$PupilImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? group = freezed,
    Object? schoolyear = freezed,
    Object? specialNeeds = freezed,
    Object? gender = freezed,
    Object? language = freezed,
    Object? family = freezed,
    Object? birthday = freezed,
    Object? migrationSupportEnds = freezed,
    Object? pupilSince = freezed,
    Object? avatarUrl = freezed,
    Object? communicationPupil = freezed,
    Object? communicationTutor1 = freezed,
    Object? communicationTutor2 = freezed,
    Object? contact = freezed,
    Object? parentsContact = freezed,
    Object? credit = null,
    Object? creditEarned = null,
    Object? fiveYears = freezed,
    Object? individualDevelopmentPlan = null,
    Object? internalId = null,
    Object? ogs = null,
    Object? ogsInfo = freezed,
    Object? pickUpTime = freezed,
    Object? preschoolRevision = freezed,
    Object? specialInformation = freezed,
    Object? competenceChecks = freezed,
    Object? pupilCategoryStatuses = freezed,
    Object? pupilAdmonitions = freezed,
    Object? pupilBooks = freezed,
    Object? pupilLists = freezed,
    Object? pupilGoals = freezed,
    Object? pupilMissedClasses = freezed,
    Object? pupilWorkbooks = freezed,
    Object? authorizations = freezed,
    Object? creditHistoryLogs = freezed,
    Object? competenceGoals = freezed,
  }) {
    return _then(_$PupilImpl(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      schoolyear: freezed == schoolyear
          ? _value.schoolyear
          : schoolyear // ignore: cast_nullable_to_non_nullable
              as String?,
      specialNeeds: freezed == specialNeeds
          ? _value.specialNeeds
          : specialNeeds // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      family: freezed == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      migrationSupportEnds: freezed == migrationSupportEnds
          ? _value.migrationSupportEnds
          : migrationSupportEnds // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pupilSince: freezed == pupilSince
          ? _value.pupilSince
          : pupilSince // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      communicationPupil: freezed == communicationPupil
          ? _value.communicationPupil
          : communicationPupil // ignore: cast_nullable_to_non_nullable
              as String?,
      communicationTutor1: freezed == communicationTutor1
          ? _value.communicationTutor1
          : communicationTutor1 // ignore: cast_nullable_to_non_nullable
              as String?,
      communicationTutor2: freezed == communicationTutor2
          ? _value.communicationTutor2
          : communicationTutor2 // ignore: cast_nullable_to_non_nullable
              as String?,
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String?,
      parentsContact: freezed == parentsContact
          ? _value.parentsContact
          : parentsContact // ignore: cast_nullable_to_non_nullable
              as String?,
      credit: null == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as int,
      creditEarned: null == creditEarned
          ? _value.creditEarned
          : creditEarned // ignore: cast_nullable_to_non_nullable
              as int,
      fiveYears: freezed == fiveYears
          ? _value.fiveYears
          : fiveYears // ignore: cast_nullable_to_non_nullable
              as String?,
      individualDevelopmentPlan: null == individualDevelopmentPlan
          ? _value.individualDevelopmentPlan
          : individualDevelopmentPlan // ignore: cast_nullable_to_non_nullable
              as int,
      internalId: null == internalId
          ? _value.internalId
          : internalId // ignore: cast_nullable_to_non_nullable
              as int,
      ogs: null == ogs
          ? _value.ogs
          : ogs // ignore: cast_nullable_to_non_nullable
              as bool,
      ogsInfo: freezed == ogsInfo
          ? _value.ogsInfo
          : ogsInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      pickUpTime: freezed == pickUpTime
          ? _value.pickUpTime
          : pickUpTime // ignore: cast_nullable_to_non_nullable
              as String?,
      preschoolRevision: freezed == preschoolRevision
          ? _value.preschoolRevision
          : preschoolRevision // ignore: cast_nullable_to_non_nullable
              as int?,
      specialInformation: freezed == specialInformation
          ? _value.specialInformation
          : specialInformation // ignore: cast_nullable_to_non_nullable
              as String?,
      competenceChecks: freezed == competenceChecks
          ? _value._competenceChecks
          : competenceChecks // ignore: cast_nullable_to_non_nullable
              as List<CompetenceCheck>?,
      pupilCategoryStatuses: freezed == pupilCategoryStatuses
          ? _value._pupilCategoryStatuses
          : pupilCategoryStatuses // ignore: cast_nullable_to_non_nullable
              as List<PupilCategoryStatus>?,
      pupilAdmonitions: freezed == pupilAdmonitions
          ? _value._pupilAdmonitions
          : pupilAdmonitions // ignore: cast_nullable_to_non_nullable
              as List<Admonition>?,
      pupilBooks: freezed == pupilBooks
          ? _value._pupilBooks
          : pupilBooks // ignore: cast_nullable_to_non_nullable
              as List<PupilBook>?,
      pupilLists: freezed == pupilLists
          ? _value._pupilLists
          : pupilLists // ignore: cast_nullable_to_non_nullable
              as List<PupilList>?,
      pupilGoals: freezed == pupilGoals
          ? _value._pupilGoals
          : pupilGoals // ignore: cast_nullable_to_non_nullable
              as List<PupilGoal>?,
      pupilMissedClasses: freezed == pupilMissedClasses
          ? _value._pupilMissedClasses
          : pupilMissedClasses // ignore: cast_nullable_to_non_nullable
              as List<MissedClass>?,
      pupilWorkbooks: freezed == pupilWorkbooks
          ? _value._pupilWorkbooks
          : pupilWorkbooks // ignore: cast_nullable_to_non_nullable
              as List<PupilWorkbook>?,
      authorizations: freezed == authorizations
          ? _value._authorizations
          : authorizations // ignore: cast_nullable_to_non_nullable
              as List<PupilAuthorization>?,
      creditHistoryLogs: freezed == creditHistoryLogs
          ? _value._creditHistoryLogs
          : creditHistoryLogs // ignore: cast_nullable_to_non_nullable
              as List<CreditHistoryLog>?,
      competenceGoals: freezed == competenceGoals
          ? _value._competenceGoals
          : competenceGoals // ignore: cast_nullable_to_non_nullable
              as List<CompetenceGoal>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PupilImpl implements _Pupil {
  _$PupilImpl(
      {this.firstName,
      this.lastName,
      this.group,
      this.schoolyear,
      this.specialNeeds,
      this.gender,
      this.language,
      this.family,
      this.birthday,
      this.migrationSupportEnds,
      this.pupilSince,
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      @JsonKey(name: 'communication_pupil') this.communicationPupil,
      @JsonKey(name: 'communication_tutor1') this.communicationTutor1,
      @JsonKey(name: 'communication_tutor2') this.communicationTutor2,
      @JsonKey(name: 'contact') this.contact,
      @JsonKey(name: 'parents_contact') this.parentsContact,
      required this.credit,
      @JsonKey(name: 'credit_earned') required this.creditEarned,
      @JsonKey(name: 'five_years') this.fiveYears,
      @JsonKey(name: 'individual_development_plan')
      required this.individualDevelopmentPlan,
      @JsonKey(name: 'internal_id') required this.internalId,
      required this.ogs,
      @JsonKey(name: 'ogs_info') this.ogsInfo,
      @JsonKey(name: 'pick_up_time') this.pickUpTime,
      @JsonKey(name: 'preschool_revision') this.preschoolRevision,
      @JsonKey(name: 'special_information') this.specialInformation,
      @JsonKey(name: 'competence_checks')
      final List<CompetenceCheck>? competenceChecks,
      @JsonKey(name: 'pupil_category_statuses')
      final List<PupilCategoryStatus>? pupilCategoryStatuses,
      @JsonKey(name: 'pupil_admonitions')
      final List<Admonition>? pupilAdmonitions,
      @JsonKey(name: 'pupil_books') final List<PupilBook>? pupilBooks,
      @JsonKey(name: 'pupil_lists') final List<PupilList>? pupilLists,
      @JsonKey(name: 'pupil_goals') final List<PupilGoal>? pupilGoals,
      @JsonKey(name: 'pupil_missed_classes')
      final List<MissedClass>? pupilMissedClasses,
      @JsonKey(name: 'pupil_workbooks')
      final List<PupilWorkbook>? pupilWorkbooks,
      final List<PupilAuthorization>? authorizations,
      @JsonKey(name: "credit_history_logs")
      final List<CreditHistoryLog>? creditHistoryLogs,
      @JsonKey(name: "competence_goals")
      final List<CompetenceGoal>? competenceGoals})
      : _competenceChecks = competenceChecks,
        _pupilCategoryStatuses = pupilCategoryStatuses,
        _pupilAdmonitions = pupilAdmonitions,
        _pupilBooks = pupilBooks,
        _pupilLists = pupilLists,
        _pupilGoals = pupilGoals,
        _pupilMissedClasses = pupilMissedClasses,
        _pupilWorkbooks = pupilWorkbooks,
        _authorizations = authorizations,
        _creditHistoryLogs = creditHistoryLogs,
        _competenceGoals = competenceGoals;

  factory _$PupilImpl.fromJson(Map<String, dynamic> json) =>
      _$$PupilImplFromJson(json);

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? group;
  @override
  final String? schoolyear;
  @override
  final String? specialNeeds;
  @override
  final String? gender;
  @override
  final String? language;
  @override
  final String? family;
  @override
  final DateTime? birthday;
  @override
  final DateTime? migrationSupportEnds;
  @override
  final DateTime? pupilSince;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'communication_pupil')
  final String? communicationPupil;
  @override
  @JsonKey(name: 'communication_tutor1')
  final String? communicationTutor1;
  @override
  @JsonKey(name: 'communication_tutor2')
  final String? communicationTutor2;
  @override
  @JsonKey(name: 'contact')
  final String? contact;
  @override
  @JsonKey(name: 'parents_contact')
  final String? parentsContact;
  @override
  final int credit;
  @override
  @JsonKey(name: 'credit_earned')
  final int creditEarned;
  @override
  @JsonKey(name: 'five_years')
  final String? fiveYears;
  @override
  @JsonKey(name: 'individual_development_plan')
  final int individualDevelopmentPlan;
  @override
  @JsonKey(name: 'internal_id')
  final int internalId;
  @override
  final bool ogs;
  @override
  @JsonKey(name: 'ogs_info')
  final String? ogsInfo;
  @override
  @JsonKey(name: 'pick_up_time')
  final String? pickUpTime;
  @override
  @JsonKey(name: 'preschool_revision')
  final int? preschoolRevision;
  @override
  @JsonKey(name: 'special_information')
  final String? specialInformation;
  final List<CompetenceCheck>? _competenceChecks;
  @override
  @JsonKey(name: 'competence_checks')
  List<CompetenceCheck>? get competenceChecks {
    final value = _competenceChecks;
    if (value == null) return null;
    if (_competenceChecks is EqualUnmodifiableListView)
      return _competenceChecks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PupilCategoryStatus>? _pupilCategoryStatuses;
  @override
  @JsonKey(name: 'pupil_category_statuses')
  List<PupilCategoryStatus>? get pupilCategoryStatuses {
    final value = _pupilCategoryStatuses;
    if (value == null) return null;
    if (_pupilCategoryStatuses is EqualUnmodifiableListView)
      return _pupilCategoryStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Admonition>? _pupilAdmonitions;
  @override
  @JsonKey(name: 'pupil_admonitions')
  List<Admonition>? get pupilAdmonitions {
    final value = _pupilAdmonitions;
    if (value == null) return null;
    if (_pupilAdmonitions is EqualUnmodifiableListView)
      return _pupilAdmonitions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PupilBook>? _pupilBooks;
  @override
  @JsonKey(name: 'pupil_books')
  List<PupilBook>? get pupilBooks {
    final value = _pupilBooks;
    if (value == null) return null;
    if (_pupilBooks is EqualUnmodifiableListView) return _pupilBooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PupilList>? _pupilLists;
  @override
  @JsonKey(name: 'pupil_lists')
  List<PupilList>? get pupilLists {
    final value = _pupilLists;
    if (value == null) return null;
    if (_pupilLists is EqualUnmodifiableListView) return _pupilLists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PupilGoal>? _pupilGoals;
  @override
  @JsonKey(name: 'pupil_goals')
  List<PupilGoal>? get pupilGoals {
    final value = _pupilGoals;
    if (value == null) return null;
    if (_pupilGoals is EqualUnmodifiableListView) return _pupilGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MissedClass>? _pupilMissedClasses;
  @override
  @JsonKey(name: 'pupil_missed_classes')
  List<MissedClass>? get pupilMissedClasses {
    final value = _pupilMissedClasses;
    if (value == null) return null;
    if (_pupilMissedClasses is EqualUnmodifiableListView)
      return _pupilMissedClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PupilWorkbook>? _pupilWorkbooks;
  @override
  @JsonKey(name: 'pupil_workbooks')
  List<PupilWorkbook>? get pupilWorkbooks {
    final value = _pupilWorkbooks;
    if (value == null) return null;
    if (_pupilWorkbooks is EqualUnmodifiableListView) return _pupilWorkbooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PupilAuthorization>? _authorizations;
  @override
  List<PupilAuthorization>? get authorizations {
    final value = _authorizations;
    if (value == null) return null;
    if (_authorizations is EqualUnmodifiableListView) return _authorizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CreditHistoryLog>? _creditHistoryLogs;
  @override
  @JsonKey(name: "credit_history_logs")
  List<CreditHistoryLog>? get creditHistoryLogs {
    final value = _creditHistoryLogs;
    if (value == null) return null;
    if (_creditHistoryLogs is EqualUnmodifiableListView)
      return _creditHistoryLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CompetenceGoal>? _competenceGoals;
  @override
  @JsonKey(name: "competence_goals")
  List<CompetenceGoal>? get competenceGoals {
    final value = _competenceGoals;
    if (value == null) return null;
    if (_competenceGoals is EqualUnmodifiableListView) return _competenceGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Pupil(firstName: $firstName, lastName: $lastName, group: $group, schoolyear: $schoolyear, specialNeeds: $specialNeeds, gender: $gender, language: $language, family: $family, birthday: $birthday, migrationSupportEnds: $migrationSupportEnds, pupilSince: $pupilSince, avatarUrl: $avatarUrl, communicationPupil: $communicationPupil, communicationTutor1: $communicationTutor1, communicationTutor2: $communicationTutor2, contact: $contact, parentsContact: $parentsContact, credit: $credit, creditEarned: $creditEarned, fiveYears: $fiveYears, individualDevelopmentPlan: $individualDevelopmentPlan, internalId: $internalId, ogs: $ogs, ogsInfo: $ogsInfo, pickUpTime: $pickUpTime, preschoolRevision: $preschoolRevision, specialInformation: $specialInformation, competenceChecks: $competenceChecks, pupilCategoryStatuses: $pupilCategoryStatuses, pupilAdmonitions: $pupilAdmonitions, pupilBooks: $pupilBooks, pupilLists: $pupilLists, pupilGoals: $pupilGoals, pupilMissedClasses: $pupilMissedClasses, pupilWorkbooks: $pupilWorkbooks, authorizations: $authorizations, creditHistoryLogs: $creditHistoryLogs, competenceGoals: $competenceGoals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PupilImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.schoolyear, schoolyear) ||
                other.schoolyear == schoolyear) &&
            (identical(other.specialNeeds, specialNeeds) ||
                other.specialNeeds == specialNeeds) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.migrationSupportEnds, migrationSupportEnds) ||
                other.migrationSupportEnds == migrationSupportEnds) &&
            (identical(other.pupilSince, pupilSince) ||
                other.pupilSince == pupilSince) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.communicationPupil, communicationPupil) ||
                other.communicationPupil == communicationPupil) &&
            (identical(other.communicationTutor1, communicationTutor1) ||
                other.communicationTutor1 == communicationTutor1) &&
            (identical(other.communicationTutor2, communicationTutor2) ||
                other.communicationTutor2 == communicationTutor2) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.parentsContact, parentsContact) ||
                other.parentsContact == parentsContact) &&
            (identical(other.credit, credit) || other.credit == credit) &&
            (identical(other.creditEarned, creditEarned) ||
                other.creditEarned == creditEarned) &&
            (identical(other.fiveYears, fiveYears) ||
                other.fiveYears == fiveYears) &&
            (identical(other.individualDevelopmentPlan,
                    individualDevelopmentPlan) ||
                other.individualDevelopmentPlan == individualDevelopmentPlan) &&
            (identical(other.internalId, internalId) ||
                other.internalId == internalId) &&
            (identical(other.ogs, ogs) || other.ogs == ogs) &&
            (identical(other.ogsInfo, ogsInfo) || other.ogsInfo == ogsInfo) &&
            (identical(other.pickUpTime, pickUpTime) ||
                other.pickUpTime == pickUpTime) &&
            (identical(other.preschoolRevision, preschoolRevision) ||
                other.preschoolRevision == preschoolRevision) &&
            (identical(other.specialInformation, specialInformation) ||
                other.specialInformation == specialInformation) &&
            const DeepCollectionEquality()
                .equals(other._competenceChecks, _competenceChecks) &&
            const DeepCollectionEquality()
                .equals(other._pupilCategoryStatuses, _pupilCategoryStatuses) &&
            const DeepCollectionEquality()
                .equals(other._pupilAdmonitions, _pupilAdmonitions) &&
            const DeepCollectionEquality()
                .equals(other._pupilBooks, _pupilBooks) &&
            const DeepCollectionEquality()
                .equals(other._pupilLists, _pupilLists) &&
            const DeepCollectionEquality()
                .equals(other._pupilGoals, _pupilGoals) &&
            const DeepCollectionEquality()
                .equals(other._pupilMissedClasses, _pupilMissedClasses) &&
            const DeepCollectionEquality()
                .equals(other._pupilWorkbooks, _pupilWorkbooks) &&
            const DeepCollectionEquality()
                .equals(other._authorizations, _authorizations) &&
            const DeepCollectionEquality()
                .equals(other._creditHistoryLogs, _creditHistoryLogs) &&
            const DeepCollectionEquality()
                .equals(other._competenceGoals, _competenceGoals));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        firstName,
        lastName,
        group,
        schoolyear,
        specialNeeds,
        gender,
        language,
        family,
        birthday,
        migrationSupportEnds,
        pupilSince,
        avatarUrl,
        communicationPupil,
        communicationTutor1,
        communicationTutor2,
        contact,
        parentsContact,
        credit,
        creditEarned,
        fiveYears,
        individualDevelopmentPlan,
        internalId,
        ogs,
        ogsInfo,
        pickUpTime,
        preschoolRevision,
        specialInformation,
        const DeepCollectionEquality().hash(_competenceChecks),
        const DeepCollectionEquality().hash(_pupilCategoryStatuses),
        const DeepCollectionEquality().hash(_pupilAdmonitions),
        const DeepCollectionEquality().hash(_pupilBooks),
        const DeepCollectionEquality().hash(_pupilLists),
        const DeepCollectionEquality().hash(_pupilGoals),
        const DeepCollectionEquality().hash(_pupilMissedClasses),
        const DeepCollectionEquality().hash(_pupilWorkbooks),
        const DeepCollectionEquality().hash(_authorizations),
        const DeepCollectionEquality().hash(_creditHistoryLogs),
        const DeepCollectionEquality().hash(_competenceGoals)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PupilImplCopyWith<_$PupilImpl> get copyWith =>
      __$$PupilImplCopyWithImpl<_$PupilImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PupilImplToJson(
      this,
    );
  }
}

abstract class _Pupil implements Pupil {
  factory _Pupil(
      {final String? firstName,
      final String? lastName,
      final String? group,
      final String? schoolyear,
      final String? specialNeeds,
      final String? gender,
      final String? language,
      final String? family,
      final DateTime? birthday,
      final DateTime? migrationSupportEnds,
      final DateTime? pupilSince,
      @JsonKey(name: 'avatar_url') final String? avatarUrl,
      @JsonKey(name: 'communication_pupil') final String? communicationPupil,
      @JsonKey(name: 'communication_tutor1') final String? communicationTutor1,
      @JsonKey(name: 'communication_tutor2') final String? communicationTutor2,
      @JsonKey(name: 'contact') final String? contact,
      @JsonKey(name: 'parents_contact') final String? parentsContact,
      required final int credit,
      @JsonKey(name: 'credit_earned') required final int creditEarned,
      @JsonKey(name: 'five_years') final String? fiveYears,
      @JsonKey(name: 'individual_development_plan')
      required final int individualDevelopmentPlan,
      @JsonKey(name: 'internal_id') required final int internalId,
      required final bool ogs,
      @JsonKey(name: 'ogs_info') final String? ogsInfo,
      @JsonKey(name: 'pick_up_time') final String? pickUpTime,
      @JsonKey(name: 'preschool_revision') final int? preschoolRevision,
      @JsonKey(name: 'special_information') final String? specialInformation,
      @JsonKey(name: 'competence_checks')
      final List<CompetenceCheck>? competenceChecks,
      @JsonKey(name: 'pupil_category_statuses')
      final List<PupilCategoryStatus>? pupilCategoryStatuses,
      @JsonKey(name: 'pupil_admonitions')
      final List<Admonition>? pupilAdmonitions,
      @JsonKey(name: 'pupil_books') final List<PupilBook>? pupilBooks,
      @JsonKey(name: 'pupil_lists') final List<PupilList>? pupilLists,
      @JsonKey(name: 'pupil_goals') final List<PupilGoal>? pupilGoals,
      @JsonKey(name: 'pupil_missed_classes')
      final List<MissedClass>? pupilMissedClasses,
      @JsonKey(name: 'pupil_workbooks')
      final List<PupilWorkbook>? pupilWorkbooks,
      final List<PupilAuthorization>? authorizations,
      @JsonKey(name: "credit_history_logs")
      final List<CreditHistoryLog>? creditHistoryLogs,
      @JsonKey(name: "competence_goals")
      final List<CompetenceGoal>? competenceGoals}) = _$PupilImpl;

  factory _Pupil.fromJson(Map<String, dynamic> json) = _$PupilImpl.fromJson;

  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get group;
  @override
  String? get schoolyear;
  @override
  String? get specialNeeds;
  @override
  String? get gender;
  @override
  String? get language;
  @override
  String? get family;
  @override
  DateTime? get birthday;
  @override
  DateTime? get migrationSupportEnds;
  @override
  DateTime? get pupilSince;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'communication_pupil')
  String? get communicationPupil;
  @override
  @JsonKey(name: 'communication_tutor1')
  String? get communicationTutor1;
  @override
  @JsonKey(name: 'communication_tutor2')
  String? get communicationTutor2;
  @override
  @JsonKey(name: 'contact')
  String? get contact;
  @override
  @JsonKey(name: 'parents_contact')
  String? get parentsContact;
  @override
  int get credit;
  @override
  @JsonKey(name: 'credit_earned')
  int get creditEarned;
  @override
  @JsonKey(name: 'five_years')
  String? get fiveYears;
  @override
  @JsonKey(name: 'individual_development_plan')
  int get individualDevelopmentPlan;
  @override
  @JsonKey(name: 'internal_id')
  int get internalId;
  @override
  bool get ogs;
  @override
  @JsonKey(name: 'ogs_info')
  String? get ogsInfo;
  @override
  @JsonKey(name: 'pick_up_time')
  String? get pickUpTime;
  @override
  @JsonKey(name: 'preschool_revision')
  int? get preschoolRevision;
  @override
  @JsonKey(name: 'special_information')
  String? get specialInformation;
  @override
  @JsonKey(name: 'competence_checks')
  List<CompetenceCheck>? get competenceChecks;
  @override
  @JsonKey(name: 'pupil_category_statuses')
  List<PupilCategoryStatus>? get pupilCategoryStatuses;
  @override
  @JsonKey(name: 'pupil_admonitions')
  List<Admonition>? get pupilAdmonitions;
  @override
  @JsonKey(name: 'pupil_books')
  List<PupilBook>? get pupilBooks;
  @override
  @JsonKey(name: 'pupil_lists')
  List<PupilList>? get pupilLists;
  @override
  @JsonKey(name: 'pupil_goals')
  List<PupilGoal>? get pupilGoals;
  @override
  @JsonKey(name: 'pupil_missed_classes')
  List<MissedClass>? get pupilMissedClasses;
  @override
  @JsonKey(name: 'pupil_workbooks')
  List<PupilWorkbook>? get pupilWorkbooks;
  @override
  List<PupilAuthorization>? get authorizations;
  @override
  @JsonKey(name: "credit_history_logs")
  List<CreditHistoryLog>? get creditHistoryLogs;
  @override
  @JsonKey(name: "competence_goals")
  List<CompetenceGoal>? get competenceGoals;
  @override
  @JsonKey(ignore: true)
  _$$PupilImplCopyWith<_$PupilImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
