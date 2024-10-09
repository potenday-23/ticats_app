import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/sso_type.enum.dart';
import 'package:ticats_app/app/service/auth_service.dart';

class TicatsSSOButton extends ConsumerWidget {
  const TicatsSSOButton({super.key, required this.type});

  final SSOType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async => await login(ref, type),
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 56.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(color: type.bgColor, borderRadius: AppRadius.medium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset('assets/logos/${type.name}.svg')),
            SizedBox(width: 8.w),
            Text("${type.label}로 시작하기", style: AppTypeface.body18Semibold.copyWith(color: type.textColor)),
          ],
        ),
      ),
    );
  }

  Future<void> login(WidgetRef ref, SSOType type) async {
    bool loginResult = await ref.read(authServiceProvider.notifier).login(type);
    if (loginResult) {
      ref.read(routerProvider).go(Routes.main);
      return;
    }

    if (ref.read(authServiceProvider).value!.sso != null) {
      ref.read(routerProvider).goNamed(Routes.registerProfile);
    } else {
      Fluttertoast.showToast(msg: "로그인에 실패하였습니다. 잠시 후 다시 시도해주세요.");
    }
  }
}
