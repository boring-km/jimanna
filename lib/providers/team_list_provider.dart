import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final teamListProvider =
    StateNotifierProvider<TeamListNotifier, List<Team>>((ref) {
  return TeamListNotifier();
});

class TeamListNotifier extends StateNotifier<List<Team>> {
  TeamListNotifier() : super([]) {
    loadOnRealTime();
  }

  final CollectionReference<Team> teamRef = FireStoreFactory.teamRef;

  void loadOnRealTime() {
    teamRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data()).toList();
      state = list;
    });
  }
}
