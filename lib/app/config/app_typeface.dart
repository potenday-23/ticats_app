import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

class AppTypeface {
  // Title
  static TextStyle get title28Medium => TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500, height: 1.57, color: AppColor.black);
  static TextStyle get title26Semibold => TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600, height: 1.38, color: AppColor.black);

  // Headline
  static TextStyle get headline24Bold => TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, height: 1.5, color: AppColor.black);
  static TextStyle get headline24Medium => TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, height: 1.41, color: AppColor.black);

  // Body
  static TextStyle get body20Bold => TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, height: 1.5, color: AppColor.black);
  static TextStyle get body18Bold => TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, height: 1.55, color: AppColor.black);
  static TextStyle get body18Semibold => TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, height: 1.55, color: AppColor.black);

  // Label
  static TextStyle get label16Semibold => TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.625, color: AppColor.black);
  static TextStyle get label14Bold => TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, height: 1.57, color: AppColor.black);
  static TextStyle get label14Medium => TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 1.57, color: AppColor.black);
  static TextStyle get label12Bold => TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, height: 1.5, color: AppColor.black);
  static TextStyle get label12SemiBold => TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, height: 1.5, color: AppColor.black);
  static TextStyle get label12Medium => TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, height: 1.5, color: AppColor.black);
  static TextStyle get label12Regular => TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, height: 1.5, color: AppColor.black);
}
