import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/pages/register/register_state.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final registerStateProvider =
    NotifierProvider<RegisterStateProvider, RegisterState>(
  RegisterStateProvider.new,
);

class RegisterStateProvider extends Notifier<RegisterState> {
  late final adminOptionRef = FireStoreFactory.adminOptionRef();

  @override
  RegisterState build() {
    final sub = adminOptionRef.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        if (event.docs.first.data().can_register) {
          state = CanRegisterState();
        } else {
          state = CannotRegisterState();
        }
      } else {
        state = ErrorRegisterState('시스템 오류');
      }
    });
    ref.onDispose(sub.cancel);
    return EmptyRegisterState();
  }

  void switchEvent() {
    adminOptionRef.get().then((value) {
      adminOptionRef.doc(value.docs.first.id).update({
        'can_register': state.getOpposite(),
      });
    });
  }

  void setError(String message) {
    state = ErrorRegisterState(message);
  }
}
