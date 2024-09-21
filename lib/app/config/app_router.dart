import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/app/presentation/home/home_page.dart';

part 'app_router.g.dart';

class Routes {
  // Home
  static const String home = '/home';
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
class Router extends _$Router {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: Routes.home,
      navigatorKey: rootNavigatorKey,
      routes: [
        // Home
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const HomePage(),
        ),
      ],
    );
  }
}

