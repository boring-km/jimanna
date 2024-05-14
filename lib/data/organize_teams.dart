// group1: abad, group2: paqad
// group1: 4명, group2: 3명 고정
import 'dart:math';

import 'package:jimanna/models/name.dart';

List<List<Name>> organizeTeams(List<Name> names) {
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

  final totalTeams = <List<Name>>[];

  final team1 = makeTeamBy4(group1);
  final team2 = makeTeamBy3(group2);


  if (team2.length < team1.length) {
    for (var i = 0; i < team2.length; i++) {
      totalTeams.add(team1[i] + team2[i]);
    }
  } else {
    for (var i = 0; i < team1.length; i++) {
      totalTeams.add(team1[i] + team2[i]);
    }
  }

  return totalTeams;
}



// TODO 팀원이 4명이 아닌 조는 leader를 추가해야 함
List<List<Name>> makeTeamBy4(List<Name> group1) {
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