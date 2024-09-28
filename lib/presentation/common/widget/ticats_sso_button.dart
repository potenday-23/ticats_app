import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';

enum SSOType {
  kakao("카카오", Color(0xFFFFE300)),
  google("Google", Colors.white),
  apple("Apple", Colors.black, Colors.white);

  final String label;
  final Color bgColor;
  final Color textColor;

  const SSOType(this.label, this.bgColor, [this.textColor = Colors.black]);
}

class TicatsSSOButton extends StatelessWidget {
  const TicatsSSOButton({
    super.key,
    required this.type,
    required this.onPressed,
  });

  final SSOType type;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 56.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(color: type.bgColor, borderRadius: AppRadius.medium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset('assets/logos/${type.name}.svg')),
            SizedBox(width: 8.w),
            Text("${type.label}로 시작하기", style: AppTypeface.body18Semibold.copyWith(color: type.textColor)),
          ],
        ),
      ),
    );
  }
}
