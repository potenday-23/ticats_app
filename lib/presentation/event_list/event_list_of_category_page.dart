import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/presentation/common/app_bar/ticats_app_bar.dart';

class EventListOfCategory extends BasePage {
  const EventListOfCategory({required this.categoryName, super.key});
  final String categoryName;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => TicatsAppBar.back(categoryName);
}
