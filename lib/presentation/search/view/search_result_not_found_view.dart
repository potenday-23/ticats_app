import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip.dart';
import 'package:ticats_app/presentation/search/provider/searched_event_list_controller.dart';
import 'package:ticats_app/presentation/search/search_page.dart';

class SearchResultNotFoundView extends BaseView {
  const SearchResultNotFoundView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: AsyncValueWidget(
          value: ref.watch(searchedEventListControllerProvider),
          data: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 68.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Assets.icons.ticatsSearchCat.path),
                        SizedBox(height: 24.h),
                        Text(
                          '아쉽게도 일치하는 내용이 없어요.\n다른 검색어를 입력해보세요.',
                          style: AppTypeface.label16Semibold,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.h),
                        Text('* 공연이 종료되는 경우에는 검색되지 않아요',
                            style: AppTypeface.label14Regular),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
                    child: Text(
                      '이런 검색어는 어떨까요?',
                      style: AppTypeface.body18Bold,
                      textAlign: TextAlign.left,
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 24.w),
                      child: Wrap(
                          runSpacing: 12.h,
                          spacing: 12.w,
                          alignment: WrapAlignment.center,
                          children: state.popularSearchKeywords
                              .map((e) => TicatsChip(e.title, onTap: () {
                                    ref
                                        .watch(searchTextControllerProvider)
                                        .text = e.title;
                                    ref
                                        .read(
                                            searchedEventListControllerProvider
                                                .notifier)
                                        .submit(e.title);
                                  }))
                              .toList())),
                ),
              ],
            );
          }),
    );
  }
}
