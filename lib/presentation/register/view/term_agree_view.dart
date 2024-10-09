import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/term.enum.dart';
import 'package:ticats_app/domain/entity/state/term_agree_state.dart';
import 'package:ticats_app/presentation/common/widget/ticats_checkbox.dart';
import 'package:ticats_app/presentation/common/widget/ticats_cta_button.dart';
import 'package:ticats_app/presentation/common/widget/ticats_dialog.dart';

import '../provider/term_agree_provider.dart';

class TermAgreeView extends ConsumerWidget {
  const TermAgreeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termAgreeProv = ref.watch(termAgreeProvider);
    final termAgreeProvNotifier = ref.watch(termAgreeProvider.notifier);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(),
            _buildAllAgreeCheckbox(termAgreeProvNotifier),
            SizedBox(height: 4.h),
            ...TermEnum.values.map((term) => _buildTermCheckbox(term, termAgreeProv, termAgreeProvNotifier)),
            SizedBox(height: 25.h),
            _buildNextButton(context, ref, termAgreeProv, termAgreeProvNotifier),
            SizedBox(height: 13.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 31.h),
      child: Text("약관동의", style: AppTypeface.body20Bold),
    );
  }

  Widget _buildAllAgreeCheckbox(TermAgree notifier) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => notifier.checkAllAgree(),
      child: Row(
        children: [
          TicatsCheckbox(
            value: notifier.isAllAgree,
            onChanged: (val) => notifier.checkAllAgree(),
          ),
          SizedBox(width: 10.w),
          Text("모두 동의합니다.", style: AppTypeface.label16Bold),
        ],
      ),
    );
  }

  Widget _buildTermCheckbox(TermEnum term, TermAgreeState state, TermAgree notifier) {
    return _TermAgreeCheckBox(
      term,
      notifier,
      isAgree: state.getTermValue(term),
      onChanged: (_) => notifier.toggleTerm(term),
    );
  }

  Widget _buildNextButton(BuildContext context, WidgetRef ref, TermAgreeState state, TermAgree notifier) {
    return TicatsCTAButton.contained(
      isEnabled: notifier.isRequiredAgree,
      text: "다음",
      onPressed: () => _onNextPressed(context, ref, state, notifier),
      size: ButtonSize.large,
    );
  }

  void _onNextPressed(BuildContext context, WidgetRef ref, TermAgreeState state, TermAgree notifier) async {
    if (!state.checkMarketing) {
      await _showMarketingDialog(context, ref, state, notifier);
      return;
    }

    if (!context.mounted) return;
    if (state.checkMarketing) {
      await _showMarketingConfirmDialog(context, ref);
    }
  }

  Future<void> _showMarketingDialog(BuildContext context, WidgetRef ref, TermAgreeState state, TermAgree notifier) async {
    await showTicatsTwoButtonDialog(
      context,
      barrierDismissible: false,
      child: Text(
        "마케팅 정보 수신 및 이용에 동의하면,\n문화생활 알림을 받을 수 있어요!",
        style: AppTypeface.label16Regular,
        textAlign: TextAlign.center,
      ),
      text: "알림 받기",
      leftPressed: () => _goNext(ref),
      onPressed: () async {
        notifier.toggleTerm(TermEnum.marketingPolicy);
        ref.read(routerProvider).pop();
        await _showMarketingConfirmDialog(context, ref);
      },
    );
  }

  Future<void> _showMarketingConfirmDialog(BuildContext context, WidgetRef ref) async {
    await showTicatsDialog(
      context,
      barrierDismissible: false,
      child: Column(
        children: [
          Text("마케팅정보 앱 푸시 동의 안내", style: AppTypeface.label16Semibold),
          Text(
            "전송자: 티캣츠\n수신허용일시: ${DateFormat("yyyy년 MM월 dd일").format(DateTime.now())}\n처리내용: 수신허용 처리완료",
            style: AppTypeface.label16Regular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onPressed: () => _goNext(ref),
    );
  }

  void _goNext(WidgetRef ref) {
    ref.read(routerProvider).pop();
    ref.read(routerProvider).goNamed(Routes.registerPermission);
  }
}

class _TermAgreeCheckBox extends ConsumerWidget {
  const _TermAgreeCheckBox(this.term, this.notifier, {required this.onChanged, required this.isAgree});

  final TermEnum term;
  final Function(bool)? onChanged;
  final bool isAgree;
  final TermAgree notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termNotifier = ref.watch(termAgreeProvider.notifier);

    return Row(
      children: [
        TicatsCheckbox(value: isAgree, onChanged: onChanged),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => termNotifier.toggleTerm(term),
          child: Row(
            children: [
              SizedBox(width: 10.w),
              Text(term.text, style: AppTypeface.label16Regular),
              SizedBox(width: 8.w),
              Text(
                term.isRequired ? "(필수)" : "(선택)",
                style: AppTypeface.label16Bold.copyWith(
                  color: term.isRequired ? AppColor.primaryNormal : AppGrayscale.gray60,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text("내용보기 >", style: AppTypeface.label14Bold.copyWith(color: AppGrayscale.gray40)),
      ],
    );
  }
}
