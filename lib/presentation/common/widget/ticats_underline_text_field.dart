import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/text_field_status.enum.dart';

class TicatsUnderlineTextField extends HookConsumerWidget {
  const TicatsUnderlineTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.status = TextFieldStatus.normal,
    this.statusText = "",
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
    this.maxLength,
    this.onChanged,
    this.digitsOnly = false,
  });

  final String hintText;
  final TextEditingController controller;
  final TextFieldStatus status;
  final String statusText;
  final TextInputType keyboardType;
  final bool isEnabled;
  final int? maxLength;
  final Function(String)? onChanged;
  final bool digitsOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = _getTextColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: _buildInputDecoration(),
          inputFormatters: _buildInputFormatters(),
          style: AppTypeface.label16Semibold.copyWith(
            color: isEnabled ? AppColor.black : AppGrayscale.gray70,
          ),
          keyboardType: keyboardType,
        ),
        SizedBox(height: 4.h),
        if (statusText.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              statusText,
              style: AppTypeface.label12Regular.copyWith(color: textColor),
            ),
          ),
      ],
    );
  }

  Color _getTextColor() {
    switch (status) {
      case TextFieldStatus.error:
        return AppColor.error;
      case TextFieldStatus.info:
        return AppColor.positiveBlue;
      default:
        return AppGrayscale.gray60;
    }
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      isDense: true,
      enabled: isEnabled,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      hintText: hintText,
      hintStyle: AppTypeface.label16Semibold.copyWith(color: AppGrayscale.gray70),
      border: const UnderlineInputBorder(borderSide: BorderSide(color: AppGrayscale.gray55)),
      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppGrayscale.gray55)),
      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppGrayscale.gray55)),
    );
  }

  List<TextInputFormatter> _buildInputFormatters() {
    return [
      if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
      if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
    ];
  }
}
