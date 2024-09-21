import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_page_provider.freezed.dart';
part 'main_page_provider.g.dart';

@freezed
sealed class MainPageState with _$MainPageState {
  const factory MainPageState({
    @Default(0) int bottomNavigationBarIndex,
  }) = _MainPageState;
}

@Riverpod(keepAlive: true)
class MainPageController extends _$MainPageController {
  @override
  MainPageState build() {
    return const MainPageState();
  }

  void setBottomNavigationBarIndex(int index) {
    state = state.copyWith(bottomNavigationBarIndex: index);
  }
}
