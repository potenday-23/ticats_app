import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

void main() {
  // Wait for the dependencies to be configured
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize talker
  TalkerFlutter.init();

  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver()],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 880),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Hello World!'),
            ),
          ),
        );
      },
    );
  }
}
