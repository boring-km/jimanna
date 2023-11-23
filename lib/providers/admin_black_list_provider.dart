import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/black_twin.dart';

final adminBlackListProvider =
    StateNotifierProvider<AdminBlackListNotifier, List<BlackTwin>>((ref) {
  return AdminBlackListNotifier();
});

class AdminBlackListNotifier extends StateNotifier<List<BlackTwin>> {
  AdminBlackListNotifier() : super([]) {
    blackRef = FirebaseFirestore.instance.collection('blacklist').withConverter(
        fromFirestore: (sn, _) => BlackTwin.fromJson(sn.data()!),
        toFirestore: (name, _) => name.toJson());
    loadOnRealTime();
  }

  late final CollectionReference<BlackTwin> blackRef;

  void loadOnRealTime() {
    blackRef.snapshots().listen((event) {
      var list = event.docs.map((e) => e.data()).toList();
      state = list;
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
