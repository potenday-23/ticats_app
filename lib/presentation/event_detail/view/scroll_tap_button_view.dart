import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';

class ScrollTapButtonView extends StatelessWidget {
  final VoidCallback onTap;

  const ScrollTapButtonView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppGrayscale.gray95,
          borderRadius: AppRadius.medium
        ),
        child: Row(
          children: [
            Container(
              width: 175.w,
              height: 46.h,
              decoration: BoxDecoration(
                color: AppGrayscale.gray30,
                borderRadius: AppRadius.medium
              ),
              child: Center(
                  child: Text(
                      '상세정보',
                      style: AppTypeface.label14Medium.copyWith(color: AppColor.white)
                  )
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 175.w,
                height: 46.h,
                decoration: BoxDecoration(
                    color: AppGrayscale.gray95,
                    borderRadius: AppRadius.medium
                ),
                child: Center(
                    child: Text(
                        '장소',
                        style: AppTypeface.label14Medium.copyWith(color: AppGrayscale.gray20)
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
