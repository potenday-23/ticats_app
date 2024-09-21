import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';

class TicatsEventStatusChip extends ConsumerWidget {
  const TicatsEventStatusChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
      decoration: BoxDecoration(
        borderRadius: AppRadius.full,
        color: AppColor.systemError,
      ),
      child: Text("티켓 오픈", style: TextStyle(fontSize: 10.sp, color: AppColor.white, fontWeight: FontWeight.w600)),
    );
  }
}
