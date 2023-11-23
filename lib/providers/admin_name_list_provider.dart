import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';

final adminNameListProvider = StateNotifierProvider<AdminNameListNotifier, List<String>>((ref) {
  return AdminNameListNotifier();
});

class AdminNameListNotifier extends StateNotifier<List<String>> {
  AdminNameListNotifier() : super([]) {
    nameRef = FirebaseFirestore.instance
        .collection('names')
        .withConverter(
        fromFirestore: (sn, _) => Name.fromJson(sn.data()!),
        toFirestore: (name, _) => name.toJson());
    loadOnRealTime();
  }

  late final CollectionReference<Name> nameRef;

  void loadOnRealTime() {
    nameRef.snapshots().listen((event) {
      var list = event.docs.map((e) => e.data().name).toList();
      list.sort();
      state = list;
    });
  }

  void remove(String name) {
    nameRef.where('name', isEqualTo: name).get().then((value) {
      nameRef.doc(value.docs.first.id).delete();
    });
  }

  void register(String name) {
    nameRef.add(Name(name));
  }
}