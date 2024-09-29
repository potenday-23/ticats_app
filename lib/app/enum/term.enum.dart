enum TermEnum {
  termOfUse("서비스 이용약관", true),
  privacyPolicy("개인정보 수집 및 이용", true),
  locationPolicy("위치기반 서비스 이용약관", true),
  marketingPolicy("마케팅 정보 수신 및 이용", false);

  const TermEnum(this.text, this.isRequired);

  final String text;
  final bool isRequired;
}
