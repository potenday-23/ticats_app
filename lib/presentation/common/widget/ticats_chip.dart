import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';

class TicatsChip extends StatelessWidget {
  const TicatsChip(
    this.text, {
    required this.onTap,
    this.hasClose = true,
    this.icon,
    this.textStyle,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final TextStyle? textStyle;
  final bool hasClose;

  factory TicatsChip.close(String text, {required onTap}) {
    return TicatsChip(text, onTap: onTap, icon: Icons.close);
  }

  factory TicatsChip.arrowDown(String text, {required onTap}) {
    return TicatsChip(text, onTap: onTap, icon: Icons.keyboard_arrow_down_outlined, textStyle: AppTypeface.label14Bold);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppGrayscale.gray85),
        borderRadius: AppRadius.full,
        shape: BoxShape.rectangle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: textStyle ?? AppTypeface.label14Medium.copyWith(color: AppGrayscale.gray20)),
          if (icon != null) ...[
            SizedBox(width: 6.w),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: Icon(icon, size: 20.w, color: AppGrayscale.gray20),
            )
          ],
        ],
      ),
    );
  }
}
