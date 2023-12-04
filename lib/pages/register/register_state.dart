import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/name_register_provider.dart';

abstract class RegisterState {
  RegisterState(this.text, this.errorText);

  final String text;
  final String errorText;

  void check(WidgetRef ref, String text);
  bool getOpposite();
}

class CanRegisterState implements RegisterState {
  @override
  void check(WidgetRef ref, String text) {
    ref
        .read(nameRegisterProvider.notifier)
        .registerNameToFirestore(text);
  }

  @override
  bool getOpposite() {
    return false;
  }

  @override
  String get text => '현재상태: 열림';

  @override
  String get errorText => '';
}

class CannotRegisterState implements RegisterState {
  @override
  void check(WidgetRef ref, String text) {
    ref.read(nameRegisterProvider.notifier).checkAdmin(text);
  }

  @override
  bool getOpposite() {
    return true;
  }

  @override
  String get text => '현재상태: 닫힘';

  @override
  String get errorText => '지금은 등록할 수 없습니다.';
}

class EmptyRegisterState implements RegisterState {
  @override
  void check(WidgetRef ref, String text) {
  }

  @override
  bool getOpposite() {
    return true;
  }

  @override
  String get text => '';

  @override
  String get errorText => '';

}

class ErrorRegisterState implements RegisterState {
  @override
  void check(WidgetRef ref, String text) {

  }

  @override
  bool getOpposite() {
    return true;
  }

  @override
  String get text => '현재상태: 에러';

  @override
  String get errorText => '';
}
