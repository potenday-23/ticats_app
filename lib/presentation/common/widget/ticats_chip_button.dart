import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';

class TicatsChipButton extends StatelessWidget {
  const TicatsChipButton({
    super.key,
    this.isEnabled = true,
    this.isSelected = false,
    required this.text,
    required this.onPressed,
  });

  final bool isEnabled;
  final bool isSelected;
  final String text;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: GestureDetector(
        onTap: isEnabled ? onPressed : null,
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 11.w),
          decoration: BoxDecoration(
            borderRadius: AppRadius.medium,
            color: isSelected ? AppColor.primaryNormal : AppGrayscale.gray99,
          ),
          child: Center(
            child: Text(text, style: AppTypeface.label16Bold.copyWith(color: isSelected ? AppColor.white : AppGrayscale.gray40)),
          ),
        ),
      ),
    );
  }
}
