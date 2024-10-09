import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_radius.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/gen/assets.gen.dart';

Future<void> showTicatsBottomNotification() async {
  final context = rootNavigatorKey.currentContext;

  if (context != null) {
    await context.showToast(
      const _TicatsTimerNotification(duration: 5),
      duration: const Duration(seconds: 5),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.large),
      queue: false,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.zero,
      elevation: 2,
      margin: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, MediaQuery.of(context).padding.bottom + 46.h),
    );
  }
}

class _TicatsTimerNotification extends StatefulWidget {
  const _TicatsTimerNotification({required this.duration});

  final int duration;

  @override
  _TicatsTimerNotificationState createState() => _TicatsTimerNotificationState();
}

class _TicatsTimerNotificationState extends State<_TicatsTimerNotification> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: widget.duration));
    _controller.addListener(() => setState(() {}));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor.pointNormal),
        borderRadius: AppRadius.large,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(32.w, 20.w, 24.w, 12.w),
            child: Row(
              children: [
                Assets.icons.notification.svg(width: 32.w, height: 32.w),
                SizedBox(width: 20.w),
                Expanded(
                  child: Text(
                    '티케팅 시작 30분 전,\n푸쉬 알림을 통해 알려드릴게요!',
                    style: AppTypeface.label14Medium,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: AppRadius.large.bottomLeft,
              bottomRight: AppRadius.large.bottomRight,
            ),
            child: LinearProgressIndicator(
              value: _controller.value,
              minHeight: 8.0,
              backgroundColor: Colors.transparent,
              color: AppColor.pointNormal,
            ),
          ),
        ],
      ),
    );
  }
}
