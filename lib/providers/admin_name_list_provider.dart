import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final abadNameListProvider =
    NotifierProvider<FirstNameListNotifier, List<String>>(
  FirstNameListNotifier.new,
);

class FirstNameListNotifier extends Notifier<List<String>> {
  late final nameRef = FireStoreFactory.abadNamesRef();

  @override
  List<String> build() {
    final sub = nameRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data().name).toList()..sort();
      state = list;
    });
    ref.onDispose(sub.cancel);
    return [];
  }

  void remove(String name) {
    nameRef.where('name', isEqualTo: name).get().then((value) {
      nameRef.doc(value.docs.first.id).delete();
    });
  }

  void register(String name, {void Function()? onError}) {
    nameRef.where('name', isEqualTo: name).get().then((value) {
      if (value.docs.isEmpty) {
        nameRef.add(Name(name, type: 'abad'));
      } else {
        onError?.call();
      }
    });
  }
}

final secondNameListProvider =
    NotifierProvider<SecondNameListNotifier, List<String>>(
  SecondNameListNotifier.new,
);

class SecondNameListNotifier extends Notifier<List<String>> {
  late final nameRef = FireStoreFactory.secondNamesRef();

  @override
  List<String> build() {
    final sub = nameRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data().name).toList()..sort();
      state = list;
    });
    ref.onDispose(sub.cancel);
    return [];
  }

  void remove(String name) {
    nameRef.where('name', isEqualTo: name).get().then((value) {
      nameRef.doc(value.docs.first.id).delete();
    });
  }

  void register(String name, {void Function()? onError}) {
    nameRef.where('name', isEqualTo: name).get().then((value) {
      if (value.docs.isEmpty) {
        nameRef.add(Name(name, type: 'paqad'));
      } else {
        onError?.call();
      }
    });
  }
}
