import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip.dart';
import 'package:ticats_app/presentation/search/provider/searched_event_list_controller.dart';
import 'package:ticats_app/presentation/search/search_page.dart';

class SearchHistoryView extends BaseView {
  const SearchHistoryView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
        value: ref.watch(searchedEventListControllerProvider),
        data: (state) {
          return Visibility(
            visible: state.recentSearchKeywords.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 36.h, left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('검색 기록',
                          style: AppTypeface.label16Medium
                              .copyWith(color: AppGrayscale.gray30)),
                      SizedBox(height: 16.h)
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 16.w),
                      ...state.recentSearchKeywords.map((e) => Container(
                            margin: EdgeInsets.only(right: 8.w),
                            child: TicatsChip.close(e.title, onTap: () {
                              ref.watch(searchTextControllerProvider).text =
                                  e.title;
                              ref
                                  .read(searchedEventListControllerProvider
                                      .notifier)
                                  .submit(e.title);
                            }, iconTap: () {
                              ref
                                  .read(searchedEventListControllerProvider
                                      .notifier)
                                  .deleteRecentSearchKeyword(e.id);
                            }),
                          )),
                      SizedBox(width: 8.w)
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
