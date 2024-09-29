import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ticats_app/app/base/base_view.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/presentation/common/widget/ticats_underline_text_field.dart';

import '../provider/register_provider.dart';

class AccountInputView extends BaseView {
  const AccountInputView({super.key});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    final registerProv = ref.watch(registerProvider);
    final registerNotifier = ref.watch(registerProvider.notifier);

    final emailController = useTextEditingController(text: registerProv.email ?? "");
    final birthController = useTextEditingController();

    useEffect(() {
      emailController.text = registerProv.email ?? "";
      return null;
    }, [registerProv.email, registerProv.birthday, registerProv.gender]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        _buildInputField(
          label: "이메일",
          child: TicatsUnderlineTextField(
            isEnabled: registerProv.provider == "APPLE",
            hintText: "ticats1020@gmail.com 형식으로 작성해주세요.",
            controller: emailController,
            onChanged: (value) => registerNotifier.setEmail(value),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(height: 56.h),
        _buildInputField(
          label: "생년월일",
          child: TicatsUnderlineTextField(
            hintText: "생년월일 6자리를 입력해주세요.",
            keyboardType: TextInputType.number,
            controller: birthController,
            maxLength: 6,
            onChanged: (value) => registerNotifier.setBirthday(value),
          ),
        ),
        SizedBox(height: 56.h),
      ],
    );
  }

  Widget _buildInputField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(label, style: AppTypeface.label16Semibold),
        ),
        SizedBox(height: 10.h),
        child,
      ],
    );
  }
}
