import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:ticats_app/app/config/app_router.dart';
import 'package:ticats_app/app/config/app_theme.dart';
import 'package:ticats_app/data/repository_impl/setting_repository_impl.dart';

Future<void> main() async {
  // Wait for the dependencies to be configured
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize talker
  final talker = TalkerFlutter.init();

  // Initialize kakao sdk
  KakaoSdk.init(nativeAppKey: "e431334bbd653b087fa3bdc1d431c42e");

  // Initialize Naver Map
  await NaverMapSdk.instance.initialize();

  // Create provider container
  final container = ProviderContainer(
    observers: [TalkerRiverpodObserver(talker: talker)],
  );

  // Initialize settings
  await container.read(initializeSettingProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 880),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp.router(routerConfig: router, theme: AppTheme.appTheme);
      },
    );
  }
}
