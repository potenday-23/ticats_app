import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticats_app/app/enum/term.enum.dart';

part 'term_agree_state.freezed.dart';

@freezed
class TermAgreeState with _$TermAgreeState {
  const factory TermAgreeState({
    @Default(false) bool checkUsage,
    @Default(false) bool checkPrivacy,
    @Default(false) bool checkLocation,
    @Default(false) bool checkMarketing,
  }) = _TermAgreeState;
}

extension TermAgreeX on TermAgreeState {
  bool getTermValue(TermEnum term) {
    switch (term) {
      case TermEnum.termOfUse:
        return checkUsage;
      case TermEnum.privacyPolicy:
        return checkPrivacy;
      case TermEnum.locationPolicy:
        return checkLocation;
      case TermEnum.marketingPolicy:
        return checkMarketing;
    }
  }
}
