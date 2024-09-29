import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/gen/assets.gen.dart';

class AddProfileImageWidget extends StatelessWidget {
  const AddProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Assets.images.profile.svg(width: 100.w, height: 100.w),
          Positioned.fill(
            right: -4.w,
            bottom: -4.w,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Assets.icons.profileCamera.svg(width: 32.w, height: 32.w),
            ),
          ),
        ],
      ),
    );
  }
}
