import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final abadNameListProvider =
    StateNotifierProvider<FirstNameListNotifier, List<String>>((ref) {
  return FirstNameListNotifier();
});

class FirstNameListNotifier extends StateNotifier<List<String>> {
  FirstNameListNotifier() : super([]) {
    loadOnRealTime();
  }

  final nameRef = FireStoreFactory.abadNamesRef();

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

final secondNameListProvider = StateNotifierProvider<SecondNameListNotifier, List<String>>((ref) {
  return SecondNameListNotifier();
});

class SecondNameListNotifier extends StateNotifier<List<String>> {
  SecondNameListNotifier() : super([]) {
    loadOnRealTime();
  }

  final nameRef = FireStoreFactory.secondNamesRef();

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