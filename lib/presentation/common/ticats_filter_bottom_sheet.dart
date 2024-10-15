import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/ticats_event_ordering.enum.dart';

Future<void> showTicatFilterBottomSheet<T>({
  required List<T> options,
  required T groupValue,
  required ValueChanged<T> onChanged,
}) async {
  final context = rootNavigatorKey.currentContext;

  if (context != null) {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        isScrollControlled: false,
        isDismissible: true,
        builder: (context) {
          return TicatsFilterBottomSheet(
            options: options,
            groupValue: groupValue,
            onChanged: onChanged,
          );
        });
  }
}

class TicatsFilterBottomSheet<T> extends StatefulWidget {
  final List<T> options;
  final T groupValue;
  final ValueChanged<T> onChanged;

  const TicatsFilterBottomSheet({
    super.key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<TicatsFilterBottomSheet<T>> createState() => _TicatsFilterBottomSheetState<T>();
}

class _TicatsFilterBottomSheetState<T> extends State<TicatsFilterBottomSheet<T>> {
  late T groupValue;

  @override
  void initState() {
    super.initState();
    groupValue = widget.groupValue;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.only(left: 35.w, top: 24.h, right: 35.w, bottom: 58.h),
          width: double.infinity,
          child: Column(
            children: [
              Text('정렬', style: AppTypeface.body20Bold, textAlign: TextAlign.center),
              SizedBox(height: 32.h),
              ...widget.options.map((option) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 320.w,
                      child: RadioListTile<T>(
                        title: Text(_getEnumLabel(option)),
                        value: option,
                        groupValue: groupValue,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              groupValue = value;
                            });

                            widget.onChanged(value);
                          }
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    )
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  String _getEnumLabel(T value) {
    if (value is TicatsEventOrdering) {
      return value.label;
    }
    return '';
  }
}
