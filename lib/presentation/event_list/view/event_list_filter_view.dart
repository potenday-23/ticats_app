import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/enum/ticats_event_ordering.enum.dart';
import 'package:ticats_app/presentation/common/ticats_filter_bottom_sheet.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip.dart';
import 'package:ticats_app/presentation/event_list/provider/event_list_controller.dart';

final orderingProvider = StateProvider<TicatsEventOrdering>((ref) => TicatsEventOrdering.ticketOpenData);

class EventListFilterView extends ConsumerWidget {
  const EventListFilterView(this.categoryName, {super.key});

  final String categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderingValue = ref.watch(orderingProvider);

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20.w),
          TicatsChip.arrowDown(
            TicatsEventOrdering.values.firstWhere((element) => element == orderingValue).label,
            onTap: () {
              showTicatFilterBottomSheet(
                options: TicatsEventOrdering.values,
                groupValue: orderingValue,
                onChanged: (value) async {
                  await ref.read(eventListControllerProvider(categoryName: categoryName).notifier).selectOrdering(value);
                  ref.read(orderingProvider.notifier).state = value;
                },
              );
            },
          ),
          SizedBox(width: 8.w),
          TicatsChip.arrowDown('공연 현황', onTap: () {
            // 공연 현황 필터 로직 구현
          }),
        ],
      ),
    );
  }
}
