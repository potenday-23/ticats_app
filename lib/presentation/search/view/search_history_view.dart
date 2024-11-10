import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip.dart';

class SearchHistoryView extends BaseView {
  const SearchHistoryView({super.key});

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
          child: Row(
            children: [
              TicatsChip.close(
                '기록',
                onTap: () {
                  print('asdf');
                },
                iconTap: () {
                  print('아이콘');
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
