import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:ticats_app/presentation/main/provider/main_page_provider.dart';

List<_BottomNavigationItem> _bottomNavigationItems = [
  _BottomNavigationItem('홈', icon: Assets.icons.home),
  _BottomNavigationItem('검색', icon: Assets.icons.search),
  _BottomNavigationItem('티켓북', icon: Assets.icons.ticketBook),
  _BottomNavigationItem('리포트', icon: Assets.icons.report),
  _BottomNavigationItem('마이페이지', icon: Assets.icons.my),
];

class TicatsBottomNavigationBar extends ConsumerWidget {
  const TicatsBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_bottomNavigationItems.length, (int i) => _bottomNavigationItems[i]),
        ),
      ),
    );
  }
}

class _BottomNavigationItem extends ConsumerWidget {
  const _BottomNavigationItem(this.label, {required this.icon});

  final String label;
  final SvgGenImage icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeController = ref.watch(mainPageControllerProvider);

    final int itemIndex = _bottomNavigationItems.indexWhere((e) => e.label == label);
    final int currentIndex = homeController.bottomNavigationBarIndex;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (currentIndex == itemIndex) return;

        ref.read(mainPageControllerProvider.notifier).setBottomNavigationBarIndex(itemIndex);
      },
      child: SizedBox(
        width: 56.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon.path,
              width: 24.w,
              height: 24.w,
              colorFilter: ColorFilter.mode(currentIndex == itemIndex ? AppColor.primaryNormal : AppGrayscale.gray60, BlendMode.srcIn),
            ),
            SizedBox(height: 2.h),
            Text(label,
                style: AppTypeface.label12Medium.copyWith(color: currentIndex == itemIndex ? AppColor.primaryNormal : AppGrayscale.gray60)),
          ],
        ),
      ),
    );
  }
}
