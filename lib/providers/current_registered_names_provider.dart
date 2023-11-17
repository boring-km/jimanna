import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';

final currentRegisteredNamesProvider = StateNotifierProvider<CurrentRegisteredNamesNotifier, List<String>>((ref) {
  return CurrentRegisteredNamesNotifier();
});

class CurrentRegisteredNamesNotifier extends StateNotifier<List<String>> {

  late final CollectionReference<Name> nameRef;

  CurrentRegisteredNamesNotifier() : super([]) {
    var now = DateTime.now();
    var yearMonth = now.year.toString() + now.month.toString().padLeft(2, '0');
    nameRef = FirebaseFirestore.instance
        .collection(yearMonth)
        .withConverter(
    fromFirestore: (sn, _) => Name.fromJson(sn.data()!),
    toFirestore: (name, _) => name.toJson());
  }

  void loadOnRealTime() {
    nameRef.snapshots().listen((event) {
      state = event.docs.map((e) => e.data().name).toList();
    });
  }

  void remove(String name) {
    state = state.where((element) => element != name).toList();
  }
}