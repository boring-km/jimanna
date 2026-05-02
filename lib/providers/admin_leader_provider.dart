import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final adminLeaderProvider =
    NotifierProvider<AdminLeaderProvider, List<Name>>(
  AdminLeaderProvider.new,
);

class AdminLeaderProvider extends Notifier<List<Name>> {
  late final nameRef = FireStoreFactory.leadersRef();

  @override
  List<Name> build() {
    final sub = nameRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data()).toList();
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

  void register(String name, String type, {void Function()? onError}) {
    nameRef.where('name', isEqualTo: name).get().then((value) {
      if (value.docs.isEmpty) {
        nameRef.add(Name(name, type: type));
      } else {
        onError?.call();
      }
    });
  }
}
