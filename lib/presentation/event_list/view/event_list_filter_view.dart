import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/ticats_event_ordering.enum.dart';
import 'package:ticats_app/domain/entity/cultural_event/cultural_events_search_entity.dart';
import 'package:ticats_app/presentation/common/ticats_filter_bottom_sheet.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip.dart';
import 'package:ticats_app/presentation/event_list/provider/event_list_controller.dart';

class EventListFilterView extends BaseView {
  const EventListFilterView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(eventListControllerProvider()).value?.filter
        ?? const CulturalEventsSearchEntity();
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20.w),
          TicatsChip.arrowDown('추천순', onTap: () {
            showTicatFilterBottomSheet(
                options: TicatsEventOrdering.values,
                groupValue: TicatsEventOrdering.recommend,
                onChanged: (value) {
                  ref.read(eventListControllerProvider().notifier).selectOrdering(value);
                });
          }),
          SizedBox(width: 8.w),
          TicatsChip.arrowDown('공연 현황', onTap: () {

          }),
        ],
      ),
    );
  }
}
