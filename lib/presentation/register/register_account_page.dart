import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/presentation/common/app_bar/ticats_app_bar.dart';
import 'package:ticats_app/presentation/common/widget/ticats_bottom_sheet.dart';
import 'package:ticats_app/presentation/common/widget/ticats_cta_button.dart';

import 'provider/register_provider.dart';
import 'view/account_input_view.dart';
import 'view/select_gender_view.dart';
import 'view/term_agree_view.dart';

class RegisterAccountPage extends BasePage {
  const RegisterAccountPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    ref.watch(registerProvider);

    return CustomScrollView(
      primary: false,
      slivers: [
        SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                const AccountInputView(),
                const SelectGenderView(),
                const Spacer(),
                const _RegisterAccountButton(),
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

class _RegisterAccountButton extends ConsumerWidget {
  const _RegisterAccountButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(registerProvider);

    return TicatsCTAButton.contained(
      isEnabled: ref.watch(registerProvider.notifier).canSignUp,
      size: ButtonSize.large,
      text: "다음",
      onPressed: () => showTicatsBottomSheet(context, const TermAgreeView()),
    );
  }
}
