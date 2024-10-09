import 'package:flutter/material.dart';

enum SSOType {
  kakao("카카오", Color(0xFFFFE300)),
  google("Google", Colors.white),
  apple("Apple", Colors.black, Colors.white);

  final String label;
  final Color bgColor;
  final Color textColor;

  const SSOType(this.label, this.bgColor, [this.textColor = Colors.black]);
}
