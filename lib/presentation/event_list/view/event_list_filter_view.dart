import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ticats_app/app/enum/ticats_event_category.enum.dart';
import 'package:ticats_app/app/enum/ticats_event_ordering.enum.dart';
import 'package:ticats_app/presentation/common/ticats_checkbox_bottom_sheet.dart';
import 'package:ticats_app/presentation/common/ticats_radio_bottom_sheet.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip.dart';
import 'package:ticats_app/presentation/event_list/provider/event_list_controller.dart';

final orderingProvider = StateProvider<TicatsEventOrdering>((ref) => TicatsEventOrdering.ticketOpenDate);
final categoryProvider = StateProvider<List<TicatsEventCategory>>((ref) => [TicatsEventCategory.ALL]);

class EventListFilterView extends ConsumerStatefulWidget {
  const EventListFilterView({super.key, this.categoryName});

  final String? categoryName;

  @override
  _EventListFilterViewState createState() => _EventListFilterViewState();
}

class _EventListFilterViewState extends ConsumerState<EventListFilterView> {
  String categoryTitle = '카테고리';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(orderingProvider.notifier).state = TicatsEventOrdering.ticketOpenDate;
      ref.read(categoryProvider.notifier).state = [TicatsEventCategory.ALL];
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderingValue = ref.watch(orderingProvider);
    final categoryValue = ref.watch(categoryProvider);

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20.w),
          if (widget.categoryName == null) ...[
            TicatsChip.arrowDown(categoryTitle, onTap: () {
              showTicatsCheckboxBottomSheet(
                  options: TicatsEventCategory.values,
                  selectedValues: categoryValue,
                  onChanged: (value) async {
                    await ref.read(eventListControllerProvider(categoryName: widget.categoryName).notifier)
                        .selectCategories(value);
                    setState(() {
                      categoryTitle = value.first.label;
                    });
                  }
              );
            }),
            SizedBox(width: 8.w),
          ],
          TicatsChip.arrowDown(
            TicatsEventOrdering.values.firstWhere((element) => element == orderingValue).label,
            onTap: () {
              showTicatsRadioBottomSheet(
                options: TicatsEventOrdering.values,
                groupValue: orderingValue,
                onChanged: (value) async {
                  await ref.read(eventListControllerProvider(categoryName: widget.categoryName).notifier)
                      .selectOrdering(value);
                  ref.read(orderingProvider.notifier).state = value;
                  context.pop();
                },
              );
            },
          ),
          SizedBox(width: 8.w),
          TicatsChip.arrowDown('공연 현황', onTap: () {
            // TODO 공연중, 공연예정에 관한 API 필요
          }),
        ],
      ),
    );
  }
}