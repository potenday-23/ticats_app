import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/gen/assets.gen.dart';
import 'package:ticats_app/presentation/common/app_bar/ticats_app_bar.dart';
import 'package:ticats_app/presentation/common/widget/ticats_cta_button.dart';

import 'provider/register_provider.dart';
import 'provider/term_agree_provider.dart';

class RegisterSelectEntertainmentPage extends BasePage {
  const RegisterSelectEntertainmentPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final double coverSize = (MediaQuery.of(context).size.width - 56.w) / 2;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 13.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          SizedBox(height: 36.h),
          _buildEntertainmentOptions(coverSize),
          SizedBox(height: 40.h),
          _buildStartButton(context, ref),
          SizedBox(height: 20.h),
          _buildSkipButton(context, ref),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        style: AppTypeface.body18Bold,
        children: const [
          TextSpan(text: "맞춤 문화생활을 추천을 위해 \n마음에 드는 문화생활을 "),
          TextSpan(text: "최대 3개", style: TextStyle(color: AppColor.primaryDark)),
          TextSpan(text: " 선택해주세요!"),
        ],
      ),
    );
  }

  Widget _buildEntertainmentOptions(double coverSize) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 16.w,
      children: List.generate(10, (index) => _buildEntertainmentOption(coverSize)),
    );
  }

  Widget _buildEntertainmentOption(double coverSize) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: coverSize,
              height: coverSize,
              decoration: BoxDecoration(
                color: AppGrayscale.gray70,
                borderRadius: AppRadius.small,
              ),
            ),
            SizedBox(
              width: coverSize,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "Ipsum Lorem",
                  style: AppTypeface.label16Medium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Assets.images.entertainmentSelect.svg(
          width: coverSize,
          height: coverSize,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildStartButton(BuildContext context, WidgetRef ref) {
    return TicatsCTAButton.contained(
      text: "티캣츠 시작하기",
      onPressed: () async => await _goToMain(ref),
    );
  }

  Widget _buildSkipButton(BuildContext context, WidgetRef ref) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async => await _goToMain(ref),
        child: Text("건너뛰기", style: AppTypeface.label14Medium),
      ),
    );
  }

  Future<void> _goToMain(WidgetRef ref) async {
    final memberInfo = ref.read(registerProvider).copyWith(isMarketingAgree: ref.read(termAgreeProvider).checkMarketing);
    final bool updateResult = await ref.read(registerProvider.notifier).updateUserInfo(memberInfo);

    if (updateResult) {
      ref.read(routerProvider).go(Routes.main);
    }
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => const TicatsAppBar("문화생활 선택하기");
}
