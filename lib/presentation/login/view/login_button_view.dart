import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/enum/login_provider.enum.dart';
import 'package:ticats_app/app/service/auth_service.dart';
import 'package:ticats_app/presentation/common/widget/ticats_sso_button.dart';

class LoginButtonsView extends ConsumerWidget {
  const LoginButtonsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authServiceNotifier = ref.read(authServiceProvider.notifier);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          TicatsSSOButton(
            type: SSOType.kakao,
            onPressed: () async => await authServiceNotifier.login(LoginProvider.kakao),
          ),
          SizedBox(height: 16.h),
          TicatsSSOButton(
            type: SSOType.google,
            onPressed: () async => await authServiceNotifier.login(LoginProvider.google),
          ),
          if (Platform.isIOS) ...[
            SizedBox(height: 16.h),
            TicatsSSOButton(
              type: SSOType.apple,
              onPressed: () async => await authServiceNotifier.login(LoginProvider.apple),
            ),
          ],
        ],
      ),
    );
  }
}
