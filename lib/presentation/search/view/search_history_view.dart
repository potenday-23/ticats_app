import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/domain/entity/cultural_event/recent_search_keyword_entity.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip.dart';
import 'package:ticats_app/presentation/search/provider/searched_event_list_controller.dart';
import 'package:ticats_app/presentation/search/search_page.dart';

class SearchHistoryView extends BaseView {
  final List<RecentSearchKeywordEntity> recentSearchKeywords;

  const SearchHistoryView({super.key, required this.recentSearchKeywords});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Column(
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
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: recentSearchKeywords
                  .map((e) => Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: TicatsChip.close(
                          e.keyword,
                          onTap: () {
                            ref.watch(searchTextControllerProvider).text =
                                e.keyword;
                            ref
                                .read(searchedEventListControllerProvider
                                    .notifier)
                                .submit(e.keyword);
                          },
                          iconTap: () {
                            ref
                                .read(searchedEventListControllerProvider
                                    .notifier)
                                .deleteRecentSearchKeyword(e.id);
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}
