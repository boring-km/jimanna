import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final isStartDrawProvider = NotifierProvider<IsStartDrawNotifier, bool?>(
  IsStartDrawNotifier.new,
);

class IsStartDrawNotifier extends Notifier<bool?> {
  late final adminOptionRef = FireStoreFactory.adminOptionRef();

  @override
  bool? build() {
    final sub = adminOptionRef.snapshots().listen((event) {
      state = event.docs.first.data().is_start_draw;
    });
    ref.onDispose(sub.cancel);
    return null;
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
        {
          'is_start_draw': false,
          'is_draw_end': false,
          'current_showed_team_number': 0,
        },
      );
      state = false;
    });
  }
}
