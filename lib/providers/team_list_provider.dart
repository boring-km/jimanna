import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final teamListProvider = NotifierProvider<TeamListNotifier, List<Team>>(
  TeamListNotifier.new,
);

class TeamListNotifier extends Notifier<List<Team>> {
  late final teamRef = FireStoreFactory.teamRef();

  @override
  List<Team> build() {
    final sub = teamRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data()).toList();
      state = list;
    });
    ref.onDispose(sub.cancel);
    return [];
  }
}
