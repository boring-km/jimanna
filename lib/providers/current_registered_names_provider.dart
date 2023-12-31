import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/utils/date_utils.dart';

final currentRegisteredNamesProvider =
    StateNotifierProvider<CurrentRegisteredNamesNotifier, List<String>>((ref) {
  return CurrentRegisteredNamesNotifier();
});

class CurrentRegisteredNamesNotifier extends StateNotifier<List<String>> {
  CurrentRegisteredNamesNotifier() : super([]) {
    final yearMonth = getYearMonthOnly();
    nameRef = FirebaseFirestore.instance.collection(yearMonth).withConverter(
          fromFirestore: (sn, _) => Name.fromJson(sn.data()!),
          toFirestore: (name, _) => name.toJson(),
        );

    loadOnRealTime();
  }

  late final CollectionReference<Name> nameRef;

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
