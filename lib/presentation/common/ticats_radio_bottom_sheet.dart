import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/ticats_event_ordering.enum.dart';

Future<void> showTicatsRadioBottomSheet<T>({
  required List<T> options,
  required T groupValue,
  required ValueChanged<T> onChanged,
}) async {
  final context = rootNavigatorKey.currentContext;

  if (context != null) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColor.white,
        elevation: 0,
        isScrollControlled: false,
        isDismissible: true,
        builder: (context) {
          return TicatsRadioBottomSheet(
            options: options,
            groupValue: groupValue,
            onChanged: onChanged,
          );
        });
  }
}

class TicatsRadioBottomSheet<T> extends StatefulWidget {
  final List<T> options;
  final T groupValue;
  final ValueChanged<T> onChanged;

  const TicatsRadioBottomSheet({
    super.key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<TicatsRadioBottomSheet<T>> createState() => _TicatsRadioBottomSheetState<T>();
}

class _TicatsRadioBottomSheetState<T> extends State<TicatsRadioBottomSheet<T>> {
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
                bool isSelected = groupValue == option;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 320.w,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            radioTheme: RadioThemeData(
                              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                                return AppGrayscale.gray50; // 선택되지 않은 상태의 색상
                              }),
                            )
                        ),
                        child: RadioListTile<T>(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(vertical: -4.h),
                          activeColor: AppColor.primaryNormal,
                          title: Text(_getEnumLabel(option), style: AppTypeface.body18Semibold.copyWith(color: isSelected ? AppColor.primaryDark : AppGrayscale.gray50)),
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
