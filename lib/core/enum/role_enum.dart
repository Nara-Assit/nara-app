enum RoleEnum {
  doctor('DOCTOR', 'طبيب'),
  deaf('DEAF', 'أصم'),
  cochlearImplant('COCHLEAR_IMPLANT', 'زراعة قوقعة'),
  parent('PARENT', 'ولي أمر'),
  specialist('SPECIALIST', 'أخصائي'),
  mute('MUTE', 'أبكم')
  ;

  final String apiValue;
  final String arabicName;

  const RoleEnum(this.apiValue, this.arabicName);
}
