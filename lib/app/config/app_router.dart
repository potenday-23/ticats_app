import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/presentation/event_detail/event_detail_page.dart';
import 'package:ticats_app/presentation/event_list/event_list_of_category_page.dart';
import 'package:ticats_app/presentation/login/login_page.dart';
import 'package:ticats_app/presentation/event_list/event_list_page.dart';
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

  // Event List
  static const String eventListOfCategory = '/eventList/category';
  static const String eventList = '/eventList';

  // Event Detail
  static const String eventDetail = '/eventDetail';

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

        // Event List
        GoRoute(
          path: Routes.eventListOfCategory,
          name: Routes.eventListOfCategory,
          builder: (context, state) => EventListOfCategoryPage(categoryName: state.uri.queryParameters['category'] as String),
        ),

        GoRoute(
          path: Routes.eventList,
          name: Routes.eventList,
          builder: (context, state) => EventListPage(title: state.uri.queryParameters['title'] as String),
        ),

        // Event Detail
        GoRoute(
          path: Routes.eventDetail,
          name: Routes.eventDetail,
          builder: (context, state) => EventDetailPage(
            id: int.parse(state.uri.queryParameters['id']!),
            title: state.uri.queryParameters['title']!,
          ),
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
