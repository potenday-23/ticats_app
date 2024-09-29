import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';

enum ButtonType { primary, secondary }

enum ButtonSize { small, medium, large }

class TicatsCTAButton extends StatelessWidget {
  final ButtonSize size;
  final bool isEnabled;
  final String text;
  final Color color;
  final Color textColor;
  final BoxBorder? border;
  final VoidCallback onPressed;

  const TicatsCTAButton({
    super.key,
    required this.size,
    required this.isEnabled,
    required this.text,
    required this.color,
    required this.textColor,
    this.border,
    required this.onPressed,
  });

  factory TicatsCTAButton.contained({
    bool isEnabled = true,
    ButtonSize size = ButtonSize.medium,
    ButtonType type = ButtonType.primary,
    required String text,
    required VoidCallback onPressed,
  }) {
    final isPrimary = type == ButtonType.primary;
    final color =
        isEnabled ? (isPrimary ? AppColor.primaryNormal : AppGrayscale.gray95) : (isPrimary ? AppGrayscale.gray70 : AppGrayscale.gray85);
    final textColor = isPrimary ? AppColor.white : (isEnabled ? AppColor.black : AppGrayscale.gray60);

    return TicatsCTAButton(
      isEnabled: isEnabled,
      size: size,
      text: text,
      color: color,
      textColor: textColor,
      onPressed: onPressed,
    );
  }

  factory TicatsCTAButton.outlined({
    bool isEnabled = true,
    ButtonSize size = ButtonSize.medium,
    required String text,
    required VoidCallback onPressed,
  }) {
    return TicatsCTAButton(
      isEnabled: isEnabled,
      size: size,
      text: text,
      border: Border.all(
        width: 1.w,
        color: isEnabled ? AppColor.primaryNormal : AppGrayscale.gray70,
      ),
      color: isEnabled ? AppGrayscale.gray99 : AppGrayscale.gray90,
      textColor: isEnabled ? AppColor.black : AppGrayscale.gray60,
      onPressed: onPressed,
    );
  }

  EdgeInsets get _padding {
    return size == ButtonSize.small
        ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w)
        : EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.w);
  }

  TextStyle get _textStyle {
    final baseStyle = size == ButtonSize.large
        ? AppTypeface.label20Bold
        : size == ButtonSize.medium
            ? AppTypeface.label16Semibold
            : AppTypeface.label14Medium;
    return baseStyle.copyWith(color: textColor);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size == ButtonSize.large ? double.maxFinite : null,
      child: GestureDetector(
        onTap: isEnabled ? onPressed : null,
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: _padding,
          decoration: BoxDecoration(
            border: border,
            borderRadius: AppRadius.small,
            color: color,
          ),
          child: Center(child: Text(text, style: _textStyle)),
        ),
      ),
    );
  }
}
