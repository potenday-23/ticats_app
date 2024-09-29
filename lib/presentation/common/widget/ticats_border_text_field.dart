import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/text_field_status.enum.dart';

class TicatsBorderTextField extends HookConsumerWidget {
  const TicatsBorderTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.status = TextFieldStatus.normal,
    this.statusText = "",
    this.maxLength,
    this.keyboardType = TextInputType.text,
  });

  final String hintText;
  final TextEditingController controller;
  final int? maxLength;
  final TextFieldStatus status;
  final String statusText;
  final TextInputType keyboardType;
  final Function(String) onChanged;

  Color get _textColor {
    switch (status) {
      case TextFieldStatus.error:
        return AppColor.error;
      case TextFieldStatus.info:
        return AppColor.positiveBlue;
      default:
        return AppGrayscale.gray60;
    }
  }

  Color get _bgColor {
    switch (status) {
      case TextFieldStatus.error:
        return AppColor.errorBg;
      case TextFieldStatus.info:
        return AppColor.positiveBlueBg;
      default:
        return AppGrayscale.gray99;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: _bgColor,
            contentPadding: EdgeInsets.all(12.w),
            hintText: hintText,
            hintStyle: AppTypeface.body18Semibold.copyWith(color: AppGrayscale.gray60),
            border: OutlineInputBorder(borderRadius: AppRadius.small, borderSide: BorderSide.none),
          ),
          inputFormatters: maxLength != null ? [LengthLimitingTextInputFormatter(maxLength)] : null,
          style: AppTypeface.body18Semibold.copyWith(color: AppColor.black),
          keyboardType: keyboardType,
        ),
        if (maxLength != null) ...[
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(statusText, style: AppTypeface.label12Regular.copyWith(color: _textColor)),
                Text(
                  '${controller.text.length}/$maxLength',
                  style: AppTypeface.label14Medium.copyWith(color: _textColor),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
