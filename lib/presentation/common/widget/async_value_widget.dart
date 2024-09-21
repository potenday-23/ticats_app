import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.w),
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }
}
