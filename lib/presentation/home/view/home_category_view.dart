import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/ticats_event_category.enum.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip.dart';

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 20.w),
          for (final category in TicatsEventCategory.values)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: TicatsChip(category.label, onTap: () {}, textStyle: AppTypeface.label14Bold),
            ),
          SizedBox(width: 18.w),
        ],
      ),
    );
  }
}
