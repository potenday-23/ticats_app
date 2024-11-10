import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/presentation/search/provider/searched_event_list_controller.dart';
import 'package:ticats_app/presentation/search/view/keyword_list_view.dart';
import 'package:ticats_app/presentation/search/view/popular_search_keyword_view.dart';
import 'package:ticats_app/presentation/search/view/search_history_view.dart';
import 'package:ticats_app/presentation/search/view/searched_event_list_event_view.dart';

final searchTextControllerProvider =
    StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

class SearchPage extends BasePage {
  const SearchPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 4.h),
          AsyncValueWidget(
              value: ref.watch(searchedEventListControllerProvider),
              data: (state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.isSubmitted == false) ...[
                      if (ref.watch(searchTextControllerProvider).text ==
                          '') ...[
                        SearchHistoryView(),
                        PopularSearchKeywordView(),
                      ] else ...[
                        KeywordListView()
                      ]
                    ] else ...[
                      SearchedEventListEventView()
                    ]
                  ],
                );
              })
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
                  controller: ref.watch(searchTextControllerProvider),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    border: OutlineInputBorder(
                        borderRadius: AppRadius.small,
                        borderSide: BorderSide.none),
                    hintText: '티켓을 검색해보세요!',
                    hintStyle: AppTypeface.label16Regular
                        .copyWith(color: AppGrayscale.gray55),
                    suffixIcon: Container(
                        margin: EdgeInsets.only(right: 16.w),
                        child: GestureDetector(
                          onTap: () {
                            ref.watch(searchTextControllerProvider).text = '';
                            ref.read(searchedEventListControllerProvider.notifier).clickRemoveIcon();
                          },
                          child: SvgPicture.asset(
                            Assets.icons.closeCircleFill.path,
                            width: 20.w,
                            height: 20.w,
                          ),
                        )),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 20.w,
                      minHeight: 20.w,
                    ),
                  ),
                  onChanged: (value) {
                    ref
                        .read(searchedEventListControllerProvider.notifier)
                        .onSearchTextChanged(value);
                  },
                  onSubmitted: (value) {
                    ref
                        .read(searchedEventListControllerProvider.notifier)
                        .submit(value);
                  },
                ),
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
