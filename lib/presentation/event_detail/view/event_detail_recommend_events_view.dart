import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/presentation/common/widget/ticats_event_widget.dart';
import 'package:ticats_app/presentation/event_detail/provider/recommended_event_list_controller.dart';

class EventDetailRecommendEventView extends BaseView {
  const EventDetailRecommendEventView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text('이런 문화생활은 어떠세요?', style: AppTypeface.label16Semibold),
        ),
        SizedBox(height: 10.h),
        AsyncValueWidget(
          value: ref.watch(recommendedEventListControllerProvider),
          data: (value) {
            final eventList = ref.watch(recommendedEventListControllerProvider.notifier).getEventList();

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 16.w,
                children: [
                  SizedBox(width: 4.w),
                  for (int i = 0; i < eventList.length; i++) ...[
                    TicatsEventWidget.small(event: eventList[i]),
                  ],
                  SizedBox(width: 4.w),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
