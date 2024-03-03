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

  final _specialRef = FireStoreFactory.specialNamesRef();
  final _leaderRef = FireStoreFactory.leadersRef();
  final _nameRef = FireStoreFactory.namesByCurrentYearMonthRef();
  final _teamRef = FireStoreFactory.teamRef();
  final _blackTwinRef = FireStoreFactory.blackTwinRef();

  // 4명씩 랜덤으로 조를 짜는데 4명이 안되는 경우는 3명으로 조를 짜도록 함
  void organizeTeams(
    List<String> leaders,
    List<String> namesWithoutLeaders,
    String specialName,
  ) {
    final tempLeaders = List<String>.from(leaders)..shuffle(Random());
    final tempNamesWithoutLeaders = List<String>.from(namesWithoutLeaders)
      ..shuffle(Random());

    final total = leaders.length + namesWithoutLeaders.length;
    final left = total % 4;
    final teams = <List<String>>[];
    final threeTeamIndexes = <int>[];
    tempLeaders
      ..remove(specialName)
      ..add(specialName);

    try {
      for (var i = 0; i < (total ~/ 4) - (4 - left) + 1; i++) {
        final leader = tempLeaders.removeLast();
        final team = [leader];
        var hasTwoLeader = false;
        if (leader == specialName) {
          team.add(tempLeaders.removeLast());
          hasTwoLeader = true;
        }

        if (tempNamesWithoutLeaders.length < 3) {
          for (var j = 0; j < tempNamesWithoutLeaders.length; j++) {
            team.add(tempNamesWithoutLeaders.removeLast());
          }
          if (!hasTwoLeader) {
            team.add(tempLeaders.removeLast());
          }
        } else {
          var count = 3;
          if (hasTwoLeader) count = 2;
          for (var j = 0; j < count; j++) {
            team.add(tempNamesWithoutLeaders.removeLast());
          }
        }
        if (team.length == 3) threeTeamIndexes.add(teams.length);
        teams.add(team);
      }

      for (var i = 0; i < 4 - left; i++) {
        final leader = tempLeaders.removeLast();
        final team = [leader];
        final c = tempNamesWithoutLeaders.length;
        if (c < 2) {
          for (var j = 0; j < c; j++) {
            team.add(tempNamesWithoutLeaders.removeLast());
          }
          for (var j = 0; j < 2 - c; j++) {
            team.add(tempLeaders.removeLast());
          }
        } else {
          for (var j = 0; j < 2; j++) {
            team.add(tempNamesWithoutLeaders.removeLast());
          }
        }
        if (team.length == 3) threeTeamIndexes.add(teams.length);
        teams.add(team);
      }

      if (tempLeaders.isNotEmpty) {
        // 리더가 너무 많아 여유가 생긴 경우

        // 팀 리더가 모두 3명 팀으로 들어갈 수 있는 경우
        if (tempLeaders.length <= threeTeamIndexes.length) {
          final c = tempLeaders.length;
          for (var i = 0; i < c; i++) {
            teams[threeTeamIndexes[i]].add(tempLeaders.removeLast());
          }
        } else {
          // 팀 리더가 모두 3명 팀으로 들어갈 수 없는 경우
          final extra = tempLeaders.length - threeTeamIndexes.length;
          for (var i = 0; i < threeTeamIndexes.length; i++) {
            teams[threeTeamIndexes[i]].add(tempLeaders.removeLast());
          }
          if (2 < extra && extra < 5) {
            final team = <String>[];
            final c = tempLeaders.length;
            for (var i = 0; i < c; i++) {
              team.add(tempLeaders.removeLast());
            }
            teams.add(team);
          }
        }
      }
    } catch (e) {
      print(e);
    }

    if (hasBlackTwin(teams, state.blackTwins)) {
      organizeTeams(leaders, namesWithoutLeaders, specialName);
    } else {
      uploadAllTeams(teams);
    }
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
    final names = await getTotalNames();
    final attendedLeaders = await getAttendedLeaders(names);
    final specialName = await getSpecialOne();

    organizeTeams(attendedLeaders, names, specialName);
  }

  void uploadAllTeams(List<List<String>> teams) {
    for (final team in teams) {
      unawaited(_teamRef.add(Team(team)));
    }
  }

  Future<List<String>> getAttendedLeaders(List<String> names) async {
    final leaders = await getTotalLeaders();
    final attendedLeaders = <String>[];
    for (final leader in leaders) {
      if (names.remove(leader)) {
        attendedLeaders.add(leader);
      }
    }
    return attendedLeaders;
  }

  Future<String> getSpecialOne() async =>
      (await _specialRef.get()).docs.map((e) => e.data().name).toList()[0];

  Future<List<String>> getTotalNames() async =>
      (await _nameRef.get()).docs.map((e) => e.data().name).toList();

  Future<List<String>> getTotalLeaders() async =>
      (await _leaderRef.get()).docs.map((e) => e.data().name).toList();
}
