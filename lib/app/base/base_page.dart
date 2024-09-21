import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// from https://github.com/MakeFrog/TechTalk
abstract class BasePage extends HookConsumerWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        onInit(ref);
        return () => onDispose(ref);
      },
      [],
    );

    useOnAppLifecycleStateChange((previousState, state) {
      switch (state) {
        case AppLifecycleState.resumed:
          onResumed(ref);
          break;
        case AppLifecycleState.paused:
          onPaused(ref);
          break;
        case AppLifecycleState.inactive:
          onInactive(ref);
          break;
        case AppLifecycleState.detached:
          onDetached(ref);
          break;
        case AppLifecycleState.hidden:
          break;
      }
    });

    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        onWillPop(ref);
      },
      child: GestureDetector(
        onTap: !preventAutoUnfocus ? () => FocusManager.instance.primaryFocus?.unfocus() : null,
        child: Container(
          color: unSafeAreaColor,
          child: wrapWithSafeArea
              ? SafeArea(
                  top: setTopSafeArea,
                  bottom: setBottomSafeArea,
                  child: _buildScaffold(context, ref),
                )
              : _buildScaffold(context, ref),
        ),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context, ref),
      body: buildPage(context, ref),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      bottomSheet: buildBottomSheet(ref),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton(ref),
    );
  }

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  Widget? buildBottomSheet(WidgetRef ref) => null;

  @protected
  Widget buildPage(BuildContext context, WidgetRef ref);

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => null;

  @protected
  Widget? buildFloatingActionButton(WidgetRef ref) => null;

  @protected
  Color? get unSafeAreaColor => Colors.white;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @protected
  bool get extendBodyBehindAppBar => false;

  @protected
  bool get canPop => true;

  @protected
  Color? get screenBackgroundColor => Colors.white;

  @protected
  bool get wrapWithSafeArea => true;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  @protected
  bool get preventAutoUnfocus => false;

  @protected
  void onResumed(WidgetRef ref) {}

  @protected
  void onPaused(WidgetRef ref) {}

  @protected
  void onInactive(WidgetRef ref) {}

  @protected
  void onDetached(WidgetRef ref) {}

  @protected
  void onInit(WidgetRef ref) {}

  @protected
  void onDispose(WidgetRef ref) {}

  @protected
  void onWillPop(WidgetRef ref) {}
}
