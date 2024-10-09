import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/enum/sso_type.enum.dart';
import 'package:ticats_app/presentation/common/widget/ticats_sso_button.dart';

class LoginButtonsView extends ConsumerWidget {
  const LoginButtonsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          const TicatsSSOButton(type: SSOType.kakao),
          SizedBox(height: 16.h),
          const TicatsSSOButton(type: SSOType.google),
          if (Platform.isIOS) ...[
            SizedBox(height: 16.h),
            const TicatsSSOButton(type: SSOType.apple),
          ],
        ],
      ),
    );
  }
}
