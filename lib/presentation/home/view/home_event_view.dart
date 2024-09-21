import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/presentation/common/widget/ticats_event_widget.dart';
import 'package:ticats_app/presentation/home/provider/event_list_controller.dart';

class HomeEventView extends BaseView {
  const HomeEventView({
    required this.title,
    required this.eventViewType,
    required this.onTap,
    super.key,
  });

  final String title;
  final HomeEventViewType eventViewType;
  final VoidCallback onTap;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Expanded(child: Text(title, style: AppTypeface.body18Bold, overflow: TextOverflow.ellipsis)),
              GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.translucent,
                child: Row(
                  children: [
                    Text("전체보기", style: AppTypeface.label12Regular.copyWith(color: AppGrayscale.gray55)),
                    SizedBox(width: 4.w),
                    Assets.icons.arrowRight.svg(width: 24.w, height: 24.w),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        AsyncValueWidget(
          value: ref.watch(eventListControllerProvider),
          data: (value) {
            final eventList = ref.watch(eventListControllerProvider.notifier).getEventList(eventViewType);

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
