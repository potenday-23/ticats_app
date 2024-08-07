import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ticats/app/index.dart';

class TicatsBorderTextField extends HookConsumerWidget {
  TicatsBorderTextField({
    required this.hintText,
    required this.controller,
    this.status = TextFieldStatus.normal,
    this.statusText = "",
    this.currentLength,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    super.key,
  });

  final String hintText;
  final TextEditingController controller;
  final int? currentLength;
  final int? maxLength;

  final TextFieldStatus status;
  final String statusText;

  final TextInputType keyboardType;

  final Function(String) onChanged;

  final int id = UniqueKey().hashCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color textColor = status == TextFieldStatus.error
        ? AppColor.error
        : status == TextFieldStatus.info
            ? AppColor.positiveBlue
            : AppGrayscale.gray60;

    Color bgColor = status == TextFieldStatus.error
        ? AppColor.errorBg
        : status == TextFieldStatus.info
            ? AppColor.positiveBlueBg
            : AppGrayscale.gray99;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: bgColor,
            contentPadding: EdgeInsets.all(12.w),
            hintText: hintText,
            hintStyle: AppTypeface.body18Semibold.copyWith(color: AppGrayscale.gray60),
            border: OutlineInputBorder(borderRadius: AppRadius.small, borderSide: BorderSide.none),
          ),
          inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
          style: AppTypeface.body18Semibold.copyWith(color: AppColor.black),
          keyboardType: keyboardType,
        ),
        SizedBox(height: 4.h),
        if (maxLength != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(statusText, style: AppTypeface.label12Regular.copyWith(color: textColor)),
                Text('${controller.value.text.length}/$maxLength', style: AppTypeface.label14Medium.copyWith(color: textColor)),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
