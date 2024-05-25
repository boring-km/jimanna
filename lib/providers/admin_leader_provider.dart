import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final adminLeaderProvider = StateNotifierProvider<AdminLeaderProvider, List<Name>>((ref) {
  return AdminLeaderProvider();
});

class AdminLeaderProvider extends StateNotifier<List<Name>> {
  AdminLeaderProvider() : super([]) {
    loadOnRealTime();
  }

  final nameRef = FireStoreFactory.leadersRef();

  void loadOnRealTime() {
    nameRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data()).toList();
      for (final element in list) {
        print('${element.name} ${element.type}');
      }
      state = list;
    });
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
