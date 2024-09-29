import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';

class TicatsCheckbox extends ConsumerWidget {
  TicatsCheckbox({
    this.value = false,
    this.onChanged,
    super.key,
  });

  final int id = UniqueKey().hashCode;
  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Checkbox(
      value: value,
      activeColor: AppColor.positiveBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.r)),
      onChanged: onChanged == null ? null : (value) => onChanged!(value!),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
