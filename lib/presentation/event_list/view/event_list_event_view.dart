import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/presentation/common/widget/ticats_event_widget.dart';
import 'package:ticats_app/presentation/event_list/provider/event_list_controller.dart';

class EventListEventView extends BaseView {
  const EventListEventView(this.categoryName, {super.key});
  final String categoryName;

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(eventListControllerProvider(categoryName: categoryName)),
      data: (value) {
        final eventList = ref.watch(eventListControllerProvider(categoryName: categoryName).notifier).getEventList();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                childAspectRatio: 167.w/323.w
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: eventList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: TicatsEventWidget.big(event: eventList[index])
                );
              }
          ),
        );
      },
    );
  }

}