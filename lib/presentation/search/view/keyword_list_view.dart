import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/widget/async_value_widget.dart';
import 'package:ticats_app/presentation/search/provider/searched_event_list_controller.dart';
import 'package:ticats_app/presentation/search/search_page.dart';

class KeywordListView extends BaseView {
  const KeywordListView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
        value: ref.watch(searchedEventListControllerProvider),
        data: (state) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      ref.watch(searchTextControllerProvider).text =
                          state.searchedEvents[index].title;
                      ref
                          .read(searchedEventListControllerProvider.notifier)
                          .submit(state.searchedEvents[index].title);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        state.searchedEvents[index].title,
                        style: AppTypeface.label16Medium,
                      ),
                    ),
                  );
                },
                itemCount: state.searchedEvents.length > 5
                    ? 5
                    : state.searchedEvents.length,
                separatorBuilder: (context, index) {
                  return Divider(color: AppGrayscale.gray85);
                },
              ));
        });
  }
}
