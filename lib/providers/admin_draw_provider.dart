import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  void organizeTeams(List<String> namesWithoutLeaders) {
    final tempNames = List<String>.from(namesWithoutLeaders)
      ..shuffle(Random());

    final total = namesWithoutLeaders.length;
    final left = getLeftValue(total);
    final teams = <List<String>>[];

    try {
      // 21, 몫: 5, 나머지: 1, 4 + 4 + 4 + 3 + 3 + 3
      // 22, 몫: 5, 나머지: 2, 4 + 4 + 4 + 4 + 3 + 3
      // 23, 몫: 5, 나머지: 3, 4 + 4 + 4 + 4 + 4 + 3
      // 24, 몫: 6, 나머지: 0, 4 + 4 + 4 + 4 + 4 + 4
      for (var i = 0; i < (total ~/ 4) - (3 - left); i++) {
        final team = <String>[];
        for (var j = 0; j < 4; j++) {
          team.add(tempNames.removeLast());
        }
        teams.add(team);
      }

      if (left != 3) {
        for (var i = 0; i < 4 - left; i++) {
          final team = <String>[];
          for (var j = 0; j < 3; j++) {
            team.add(tempNames.removeLast());
          }
          teams.add(team);
        }
      } else {
        if (total % 4 == 3) {
          final team = <String>[];
          for (var i = 0; i < 3; i++) {
            team.add(tempNames.removeLast());
          }
          teams.add(team);
        }
      }
    } catch (_) {}

    if (hasBlackTwin(teams, state.blackTwins)) {
      organizeTeams(namesWithoutLeaders);
    } else {
      uploadAllTeams(teams);
    }
  }

  int getLeftValue(int total) {
    var left = total % 4;
    if (total >= 4 && left == 0) left = 3;
    return left;
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
    organizeTeams(totalNames);
  }

  void uploadAllTeams(List<List<String>> teams) {
    for (final team in teams) {
      unawaited(_teamRef.add(Team(team)));
    }
  }

  Future<List<String>> getTotalNames() async =>
      (await _nameRef.get()).docs.map((e) => e.data().name).toList();

}
