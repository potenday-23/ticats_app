import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/presentation/common/app_bar/ticats_app_bar.dart';
import 'package:ticats_app/presentation/common/widget/ticats_cta_button.dart';

import 'provider/nick_state_provider.dart';
import 'provider/register_provider.dart';
import 'view/nick_input_view.dart';
import 'widget/add_profile_image_widget.dart';

class RegisterProfilePage extends BasePage {
  const RegisterProfilePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(nickInputStateProvider.notifier).resetState();
    });

    return CustomScrollView(
      primary: false,
      slivers: [
        SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                const AddProfileImageWidget(),
                SizedBox(height: 30.h),
                const NickInputView(),
                const Spacer(),
                const _RegisterProfileButton(),
                SizedBox(height: 13.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => TicatsAppBar.back("프로필 등록");

  @override
  bool get resizeToAvoidBottomInset => false;
}

class _RegisterProfileButton extends ConsumerWidget {
  const _RegisterProfileButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickInputState = ref.watch(nickInputStateProvider);
    final registerNotifier = ref.watch(registerProvider.notifier);

    return TicatsCTAButton.contained(
      size: ButtonSize.large,
      text: "다음",
      onPressed: () {
        registerNotifier.setNickname(nickInputState.controller.text);
        registerNotifier.resetAccount();
        ref.read(routerProvider).goNamed(Routes.registerAccount);
      },
      isEnabled: nickInputState.isValid,
    );
  }
}
