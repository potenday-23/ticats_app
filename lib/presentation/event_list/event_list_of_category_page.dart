import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/presentation/common/app_bar/ticats_app_bar.dart';
import 'package:ticats_app/presentation/event_list/hook/use_infinite_scroll_hook.dart';
import 'package:ticats_app/presentation/event_list/provider/event_list_controller.dart';
import 'package:ticats_app/presentation/event_list/view/event_list_event_view.dart';
import 'package:ticats_app/presentation/event_list/view/event_list_filter_view.dart';

class EventListOfCategoryPage extends BasePage {
  const EventListOfCategoryPage({required this.categoryName, super.key});

  final String categoryName;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    useInfiniteScrollHook(
      ref: ref,
      scrollController: scrollController,
      loadFunction: () => ref.read(eventListControllerProvider(categoryName: categoryName).notifier).scrollData(),
    );

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          EventListFilterView(categoryName: categoryName),
          SizedBox(height: 40.h),
          EventListEventView(categoryName: categoryName),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => TicatsAppBar.back(categoryName);
}
