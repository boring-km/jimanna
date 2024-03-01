import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/models/team_draw.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';

final adminDrawProvider =
    StateNotifierProvider<AdminDrawNotifier, TeamDraw>((ref) {
  return AdminDrawNotifier();
});

class AdminDrawNotifier extends StateNotifier<TeamDraw> {
  AdminDrawNotifier() : super(TeamDraw([], [])) {
    loadOnRealTime();
  }

  void loadOnRealTime() {
    _teamRef.snapshots().listen((teamEvent) {
      final teams = teamEvent.docs.map((e) => e.data()).toList();
      _blackTwinRef.get().then((blackEvent) {
        state = TeamDraw(teams, blackEvent.docs.map((e) => e.data()).toList());
      });
    });
  }

  final _nameRef = FireStoreFactory.namesByCurrentYearMonthRef();
  final _teamRef = FireStoreFactory.teamRef();
  final _blackTwinRef = FireStoreFactory.blackTwinRef();

  // 4명씩 랜덤으로 조를 짜는데 4명이 안되는 경우는 3명으로 조를 짜도록 함
  List<List<String>> organizeGroupsOfFourOrThree(List<String> names) {
    final teams = <List<String>>[];
    final shuffledNames = List<String>.from(names)..shuffle(Random());
    addShuffledNamesToTeams(shuffledNames, teams);
    if (hasBlackTwin(teams)) {
      return organizeGroupsOfFourOrThree(names);
    }
    return teams;
  }

  void addShuffledNamesToTeams(
    List<String> shuffledNames,
    List<List<String>> teams,
  ) {
    if (shuffledNames.isEmpty) return;
    final teamSize = chooseTeamSize(shuffledNames);
    teams.add(shuffledNames.sublist(0, teamSize));
    addShuffledNamesToTeams(shuffledNames.sublist(teamSize), teams);
  }

  int chooseTeamSize(List<String> shuffledNames) {
    return (shuffledNames.length % 3 == 0 && shuffledNames.length <= 9) ? 3 : 4;
  }

  void resetTeams() {
    _teamRef.get().then((value) {
      for (final doc in value.docs) {
        _teamRef.doc(doc.id).delete();
      }
      state = TeamDraw([], []);
    });
  }

  void makeTeams() {
    _nameRef.get().then((value) {
      final names = value.docs.map((e) => e.data().name).toList();
      final teams = organizeGroupsOfFourOrThree(names);
      for (final team in teams) {
        _teamRef.add(Team(team));
      }
    });
  }

  bool hasBlackTwin(List<List<String>> teams) {
    for (final team in teams) {
      for (final blackTwin in state.blackTwins) {
        if (team.contains(blackTwin.name_first) &&
            team.contains(blackTwin.name_second)) {
          return true;
        }
      }
    }
    return false;
  }
}
