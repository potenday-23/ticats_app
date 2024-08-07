import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats/app/index.dart';
import 'package:ticats/presentation/index.dart';

class LoginButtonsView extends ConsumerWidget {
  const LoginButtonsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          TicatsSSOButton(
            type: SSOType.kakao,
            onPressed: () async {
              await ref.read(authServiceProvider.notifier).login(LoginProvider.kakao);
            },
          ),
          SizedBox(height: 16.h),
          TicatsSSOButton(
            type: SSOType.google,
            onPressed: () async {
              await ref.read(authServiceProvider.notifier).login(LoginProvider.google);
            },
          ),
          SizedBox(height: 16.h),
          TicatsSSOButton(
            type: SSOType.apple,
            onPressed: () async {
              await ref.read(authServiceProvider.notifier).login(LoginProvider.apple);
            },
          ),
        ],
      ),
    );
  }
}
