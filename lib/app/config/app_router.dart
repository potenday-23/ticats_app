import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/presentation/event_detail/event_detail_page.dart';
import 'package:ticats_app/presentation/event_list/event_list_of_category_page.dart';
import 'package:ticats_app/presentation/main/main_page.dart';

part 'app_router.g.dart';

class Routes {
  // Main
  static const String main = '/main';

  // Event List
  static const String eventListOfCategory = '/eventList/category';

  // Event Detail
  static const String eventDetail = '/eventDetail';
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

        // Event List
        GoRoute(
          path: Routes.eventListOfCategory,
          name: Routes.eventListOfCategory,
          builder: (context, state) => EventListOfCategoryPage(
              categoryName: state.uri.queryParameters['category'] as String
          )
        ),

        // Event Detail
        GoRoute(
          path: Routes.eventDetail,
          name: Routes.eventDetail,
          builder: (context, state) => EventDetailPage(int.parse(state.uri.queryParameters['id']!))
        )
      ],
    );
  }
}
