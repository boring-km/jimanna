import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/black_twin.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/team.dart';
import 'package:jimanna/models/team_draw.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:jimanna/providers/has_black_twin.dart';

final adminDrawProvider = StateNotifierProvider<AdminDrawNotifier, TeamDraw>((ref) {
  return AdminDrawNotifier();
});

class AdminDrawNotifier extends StateNotifier<TeamDraw> {
  AdminDrawNotifier() : super(TeamDraw([])) {
    loadOnRealTime();
  }

  void loadOnRealTime() {
    _teamRef.snapshots().listen((teamEvent) {
      final teams = teamEvent.docs.map((e) => e.data()).toList()
      // 길이가 짧은 team들을 꺼내서 맨 뒤로 보내기
        ..sort((a, b) => -a.names.length.compareTo(b.names.length));
      state = TeamDraw(teams);
    });
    _blackTwinRef.get().then((value) {
      _blackTwins.clear();
      for (final doc in value.docs) {
        _blackTwins.add(doc.data());
      }
    });
  }

  final _nameRef = FireStoreFactory.namesByCurrentYearMonthRef();
  final _teamRef = FireStoreFactory.teamRef();
  final _blackTwinRef = FireStoreFactory.blackTwinRef();
  final _blackTwins = <BlackTwin>[];

  List<List<Name>> organizeTeams(List<Name> names) {
    final totalTeams = <List<Name>>[];
    try {
      final allNames = List<Name>.from(names);
      final group1 = <Name>[]; // abad 타입
      final group2 = <Name>[]; // non-abad 타입
      addAllNames(allNames, group1, group2);
      shuffleGroups(group1, group2);

      // 팀당 최소 3명, 최대 4명, group2에서 1명 이상 포함
      final totalPeople = allNames.length;
      final numTeams = (totalPeople / 4).ceil(); // 최대 4명 기준으로 팀 수 계산
      final teams = List.generate(numTeams, (_) => <Name>[]);

      // group2 인원을 먼저 팀에 분배 (각 팀에 최소 1명 보장)
      int group2Index = 0;
      for (var i = 0; i < numTeams && group2Index < group2.length; i++) {
        teams[i].add(group2[group2Index]);
        group2Index++;
      }

      // group2 나머지 인원 분배
      for (var i = 0; group2Index < group2.length; i = (i + 1) % numTeams) {
        if (teams[i].length < 4) { // 팀 크기 4명 이하로 유지
          teams[i].add(group2[group2Index]);
          group2Index++;
        }
      }

      // group1 인원 분배
      int group1Index = 0;
      for (var i = 0; group1Index < group1.length; i = (i + 1) % numTeams) {
        if (teams[i].length < 4) { // 팀 크기 4명 이하로 유지
          teams[i].add(group1[group1Index]);
          group1Index++;
        }
      }

      // 최소 3명 조건 확인 및 팀 정리
      for (final team in teams) {
        if (team.length >= 3) {
          totalTeams.add(team);
        }
      }

      // 팀이 비어있거나 조건을 만족하지 않으면 빈 리스트 반환
      if (totalTeams.isEmpty || totalTeams.any((team) => team.length < 3 || !team.any((name) => name.type != 'abad'))) {
        return [];
      }

    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return totalTeams;
  }

  void shuffleGroups(List<Name> group1, List<Name> group2) {
    group1.shuffle(Random());
    group2.shuffle(Random());
  }


  void resetTeams() {
    _teamRef.get().then((value) {
      for (final doc in value.docs) {
        _teamRef.doc(doc.id).delete();
      }
      state = TeamDraw([]);
    });
  }

  Future<void> makeTeams() async {
    final totalNames = await getTotalNames();

    final teams = organizeTeams(totalNames);

    if (hasBlackTwin(teams, _blackTwins)) {
      print('has black twin');
      unawaited(makeTeams());
    } else {
      print('no black twin');
      uploadAllTeams(teams);
    }
  }

  void uploadAllTeams(List<List<Name>> teams) {
    for (final team in teams) {
      unawaited(_teamRef.add(Team(team)));
    }
  }

  void addAllNames(List<Name> allNames, List<Name> group1, List<Name> group2) {
    for (var i = 0; i < allNames.length; i++) {
      if (allNames[i].type == 'abad') {
        group1.add(allNames[i]);
      } else {
        group2.add(allNames[i]);
      }
    }
  }


  Future<List<Name>> getTotalNames() async => (await _nameRef.get()).docs.map((e) => e.data()).toList();
}
