import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ticats_app/app/enum/term.enum.dart';
import 'package:ticats_app/domain/entity/state/term_agree_state.dart';

part 'term_agree_provider.g.dart';

@riverpod
class TermAgree extends _$TermAgree {
  @override
  TermAgreeState build() {
    return const TermAgreeState();
  }

  bool get isAllAgree {
    return state.checkUsage && state.checkPrivacy && state.checkLocation && state.checkMarketing;
  }

  bool get isRequiredAgree {
    return state.checkUsage && state.checkPrivacy && state.checkLocation;
  }

  void checkAllAgree() {
    isAllAgree
        ? state = const TermAgreeState()
        : state = const TermAgreeState(checkUsage: true, checkPrivacy: true, checkLocation: true, checkMarketing: true);
  }

  void toggleTerm(TermEnum term) {
    switch (term) {
      case TermEnum.termOfUse:
        state = state.copyWith(checkUsage: !state.checkUsage);
      case TermEnum.privacyPolicy:
        state = state.copyWith(checkPrivacy: !state.checkPrivacy);
      case TermEnum.locationPolicy:
        state = state.copyWith(checkLocation: !state.checkLocation);
      case TermEnum.marketingPolicy:
        state = state.copyWith(checkMarketing: !state.checkMarketing);
    }
  }
}
