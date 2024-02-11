import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/black_twin.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final adminBlackListProvider =
    StateNotifierProvider<AdminBlackListNotifier, List<BlackTwin>>((ref) {
  return AdminBlackListNotifier();
});

class AdminBlackListNotifier extends StateNotifier<List<BlackTwin>> {
  AdminBlackListNotifier() : super([]) {
    loadOnRealTime();
  }

  final blackRef = FireStoreFactory.blackTwinRef();

  void loadOnRealTime() {
    blackRef.snapshots().listen((event) {
      state = event.docs.map((e) => e.data()).toList();
    });
  }

  void remove(BlackTwin blackTwin) {
    blackRef
        .where('name_first', isEqualTo: blackTwin.name_first)
        .where('name_second', isEqualTo: blackTwin.name_second)
        .get()
        .then((value) {
      blackRef.doc(value.docs.first.id).delete();
    });
  }

  void add(String name_first, String name_second) {
    blackRef.add(BlackTwin(name_first: name_first, name_second: name_second));
  }
}
