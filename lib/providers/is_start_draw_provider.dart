import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final isStartDrawProvider = StateNotifierProvider<IsStartDrawNotifier, bool?>(
  (ref) => IsStartDrawNotifier(),
);

class IsStartDrawNotifier extends StateNotifier<bool?> {
  IsStartDrawNotifier() : super(null) {
    loadOnRealTime();
  }

  final adminOptionRef = FireStoreFactory.adminOptionRef();

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
        {'is_start_draw': false, 'is_draw_end': false},
      );
      state = false;
    });
  }
}
