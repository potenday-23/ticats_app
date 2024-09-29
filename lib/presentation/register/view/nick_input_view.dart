import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/widget/ticats_border_text_field.dart';

import '../provider/nick_state_provider.dart';

const int _maxNickLength = 10;

class NickInputView extends BaseView {
  const NickInputView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final nickState = ref.watch(nickInputStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text("닉네임", style: AppTypeface.label16Semibold.copyWith(color: AppColor.black)),
        ),
        SizedBox(height: 10.h),
        TicatsBorderTextField(
          hintText: "티케팅하는 고양이",
          status: nickState.status,
          statusText: nickState.statusText,
          controller: nickState.controller,
          maxLength: _maxNickLength,
          onChanged: ref.read(nickInputStateProvider.notifier).onNickChanged,
        ),
      ],
    );
  }
}
