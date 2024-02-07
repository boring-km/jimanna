import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final currentRegisteredNamesProvider =
    StateNotifierProvider<CurrentRegisteredNamesNotifier, List<String>>((ref) {
  return CurrentRegisteredNamesNotifier();
});

class CurrentRegisteredNamesNotifier extends StateNotifier<List<String>> {
  CurrentRegisteredNamesNotifier() : super([]) {
    loadOnRealTime();
  }

  final nameRef = FireStoreFactory.namesByCurrentYearMonthRef;

  void loadOnRealTime() {
    nameRef.snapshots().listen((event) {
      state = event.docs.map((e) => e.data().name).toList();
    });
  }

  void removeAll() {
    nameRef.get().then((value) {
      for (final element in value.docs) {
        nameRef.doc(element.id).delete();
      }
    });
    state = [];
  }
}
