import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:ticats_app/presentation/common/app_bar/ticats_app_bar.dart';
import 'package:ticats_app/presentation/common/widget/ticats_cta_button.dart';

class RegisterPermissionPage extends BasePage {
  const RegisterPermissionPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40.h),
          Text("티캣츠와 함께 소중한 문화생활을\n시작해보세요!", style: AppTypeface.body18Bold),
          SizedBox(height: 36.h),
          Text("선택 접근 권한", style: AppTypeface.label14Medium),
          SizedBox(height: 18.h),
          _PermissionDescriptionWidget("카메라", "티켓 사진 및 프로필 사진 촬영", Assets.icons.camera),
          SizedBox(height: 18.h),
          _PermissionDescriptionWidget("갤러리", "나만의 티켓 제작 및 저장", Assets.icons.image),
          SizedBox(height: 18.h),
          _PermissionDescriptionWidget("알림", "티켓팅 전 PUSH 알림 및 이벤트 알림 수신", Assets.icons.notification),
          SizedBox(height: 36.h),
          Text(
            "선택 접근 권한은 동의하지 않아도 서비스 이용은 가능하지만,\n해당권한이 필요한 기능은 이용이 제한됩니다.",
            style: AppTypeface.label12Regular,
          ),
          SizedBox(height: 36.h),
          TicatsCTAButton.contained(
            text: "동의하고 시작하기",
            onPressed: () async {
              await [Permission.camera, Permission.photos, Permission.notification].request();

              ref.read(routerProvider).goNamed(Routes.registerSelectEntertianment);
            },
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => TicatsAppBar.back("앱 이용을 위한 권한 안내");
}

class _PermissionDescriptionWidget extends StatelessWidget {
  const _PermissionDescriptionWidget(this.title, this.description, this.icon);

  final String title;
  final String description;
  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          icon.svg(width: 36.w, height: 36.w),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypeface.label16Medium),
              Text(description, style: AppTypeface.label14Medium),
            ],
          ),
        ],
      ),
    );
  }
}
