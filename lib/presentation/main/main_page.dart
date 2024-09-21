import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticats_app/app/base/base_page.dart';
import 'package:ticats_app/presentation/home/home_view.dart';
import 'package:ticats_app/presentation/main/provider/main_page_provider.dart';

import 'widget/ticats_bottom_navigation_bar.dart';

final List<Widget> _pages = [
  const HomeView(),
  const HomeView(),
  const HomeView(),
  const HomeView(),
  const HomeView(),
];

class MainPage extends BasePage {
  const MainPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(mainPageControllerProvider);

    return IndexedStack(index: controller.bottomNavigationBarIndex, children: _pages);
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) => const TicatsBottomNavigationBar();
}
