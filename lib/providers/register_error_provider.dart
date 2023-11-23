import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerErrorProvider = StateNotifierProvider<RegisterErrorNotifier, String>((ref) {
  return RegisterErrorNotifier();
});

class RegisterErrorNotifier extends StateNotifier<String> {
  RegisterErrorNotifier() : super('');

  void setError(String? error) {
    state = error ?? '';
  }
}