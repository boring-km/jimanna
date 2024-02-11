import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final adminNameListProvider =
    StateNotifierProvider<AdminNameListNotifier, List<String>>((ref) {
  return AdminNameListNotifier();
});

class AdminNameListNotifier extends StateNotifier<List<String>> {
  AdminNameListNotifier() : super([]) {
    loadOnRealTime();
  }

  final nameRef = FireStoreFactory.namesRef();

  void loadOnRealTime() {
    nameRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data().name).toList()..sort();
      state = list;
    });
  }

  void remove(String name) {
    nameRef.where('name', isEqualTo: name).get().then((value) {
      nameRef.doc(value.docs.first.id).delete();
    });
  }

  void register(String name, {void Function()? onError}) {
    nameRef.where('name', isEqualTo: name).get().then((value) {
      if (value.docs.isEmpty) {
        nameRef.add(Name(name));
      } else {
        onError?.call();
      }
    });
  }
}
