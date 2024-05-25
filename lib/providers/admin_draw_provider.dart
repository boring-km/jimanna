import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/data/organize_teams.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/models/team_draw.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:jimanna/providers/has_black_twin.dart';

final adminDrawProvider =
    StateNotifierProvider<AdminDrawNotifier, TeamDraw>((ref) {
  return AdminDrawNotifier();
});

class AdminDrawNotifier extends StateNotifier<TeamDraw> {
  AdminDrawNotifier() : super(TeamDraw([], [])) {
    loadOnRealTime();
  }

  final _nameRef = FireStoreFactory.namesByCurrentYearMonthRef();
  final _teamRef = FireStoreFactory.teamRef();
  final _blackTwinRef = FireStoreFactory.blackTwinRef();
  final _leadersRef = FireStoreFactory.leadersRef();

  void loadOnRealTime() {
    _teamRef.snapshots().listen((teamEvent) {
      final teams = teamEvent.docs.map((e) => e.data()).toList();
      _blackTwinRef.get().then((blackEvent) {
        state = TeamDraw(teams, blackEvent.docs.map((e) => e.data()).toList());
      });
    });
  }

  void resetTeams() {
    _teamRef.get().then((value) {
      for (final doc in value.docs) {
        _teamRef.doc(doc.id).delete();
      }
      state = TeamDraw([], []);
    });
  }

  Future<void> makeTeams() async {
    final totalNames = await getTotalNames();
    final leaders = (await _leadersRef.get()).docs.map((e) => e.data()).toList()
      ..shuffle();
    final abadLeaders =
        leaders.where((element) => element.type == 'abad').toList()..shuffle();
    final paqadLeaders =
        leaders.where((element) => element.type == 'paqad').toList()..shuffle();

    final teams = organizeTeams(totalNames, abadLeaders, paqadLeaders);

    if (hasBlackTwin(teams, state.blackTwins)) {
      unawaited(makeTeams());
    } else {
      uploadAllTeams(teams);
    }
  }

  void uploadAllTeams(List<List<Name>> teams) {
    for (final team in teams) {
      unawaited(_teamRef.add(Team(team)));
    }
  }

  Future<List<Name>> getTotalNames() async =>
      (await _nameRef.get()).docs.map((e) => e.data()).toList();
}
