import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticats_app/app/config/app_color.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_typeface.dart';
import 'package:ticats_app/app/enum/ticats_event_category.enum.dart';
import 'package:ticats_app/app/enum/ticats_event_ordering.enum.dart';

Future<void> showTicatsCheckboxBottomSheet<T>({
  required List<T> options,
  required List<T> selectedValues,
  required ValueChanged<List<T>> onChanged,
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
          return TicatsCheckboxBottomSheet(
            options: options,
            selectedValues: selectedValues,
            onChanged: onChanged,
          );
        });
  }
}

class TicatsCheckboxBottomSheet<T> extends StatefulWidget {
  final List<T> options;
  final List<T> selectedValues;
  final ValueChanged<List<T>> onChanged;

  const TicatsCheckboxBottomSheet({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
  });

  @override
  State<TicatsCheckboxBottomSheet<T>> createState() => _TicatsCheckboxBottomSheetState<T>();
}

class _TicatsCheckboxBottomSheetState<T> extends State<TicatsCheckboxBottomSheet<T>> {
  late List<T> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = widget.selectedValues;
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
                bool isSelected = selectedValues.contains(option);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 320.w,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            radioTheme: RadioThemeData(
                              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                                return AppGrayscale.gray50;
                              }),
                            )
                        ),
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(vertical: -4.h),
                          activeColor: AppColor.primaryNormal,
                          title: Text(_getEnumLabel(option), style: AppTypeface.body18Semibold.copyWith(color: isSelected ? AppColor.primaryDark : AppGrayscale.gray50)),
                          value: isSelected,
                          onChanged: (bool? checked) {
                            setState(() {
                              if (checked == true) {
                                if (option == TicatsEventCategory.ALL) {
                                  selectedValues.clear();
                                  selectedValues.add(option);
                                } else {
                                  selectedValues.remove(TicatsEventCategory.ALL);
                                  selectedValues.add(option);
                                }
                              } else {
                                selectedValues.remove(option);
                              }
                            });
                            widget.onChanged(selectedValues);
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
    if (value is TicatsEventCategory) {
      return value.label;
    }
    return '';
  }
}
