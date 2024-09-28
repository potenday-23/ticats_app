import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:ticats_app/presentation/login/view/login_button_view.dart';

class LoginPage extends BasePage {
  const LoginPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.loginBg.path),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Text("지금까지 관람했던 문화생활 티켓,\n어떻게 정리해야 할지 모르겠나요?", style: AppTypeface.label14Medium),
            SizedBox(height: 160.h),
            Text("쌓여있는 티켓,\n이제부터 티캣츠로 정리하세요!", style: AppTypeface.headline24Bold),
            SizedBox(height: 60.h),
            const LoginButtonsView(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wrapWithSafeArea => false;
}
