import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:ticats_app/presentation/search/view/popular_search_keyword_view.dart';
import 'package:ticats_app/presentation/search/view/search_history_view.dart';

class SearchView extends BasePage {
  const SearchView({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 4.h),
          SearchHistoryView(),
          PopularSearchKeywordView(),
        ],
      ),
    );
  }

  @override
  Color? get screenBackgroundColor => AppGrayscale.gray99;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Container(
          padding:
              EdgeInsets.only(left: 24.w, top: 5.h, bottom: 5.h, right: 16.w),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: AppGrayscale.gray95, borderRadius: AppRadius.small),
                child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        border: OutlineInputBorder(
                            borderRadius: AppRadius.small,
                            borderSide: BorderSide.none),
                        hintText: '티켓을 검색해보세요!',
                        hintStyle: AppTypeface.label16Regular
                            .copyWith(color: AppGrayscale.gray55))),
              )),
              IconButton(
                  onPressed: () {},
                  icon: Assets.icons.search.svg(
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(
                        AppGrayscale.gray10, BlendMode.srcIn),
                  )),
            ],
          )),
    );
  }
}
