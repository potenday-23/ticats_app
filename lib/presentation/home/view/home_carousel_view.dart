import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';

class HomeCarouselView extends BaseView {
  const HomeCarouselView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    const int carouselLength = 5;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 180.h,
      child: InfiniteCarousel.builder(
        physics: const PageViewTypeScrollPhysics(),
        itemCount: carouselLength,
        itemExtent: screenWidth - 40.w,
        center: true,
        onIndexChanged: (index) {},
        axisDirection: Axis.horizontal,
        loop: true,
        itemBuilder: (context, itemIndex, realIndex) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Stack(
              children: [
                Container(
                  width: screenWidth - 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppGrayscale.gray80,
                  ),
                ),
                Positioned.fill(
                  right: 20.w,
                  bottom: 14.h,
                  child: Align(alignment: Alignment.bottomRight, child: buildPageChip(itemIndex, carouselLength)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildPageChip(int index, int length) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: AppRadius.full,
        color: AppGrayscale.gray40,
      ),
      child: Text(
        "${index + 1}/$length",
        style: AppTypeface.label12Regular.copyWith(color: Colors.white),
      ),
    );
  }
}
