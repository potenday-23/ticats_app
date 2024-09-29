extension InputValidator on String {
  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(this);
  }

  // 닉네임 검증(2 ~ 10자의 한글, 영문)
  String? isValidNick() {
    if (isEmpty) {
      return "닉네임을 입력해주세요.";
    }
    if (length < 2) {
      return "닉네임은 2자 이상이어야 합니다.";
    }
    if (length > 10) {
      return "닉네임은 10자 이하여야 합니다.";
    }
    if (!RegExp(r"^[A-Za-z가-힣]{2,10}$").hasMatch(this)) {
      return "닉네임에는 영어와 한글만 사용할 수 있습니다.";
    }
    return null;
  }

  bool isValidBirth() {
    return RegExp(r"^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12][0-9]|3[01]))$").hasMatch(this);
  }
}
