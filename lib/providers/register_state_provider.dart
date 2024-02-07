import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/pages/register/register_state.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final registerStateProvider =
    StateNotifierProvider<RegisterStateProvider, RegisterState>((ref) {
  return RegisterStateProvider();
});

class RegisterStateProvider extends StateNotifier<RegisterState> {
  RegisterStateProvider() : super(EmptyRegisterState()) {
    loadOnRealTime();
  }

  final adminOptionRef = FireStoreFactory.adminOptionRef;

  void loadOnRealTime() {
    adminOptionRef.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        if (event.docs.first.data().can_register) {
          state = CanRegisterState();
        } else {
          state = CannotRegisterState();
        }
      } else {
        state = ErrorRegisterState();
      }
    });
  }

  void switchEvent() {
    adminOptionRef.get().then((value) {
      adminOptionRef.doc(value.docs.first.id).update({
        'can_register': state.getOpposite(),
      });
    });
  }

  void setError() {
    state = ErrorRegisterState();
  }
}
