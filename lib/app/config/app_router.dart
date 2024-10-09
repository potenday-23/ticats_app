import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/presentation/login/login_page.dart';
import 'package:ticats_app/presentation/main/main_page.dart';
import 'package:ticats_app/presentation/register/register_account_page.dart';
import 'package:ticats_app/presentation/register/register_permission_page.dart';
import 'package:ticats_app/presentation/register/register_profile_page.dart';
import 'package:ticats_app/presentation/register/register_select_entertainment_page.dart';

part 'app_router.g.dart';

class Routes {
  // Auth
  static const String login = '/login';

  // Main
  static const String main = '/main';

  // Register
  static const String registerProfile = 'profile';
  static const String registerAccount = 'account';
  static const String registerPermission = 'permission';
  static const String registerSelectEntertianment = 'select-entertainment';
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
class Router extends _$Router {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: Routes.login,
      navigatorKey: rootNavigatorKey,
      routes: [
        // Auth
        GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginPage(),
        ),

        // Main
        GoRoute(
          path: Routes.main,
          builder: (context, state) => const MainPage(),
        ),

        // Register
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterProfilePage(),
          routes: [
            GoRoute(
              path: 'profile',
              name: Routes.registerProfile,
              builder: (context, state) => const RegisterProfilePage(),
            ),
            GoRoute(
              path: 'account',
              name: Routes.registerAccount,
              builder: (context, state) => const RegisterAccountPage(),
            ),
            GoRoute(
              path: 'permission',
              name: Routes.registerPermission,
              builder: (context, state) => const RegisterPermissionPage(),
            ),
            GoRoute(
              path: 'select-entertainment',
              name: Routes.registerSelectEntertianment,
              builder: (context, state) => const RegisterSelectEntertainmentPage(),
            ),
          ],
        ),
      ],
    );
  }
}
