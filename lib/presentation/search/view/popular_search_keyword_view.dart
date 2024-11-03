import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';

class PopularSearchKeywordView extends BaseView {
  const PopularSearchKeywordView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: 36.h, left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('추천 인기 검색어',
              style: AppTypeface.label16Medium
                  .copyWith(color: AppGrayscale.gray30)),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: _keywordWidget(),
          )
        ],
      ),
    );
  }

  Widget _keywordWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '1',
            style: AppTypeface.body20Bold.copyWith(color: AppColor.primaryDark),
          ),
          SizedBox(
            width: 12.w,
          ),
          Text(
            '인피니트',
            style:
                AppTypeface.label16Regular.copyWith(color: AppGrayscale.gray10),
          )
        ],
      ),
    );
  }
}
