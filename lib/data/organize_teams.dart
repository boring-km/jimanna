// group1: abad, group2: paqad
// group1: 4명, group2: 3명 고정
import 'dart:math';

import 'package:jimanna/models/name.dart';

List<List<Name>> organizeTeams(
    List<Name> names, List<Name> abadLeaders, List<Name> paqadLeaders) {
  final totalTeams = <List<Name>>[];
  try {
    final allNames = List<Name>.from(names);
    final group1 = <Name>[];
    final group2 = <Name>[];
    for (var i = 0; i < allNames.length; i++) {
      if (allNames[i].type == 'abad') {
        group1.add(allNames[i]);
      } else {
        group2.add(allNames[i]);
      }
    }
    var abadLength = group1.length;
    var paqadLength = group2.length;

    // 4인조 조짜기를 위한 특별한 그룹
    final specialGroup = <Name>[];

    // 7명 조짜기를 하면서 특정 그룹 인원이 그 이상으로 많을 때
    // 임원을 일정하게 추가해줘야 함
    if ((abadLength / 4).ceil() > (paqadLength / 3).ceil()) {
      final left = (abadLength - (paqadLength * (4 / 3))).ceil();

      if (left % 4 != 0) {
        for (var i = 0; i < 4 - (left % 4); i++) {
          specialGroup.add(group1.removeLast());
        }
      }
      for (var i = 0; i < left; i++) {
        specialGroup.add(group1.removeLast());
      }

      for (var i = 0; i < 4 - (left % 4); i++) {
        group1.add(abadLeaders.removeLast());
      }

      abadLength = group1.length;
    } else if ((abadLength / 4).ceil() < (paqadLength / 3).ceil()) {
      final left = (((paqadLength * (4 / 3)) - abadLength) * (3 / 4)).ceil();

      if (left % 3 != 0) {
        for (var i = 0; i < 3 - (left % 3); i++) {
          specialGroup.add(group2.removeLast());
        }
      }

      for (var i = 0; i < left; i++) {
        specialGroup.add(group2.removeLast());
      }

      for (var i = 0; i < 3 - (left % 3); i++) {
        group2.add(paqadLeaders.removeLast());
      }
      specialGroup.add(abadLeaders.removeLast());

      paqadLength = group2.length;
    }

    if (abadLength % 4 != 0) {
      for (var i = 0; i < (abadLength % 4); i++) {
        group2.add(abadLeaders.removeLast());
      }
    }

    if (paqadLength % 3 != 0) {
      for (var i = 0; i < (paqadLength % 3); i++) {
        group2.add(paqadLeaders.removeLast());
      }
    }

    final team1 = makeTeamBy4(group1);
    final team2 = makeTeamBy3(group2);
    final specialTeam = makeTeamBy4(specialGroup);

    if (team1.length < team2.length) {
      for (var i = 0; i < team1.length; i++) {
        totalTeams.add(team1[i] + team2[i]);
      }
    } else if (team1.length > team2.length) {
      for (var i = 0; i < team2.length; i++) {
        totalTeams.add(team1[i] + team2[i]);
      }
    } else {
      for (var i = 0; i < team1.length; i++) {
        totalTeams.add(team1[i] + team2[i]);
      }
    }

    for (var i = 0; i < specialTeam.length; i++) {
      totalTeams.add(specialTeam[i]);
    }
  } catch (e, stacktrace) {
    print(e);
    print(stacktrace);
  }
  return totalTeams;
}

// TODO 팀원이 4명이 아닌 조는 leader를 추가해야 함
List<List<Name>> makeTeamBy4(List<Name> group1) {
  if (group1.isEmpty) return [];
  group1.shuffle(Random());
  final total = group1.length;

  final left = getLeftValue(total, 4);
  final teams = <List<Name>>[];

  for (var i = 0; i < (total ~/ 4) - (3 - left); i++) {
    final team = <Name>[];
    for (var j = 0; j < 4; j++) {
      team.add(group1.removeLast());
    }
    teams.add(team);
  }

  if (left != 3) {
    for (var i = 0; i < 4 - left; i++) {
      final team = <Name>[];
      for (var j = 0; j < 3; j++) {
        team.add(group1.removeLast());
      }
      teams.add(team);
    }
  } else {
    if (total % 4 == 3) {
      final team = <Name>[];
      for (var i = 0; i < 3; i++) {
        team.add(group1.removeLast());
      }
      teams.add(team);
    }
  }

  return teams;
}

// TODO 팀원이 3명이 아닌 조는 leader를 추가해야 함
// TODO 팀원이 3명이 아닌 조는 list의 맨 뒤로 가야함
List<List<Name>> makeTeamBy3(List<Name> group2) {
  group2.shuffle(Random());
  final total = group2.length;
  final left = getLeftValue(total, 3);
  final teams = <List<Name>>[];
  for (var i = 0; i < total ~/ 3 - (2 - left); i++) {
    final team = <Name>[];
    for (var j = 0; j < 3; j++) {
      team.add(group2.removeLast());
    }
    teams.add(team);
  }

  if (left != 2) {
    for (var i = 0; i < 3 - left; i++) {
      final team = <Name>[];
      for (var j = 0; j < 2; j++) {
        team.add(group2.removeLast());
      }
      teams.add(team);
    }
  } else {
    if (total % 3 == 2) {
      final team = <Name>[];
      for (var i = 0; i < 2; i++) {
        team.add(group2.removeLast());
      }
      teams.add(team);
    }
  }

  return teams;
}

int getLeftValue(int total, int number) {
  var left = total % number;
  if (total >= number && left == 0) left = number - 1;
  return left;
}
