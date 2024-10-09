import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/service/auth_service.dart';
import 'package:ticats_app/domain/entity/auth/member_entity.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:ticats_app/presentation/common/app_bar/ticats_app_bar.dart';
import 'package:ticats_app/presentation/main/provider/main_page_provider.dart';

import 'provider/event_list_controller.dart';
import 'view/home_carousel_view.dart';
import 'view/home_category_view.dart';
import 'view/home_event_view.dart';

class HomeView extends BasePage {
  const HomeView({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final MemberEntity? member = ref.read(authServiceProvider).value?.memberInfo;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          const HomeCarouselView(),
          SizedBox(height: 20.h),
          const HomeCategoryView(),
          SizedBox(height: 20.h),
          HomeEventView(
            title: "${member?.nickname} 님을 위한 추천",
            eventViewType: HomeEventViewType.recommend,
            onTap: () {},
          ),
          SizedBox(height: 40.h),
          HomeEventView(
            title: "인기 급상승 문화생활",
            eventViewType: HomeEventViewType.point,
            onTap: () {},
          ),
          SizedBox(height: 40.h),
          HomeEventView(
            title: "오픈 예정 문화생활",
            eventViewType: HomeEventViewType.openDate,
            onTap: () {},
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return TicatsAppBar(
      "문화생활 정보",
      leading: [
        IconButton(
          icon: Assets.icons.search.svg(
            width: 24.w,
            height: 24.w,
            colorFilter: const ColorFilter.mode(AppGrayscale.gray10, BlendMode.srcIn),
          ),
          onPressed: () => ref.read(mainPageControllerProvider.notifier).setBottomNavigationBarIndex,
        ),
      ],
    );
  }

  @override
  Color? get screenBackgroundColor => AppGrayscale.gray99;
}
