import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/admin_option.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/models/team_draw.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:jimanna/utils/date_utils.dart';

final adminDrawProvider =
    StateNotifierProvider<AdminDrawNotifier, TeamDraw>((ref) {
  return AdminDrawNotifier();
});

class AdminDrawNotifier extends StateNotifier<TeamDraw> {
  AdminDrawNotifier() : super(TeamDraw([], 0)) {
    loadOnRealTime();
  }

  final _nameRef = FireStoreFactory.namesByCurrentYearMonthRef;
  final _teamRef = FireStoreFactory.teamRef;
  final _adminOptionRef = FireStoreFactory.adminOptionRef;

  void loadOnRealTime() {
    listenNames();
    listenTeamDraw();
  }

  void listenNames() {
    _nameRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data().name).toList();
      state = TeamDraw(organizeGroupsOfFourOrThree(list), 0);
    });
  }

  void listenTeamDraw() {
    _adminOptionRef.snapshots().listen((event) {
      groupNumber = event.docs.first.data().group_number;
      state = TeamDraw(state.teams, groupNumber);
    });
  }

  int groupNumber = 0;

  void resetGroupNumber() {
    groupNumber = 0;
    updateGroupNumberFromAdminOptionRef();
  }

  bool addTeam() {
    if (groupNumber + 1 > state.teams.length) return true;
    _teamRef.add(Team(state.teams[groupNumber]));
    groupNumber++;
    updateGroupNumberFromAdminOptionRef();
    return false;
  }

  void updateGroupNumberFromAdminOptionRef() {
    _adminOptionRef.get().then((value) {
      _adminOptionRef.doc(value.docs.first.id).update(
        {'group_number': groupNumber},
      );
    });
  }

  // 4명씩 랜덤으로 조를 짜는데 4명이 안되는 경우는 3명으로 조를 짜도록 함
  List<List<String>> organizeGroupsOfFourOrThree(List<String> names) {
    final teams = <List<String>>[];
    final shuffledNames = List<String>.from(names)..shuffle();
    addShuffledNamesToTeams(shuffledNames, teams);
    return teams;
  }

  void addShuffledNamesToTeams(List<String> shuffledNames, List<List<String>> teams) {
    if (shuffledNames.isEmpty) return;
    final teamSize = chooseTeamSize(shuffledNames);
    teams.add(shuffledNames.sublist(0, teamSize));
    addShuffledNamesToTeams(shuffledNames.sublist(teamSize), teams);
  }

  int chooseTeamSize(List<String> shuffledNames) {
    return (shuffledNames.length % 3 == 0 && shuffledNames.length <= 9) ? 3 : 4;
  }

  void resetTeams() {
    resetGroupNumber();
    _teamRef.get().then((value) {
      for (final doc in value.docs) {
        _teamRef.doc(doc.id).delete();
      }
    });
  }
}
