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
    addAllNames(allNames, group1, group2);

    // 4인조 조짜기를 위한 특별한 그룹
    final specialGroup = <Name>[];

    if (group1.length % 4 != 0) {
      for (var i = 0; i < (group1.length % 4); i++) {
        group1.add(abadLeaders.removeLast());
      }
    }

    if (group2.length % 3 != 0) {
      for (var i = 0; i < (group2.length % 3); i++) {
        group2.add(paqadLeaders.removeLast());
      }
    }

    // 7명 조짜기를 하면서 특정 그룹 인원이 그 이상으로 많을 때
    if ((group1.length / 4).ceil() > (group2.length / 3).ceil()) {
      final left = (group1.length - (group2.length * (4 / 3))).ceil();
      for (var i = 0; i < left; i++) {
        specialGroup.add(group1.removeLast());
      }
      final specialTeam = makeTeamBy4(specialGroup);
      for (var i = 0; i < specialTeam.length; i++) {
        totalTeams.add(specialTeam[i]);
      }

    } else if ((group1.length / 4).ceil() < (group2.length / 3).ceil()) {
      final left = (((group2.length * (4 / 3)) - group1.length) * (3 / 4)).ceil();
      for (var i = 0; i < left; i++) {
        specialGroup.add(group2.removeLast());
      }
      if (left < 4) {
        for (var i = 0; i < 7 - left; i++) {
          if (abadLeaders.isNotEmpty) {
            specialGroup.add(group1.removeLast());
            group1.add(abadLeaders.removeLast());
          }
        }
        totalTeams.add(specialGroup);
      } else {
        final specialTeam = makeTeamBy3(specialGroup);
        for (var i = 0; i < specialTeam.length; i++) {
          totalTeams.add(specialTeam[i]);
        }
      }
    }

    final team1 = makeTeamBy4(group1);
    final team2 = makeTeamBy3(group2);

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

  } catch (e, stacktrace) {
    print(e);
    print(stacktrace);
  }
  return totalTeams;
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
