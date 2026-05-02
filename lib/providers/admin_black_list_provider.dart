import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/black_twin.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final adminBlackListProvider =
    NotifierProvider<AdminBlackListNotifier, List<BlackTwin>>(
  AdminBlackListNotifier.new,
);

class AdminBlackListNotifier extends Notifier<List<BlackTwin>> {
  late final blackRef = FireStoreFactory.blackTwinRef();

  @override
  List<BlackTwin> build() {
    final sub = blackRef.snapshots().listen((event) {
      state = event.docs.map((e) => e.data()).toList();
    });
    ref.onDispose(sub.cancel);
    return [];
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
