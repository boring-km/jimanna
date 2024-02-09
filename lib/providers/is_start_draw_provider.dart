import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/admin_option.dart';

final isStartDrawProvider = StateNotifierProvider<IsStartDrawNotifier, bool?>(
  (ref) => IsStartDrawNotifier(),
);

class IsStartDrawNotifier extends StateNotifier<bool?> {
  IsStartDrawNotifier() : super(null) {
    loadOnRealTime();
  }

  final adminOptionRef = FirebaseFirestore.instance.collection('admin').withConverter(
    fromFirestore: (sn, _) => AdminOption.fromJson(sn.data()!),
    toFirestore: (adminOption, _) => adminOption.toJson(),
  );

  void loadOnRealTime() {
    adminOptionRef.snapshots().listen((event) {
      state = event.docs.first.data().is_start_draw;
    });
  }

  void startDraw() {
    adminOptionRef.get().then((value) {
      adminOptionRef.doc(value.docs.first.id).update(
        {'is_start_draw': true},
      );
      state = true;
    });
  }

  void resetDraw() {
    adminOptionRef.get().then((value) {
      adminOptionRef.doc(value.docs.first.id).update(
        {'is_start_draw': false},
      );
      state = false;
    });
  }
}
