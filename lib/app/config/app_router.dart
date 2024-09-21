import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/presentation/main/main_page.dart';

part 'app_router.g.dart';

class Routes {
  // Main
  static const String main = '/main';
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
class Router extends _$Router {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: Routes.main,
      navigatorKey: rootNavigatorKey,
      routes: [
        // Main
        GoRoute(
          path: Routes.main,
          builder: (context, state) => const MainPage(),
        ),
      ],
    );
  }
}
