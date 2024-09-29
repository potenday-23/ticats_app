import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticats_app/app/enum/text_field_status.enum.dart';
import 'package:ticats_app/app/extension/input_extension.dart';
import 'package:ticats_app/domain/usecase/auth_usecases.dart';

final nickInputStateProvider = StateNotifierProvider<NickInputStateNotifier, NickInputState>((ref) {
  return NickInputStateNotifier(ref.read(authUseCasesProvider).validateNickname);
});

class NickInputState {
  final TextEditingController controller;
  final TextFieldStatus status;
  final String statusText;
  final bool isValidating;

  NickInputState({
    required this.controller,
    this.status = TextFieldStatus.normal,
    this.statusText = '',
    this.isValidating = false,
  });

  bool get isValid => status == TextFieldStatus.normal && controller.text.length > 2 && !isValidating;

  NickInputState copyWith({
    TextEditingController? controller,
    TextFieldStatus? status,
    String? statusText,
    bool? isValidating,
  }) {
    return NickInputState(
      controller: controller ?? this.controller,
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      isValidating: isValidating ?? this.isValidating,
    );
  }
}

class NickInputStateNotifier extends StateNotifier<NickInputState> {
  final ValidateNicknameUseCase _validateNickname;
  final Debouncer _debouncer = Debouncer();

  NickInputStateNotifier(this._validateNickname) : super(NickInputState(controller: TextEditingController()));

  void onNickChanged(String value) {
    state = state.copyWith(controller: state.controller..text = value, isValidating: true);
    _debouncer.debounce(
      duration: const Duration(milliseconds: 200),
      onDebounce: () => _validateNick(value),
    );
  }

  Future<void> _validateNick(String value) async {
    final validationError = value.isValidNick();
    if (validationError != null) {
      state = state.copyWith(status: TextFieldStatus.error, statusText: validationError, isValidating: false);
    } else {
      final isUnique = await _validateNickname.execute(value);
      state = state.copyWith(
        status: isUnique ? TextFieldStatus.normal : TextFieldStatus.error,
        statusText: isUnique ? '' : "이미 사용하고 있는 닉네임이에요.",
        isValidating: false,
      );
    }
  }

  void resetState() => state = NickInputState(controller: TextEditingController());
}
