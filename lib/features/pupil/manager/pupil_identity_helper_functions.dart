import 'package:schuldaten_hub/features/pupil/models/pupil_personal_data.dart';

PupilIdentity pupilIdentityFromString(String pupilIdentityAsString) {
  List<String> splittedData = pupilIdentityAsString.split(',');
  //-TODO implement enum for the schoolyear
  final schoolyear = splittedData[4] == '03'
      ? 'S3'
      : splittedData[4] == '04'
          ? 'S4'
          : splittedData[4];
  final newPupilIdentity = PupilIdentity(
    id: int.parse(splittedData[0]),
    name: splittedData[1],
    lastName: splittedData[2],
    group: splittedData[3],
    schoolyear: schoolyear,
    specialNeeds:
        splittedData[5] == '' ? null : '${splittedData[5]}${splittedData[6]}',
    gender: splittedData[7],
    language: splittedData[8],
    family: splittedData[9] == '' ? null : splittedData[9],
    birthday: DateTime.tryParse(splittedData[10])!,
    migrationSupportEnds:
        splittedData[11] == '' ? null : DateTime.tryParse(splittedData[11])!,
    pupilSince: DateTime.tryParse(splittedData[12])!,
  );
  return newPupilIdentity;
}
