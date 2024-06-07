### Pupil models

Personal data (`PupilIdentity`) and sensitive data (`PupilData`) are handled separatedly and only combined in the UI. 

#### PupilIdentity

The class has these properties:

- first name
- last name
- group (school class)
- grade (school year)
- special needs
- gender
- language
- family code (for siblings belonging to the same family/tutor)
- birthday
- migration support end date (pupils coming to our school without German skills have the right to two years of special tutoring)
- enrollment date

The .txt takes one line per pupil with this format:

```
internalId,firstName,lastName,group,schoolGrade,specialNeeds,gender,language,family,birthday,migrationSupportEnds,pupilSince

```
You can see here the implementation of the import process:

 https://github.com/dabblingwithcode/school_data_hub_frontend/blob/34108d920c9e8d8c54950c84753372ce156c08b7/lib/features/pupil/manager/pupil_identity_manager.dart#L121

  
