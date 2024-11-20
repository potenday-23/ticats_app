import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/domain/entity/cultural_event/popular_search_keyword_entity.dart';

class PopularSearchKeywordView extends BaseView {
  final List<PopularSearchKeywordEntity> popularSearchKeywords;
  const PopularSearchKeywordView({super.key, required this.popularSearchKeywords});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: 36.h, left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('추천 인기 검색어',
                        style: AppTypeface.label16Medium
                            .copyWith(color: AppGrayscale.gray30)),
                    SizedBox(height: 16.h),
                    ...popularSearchKeywords
                        .map((e) => _keywordWidget(e))
                  ])
          )
        ],
      ),
    );
  }

  Widget _keywordWidget(PopularSearchKeywordEntity keyword) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${keyword.ordering}',
            style: AppTypeface.body20Bold.copyWith(color: AppColor.primaryDark),
          ),
          SizedBox(
            width: 12.w,
          ),
          Text(
            keyword.keyword,
            style:
                AppTypeface.label16Regular.copyWith(color: AppGrayscale.gray10),
          )
        ],
      ),
    );
  }
}
