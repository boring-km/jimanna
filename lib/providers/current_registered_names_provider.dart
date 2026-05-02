import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final currentRegisteredNamesProvider =
    NotifierProvider<CurrentRegisteredNamesNotifier, List<Name>>(
  CurrentRegisteredNamesNotifier.new,
);

class CurrentRegisteredNamesNotifier extends Notifier<List<Name>> {
  late final nameRef = FireStoreFactory.namesByCurrentYearMonthRef();

  @override
  List<Name> build() {
    final sub = nameRef.snapshots().listen((event) {
      state = event.docs.map((e) => e.data()).toList().reversed.toList();
    });
    ref.onDispose(sub.cancel);
    return [];
  }

  void removeAll() {
    nameRef.get().then((value) {
      for (final element in value.docs) {
        nameRef.doc(element.id).delete();
      }
    });
    state = [];
  }

  void removeByName(String name) {
    nameRef.where('name', isEqualTo: name).get().then((value) {
      nameRef.doc(value.docs.first.id).delete();
    });
  }

  String countText() {
    final abadCount = state.where((Name element) => element.type == 'abad').length;
    final secondCount =
        state.where((Name element) => element.type == 'paqad').length;
    return 'abad: $abadCount, paqad: $secondCount';
  }
}
