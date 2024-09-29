import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/widget/ticats_chip_button.dart';

import '../provider/register_provider.dart';

class SelectGenderView extends BaseView {
  const SelectGenderView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final signInProv = ref.watch(registerProvider);
    final signInProvNotifier = ref.watch(registerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text("성별", style: AppTypeface.label16Semibold.copyWith(color: AppColor.black)),
        ),
        SizedBox(height: 26.h),
        Row(
          children: [
            Expanded(
              child: TicatsChipButton(
                isSelected: signInProv.gender == "MALE",
                text: "남",
                onPressed: () => signInProvNotifier.setGender("MALE"),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: TicatsChipButton(
                isSelected: signInProv.gender == "FEMALE",
                text: "여",
                onPressed: () => signInProvNotifier.setGender("FEMALE"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
