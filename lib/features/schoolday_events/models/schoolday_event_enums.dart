enum SchooldayEventType {
  notSet('choose'),
  parentsMeeting('Eg'),
  admonition('rk'),
  afternoonCareAdmonition('rkogs'),
  admonitionAndBanned('rkabh'),
  otherEvent('other');

  final String value;
  const SchooldayEventType(this.value);
}

enum SchooldayEventReason {
  violenceAgainstPupils('gm'),
  violenceAgainstTeachers('gl'),
  violenceAgainstThings('gs'),
  insultOthers('ab'),
  dangerousBehaviour('gv'),
  annoyOthers('äa'),
  ignoreInstructions('il'),
  disturbLesson('us'),
  other('ss'),
  learningDevelopmentInfo('le'),
  learningSupportInfo('fi'),

  admonitionInfo('ki');

  final String value;
  const SchooldayEventReason(this.value);
}
