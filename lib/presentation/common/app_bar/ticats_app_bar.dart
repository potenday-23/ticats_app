import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_typeface.dart';

class TicatsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const TicatsAppBar(
    this.title, {
    super.key,
    this.action,
    this.hasBack = false,
    this.leading,
  });

  factory TicatsAppBar.back(title) => TicatsAppBar(title, hasBack: true);

  final Widget? action;
  final String title;
  final List<Widget>? leading;
  final bool hasBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title, style: AppTypeface.label16Semibold),
      leading: action ??
          (hasBack
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () => ref.read(routerProvider).pop(),
                )
              : null),
      leadingWidth: action != null || hasBack ? 60.w : null,
      actions: [
        SizedBox(
          width: 60.w,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: leading ?? []),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(54.h);
}
