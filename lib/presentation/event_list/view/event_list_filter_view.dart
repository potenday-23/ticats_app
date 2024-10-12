import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip.dart';

class EventListFilterView extends BaseView {
  const EventListFilterView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20.w),
          TicatsChip.arrowDown('추천순', onTap: () {
            /*
            showModalBottomSheet(
                context: context,
                elevation: 0,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.only(top: 24.h),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text('정렬', style: AppTypeface.body20Bold, textAlign: TextAlign.center),
                        SizedBox(height: 32.h),
                        Row(
                          children: [
                            Text('기본순'),
                            RadioListTile(
                                value: '기본순',
                                groupValue: 'ㄴㅇㄹ',
                                onChanged: (value) {}
                            )
                          ],
                        )
                      ],
                    ),
                  );
            });
             */
          }),
          SizedBox(width: 8.w),
          TicatsChip.arrowDown('공연 현황', onTap: () {

          }),
        ],
      ),
    );
  }
}
