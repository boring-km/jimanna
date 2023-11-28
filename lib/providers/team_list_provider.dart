import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/team.dart';

final teamListProvider = StateNotifierProvider<TeamListNotifier, List<Team>>((ref) {
  return TeamListNotifier();
});

class TeamListNotifier extends StateNotifier<List<Team>> {
  TeamListNotifier() : super([]) {
    initialize();
    loadOnRealTime();
  }

  void initialize() {
    teamRef = FirebaseFirestore.instance.collection('teams').withConverter(
          fromFirestore: (sn, _) => Team.fromJson(sn.data()!),
          toFirestore: (team, _) => team.toJson(),
        );
  }

  late final CollectionReference<Team> teamRef;

  void loadOnRealTime() {
    teamRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data()).toList();
      state = list;
    });
  }
}
