import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/admin_option.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/models/team_draw.dart';
import 'package:jimanna/utils/date_utils.dart';

final adminDrawProvider =
    StateNotifierProvider<AdminDrawNotifier, TeamDraw>((ref) {
  return AdminDrawNotifier();
});

class AdminDrawNotifier extends StateNotifier<TeamDraw> {
  AdminDrawNotifier() : super(TeamDraw([], 0)) {
    final yearMonth = getYearMonthOnly();
    nameRef = FirebaseFirestore.instance
        .collection(yearMonth)
        .withConverter(
        fromFirestore: (sn, _) => Name.fromJson(sn.data()!),
        toFirestore: (name, _) => name.toJson());

    teamRef = FirebaseFirestore.instance.collection('teams').withConverter(
          fromFirestore: (sn, _) => Team.fromJson(sn.data()!),
          toFirestore: (team, _) => team.toJson(),
        );

    adminOptionRef =
        FirebaseFirestore.instance.collection('current').withConverter(
              fromFirestore: (sn, _) => AdminOption.fromJson(sn.data()!),
              toFirestore: (adminOption, _) => adminOption.toJson(),
            );
    loadOnRealTime();
  }

  late final CollectionReference<Name> nameRef;
  late final CollectionReference<Team> teamRef;
  late final CollectionReference<AdminOption> adminOptionRef;

  void loadOnRealTime() {
    nameRef.snapshots().listen((event) {
      final list = event.docs.map((e) => e.data().name).toList();
      state = TeamDraw(organizeGroupsOfFourOrThree(list), 0);
    });
  }

  int groupNumber = 0;

  void resetGroupNumber() {
    groupNumber = 0;
    adminOptionRef.get().then((value) {
      adminOptionRef.doc(value.docs.first.id).update(
        {'group_number': groupNumber},
      );
    });
  }

  bool addTeam() {
    if (groupNumber + 1 > state.teams.length) return true;
    final team = Team(state.teams[groupNumber]);
    teamRef.add(team);
    groupNumber++;
    adminOptionRef.get().then((value) {
      adminOptionRef.doc(value.docs.first.id).update(
        {'group_number': groupNumber},
      );
    });
    state = TeamDraw(state.teams, groupNumber);
    return false;
  }

  // 4명씩 랜덤으로 조를 짜는데 4명이 안되는 경우는 3명으로 조를 짜도록 함
  List<List<String>> organizeGroupsOfFourOrThree(List<String> names) {
    var shuffledNames = List<String>.from(names)..shuffle();
    final teams = <List<String>>[];

    while (shuffledNames.isNotEmpty) {
      final teamSize =
          (shuffledNames.length % 3 == 0 && shuffledNames.length <= 9) ? 3 : 4;
      teams.add(shuffledNames.sublist(0, teamSize));
      shuffledNames = shuffledNames.sublist(teamSize);
    }

    return teams;
  }

  void resetTeams() {
    resetGroupNumber();
    teamRef.get().then((value) {
      for (final doc in value.docs) {
        teamRef.doc(doc.id).delete();
      }
    });
  }
}
