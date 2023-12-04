import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/admin_option.dart';
import 'package:jimanna/pages/register/register_state.dart';

final registerStateProvider =
    StateNotifierProvider<EventSwitchNotifier, RegisterState>((ref) {
  return EventSwitchNotifier();
});

class EventSwitchNotifier extends StateNotifier<RegisterState> {
  EventSwitchNotifier() : super(EmptyRegisterState()) {
    adminOptionRef =
        FirebaseFirestore.instance.collection('admin').withConverter(
              fromFirestore: (data, _) => AdminOption.fromJson(data.data()!),
              toFirestore: (data, _) => data.toJson(),
            );
    loadOnRealTime();
  }

  late final CollectionReference<AdminOption> adminOptionRef;

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
