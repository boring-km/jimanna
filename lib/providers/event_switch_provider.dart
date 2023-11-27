import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/admin_option.dart';
import 'package:jimanna/models/result.dart';

final eventSwitchProvider = StateNotifierProvider<EventSwitchNotifier, Result<bool>>((ref) {
  return EventSwitchNotifier();
});

class EventSwitchNotifier extends StateNotifier<Result<bool>> {
  EventSwitchNotifier() : super(const Result.empty()) {

    adminOptionRef = FirebaseFirestore.instance.collection('admin').withConverter(
        fromFirestore: (data, _) => AdminOption.fromJson(data.data()!),
        toFirestore: (data, _) => data.toJson());
    loadOnRealTime();
  }

  late final CollectionReference<AdminOption> adminOptionRef;

  void loadOnRealTime() {
    adminOptionRef.snapshots().listen((event) {
      state = Result.success(event.docs.first.data().can_register);
    });
  }

  void switchEvent() {
    adminOptionRef.get().then((value) {
      adminOptionRef.doc(value.docs.first.id).update({
        'can_register': !(state as Success<bool>).data,
      });
    });
  }
}