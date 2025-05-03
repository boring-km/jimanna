import 'dart:math';

import 'package:jimanna/models/name.dart';

void main() {
  // Example usage
  final names = [
    Name('아바드 1', type: 'abad'),
    Name('아바드 2', type: 'abad'),
    Name('아바드 3', type: 'abad'),
    Name('아바드 4', type: 'abad'),
    Name('아바드 5', type: 'abad'),
    Name('아바드 6', type: 'abad'),
    Name('아바드 7', type: 'abad'),
    Name('아바드 8', type: 'abad'),
    Name('아바드 9', type: 'abad'),
    Name('아바드 10', type: 'abad'),
    Name('아바드 11', type: 'abad'),
    Name('파카드 12', type: 'paqad'),
    Name('파카드 13', type: 'paqad'),
    Name('파카드 14', type: 'paqad'),
    Name('파카드 15', type: 'paqad'),
    Name('파카드 16', type: 'paqad'),
    Name('파카드 17', type: 'paqad'),
    Name('파카드 18', type: 'paqad'),
    Name('파카드 19', type: 'paqad'),
    Name('파카드 20', type: 'paqad'),
    Name('파카드 21', type: 'paqad'),
    Name('파카드 22', type: 'paqad'),
    Name('파카드 23', type: 'paqad'),
    Name('파카드 24', type: 'paqad'),
  ];

  final teams = organizeTeams(names);
  for (var team in teams) {
    print('Team: ${team.map((name) => name.name).join(', ')}');
  }
}

List<List<Name>> organizeTeams(List<Name> names) {
  final totalTeams = <List<Name>>[];
  try {
    final allNames = List<Name>.from(names);
    final abad = <Name>[]; // abad
    final paqad = <Name>[]; // paqad
    addAllNames(allNames, abad, paqad);
    shuffleGroups(abad, paqad);

    // 최소 4명, 최대 5명의 팀들을 모으려고 한다.
    // paqad는 2명 이상 들어가거나, 아예 안들어가게끔 팀을 구성한다.
    // 전체 인원수에서 먼저 paqad를 2명씩 모두 넣는데, paqad가 홀수이면 2명인 팀에 들어가서 paqad가 3명이 된다.

    final totalPaqad = paqad.length;
    final isPaqadOdd = totalPaqad % 2 == 1;

    // 우선 팀에 paqad만 2명씩 넣는다.
    for (var i = 0; i < totalPaqad; i += 2) {
      if (i + 1 < totalPaqad) {
        final team = <Name>[paqad[i], paqad[i + 1]];
        totalTeams.add(team);
      }
    }
    if (isPaqadOdd) {
      // 홀수일 경우, 마지막 팀에 paqad 3명 넣기
      totalTeams.last.add(paqad[totalPaqad - 1]);
    }

    // 우선 totalTeams에 abad 인원을 넣어서 최소 4명 최대 5명인 팀을 만들어본다.
    // 만약 totalTeams에 다 넣고도 abad 인원이 남는다면, abad 인원들로 최소 4명, 최대 5명인 팀을 만든다.
    for (var i = 0; i < totalTeams.length; i++) {
      if (abad.isNotEmpty) {
        final team = totalTeams[i];
        while (team.length < 5 && abad.isNotEmpty) {
          team.add(abad.removeAt(0));
        }
      }
    }
    // 남은 abad 인원들로 팀을 만든다.
    while (abad.isNotEmpty) {
      final team = <Name>[];
      while (team.length < 4 && abad.isNotEmpty) {
        team.add(abad.removeAt(0));
      }
      if (team.length < 4) {
        // 이미 완성된 5명 팀들에서 abad를 데려와 최소 4명, 최대 5명이 되도록 맞춘다.
        for (var i = 0; i < totalTeams.length; i++) {
          final completed = totalTeams[i];
          if (team.length == 4) {
            totalTeams.add(team);
            break;
          }
          if (completed.length == 5) {
            team.add(totalTeams[i].removeLast());
          }
        }
      } else {
        // 팀이 완성되면 totalTeams에 추가한다.
        totalTeams.add(team);
      }
    }

    // abad가 들어가있지 않은 팀 리스트 구하고 그 팀은 totalTeams에서 제거한다.
    final teamsWithoutAbad = <List<Name>>[];
    for (var i = 0; i < totalTeams.length; i++) {
      final team = totalTeams[i];
      if (team.where((name) => name.type == 'abad').isEmpty) {
        teamsWithoutAbad.add(team);
      }
    }
    // teamsWithoutAbad에 있는 팀들은 totalTeams에서 제거한다.
    for (var i = 0; i < teamsWithoutAbad.length; i++) {
      totalTeams.remove(teamsWithoutAbad[i]);
    }

    // teamsWithoutAbad에 있는 팀원들을 다 가져와서 리스트에 넣는다.
    final allPaqad = <Name>[];
    for (var i = 0; i < teamsWithoutAbad.length; i++) {
      allPaqad.addAll(teamsWithoutAbad[i]);
    }
    // allPaqad에서 최소 4명, 최대 5명인 팀을 만든다.
    // 만약 allPaqad에 남은 인원이 4명 미만이라면, totalTeams에 있는 5명인 팀에서 한명씩 빼와서 4명을 채운다.
    if (allPaqad.isNotEmpty) {
      if (allPaqad.length < 4) {
        for (var i = 0; i < totalTeams.length; i++) {
          final completed = totalTeams[i];
          if (completed.length == 5) {
            allPaqad.add(totalTeams[i].removeLast());
          }
          if (allPaqad.length == 4) {
            break;
          }
        }
        totalTeams.add(allPaqad);
      } else {
        // allPaqad에 남은 인원으로 팀을 만든다.
        while (allPaqad.isNotEmpty) {
          final team = <Name>[];
          while (team.length < 4 && allPaqad.isNotEmpty) {
            team.add(allPaqad.removeAt(0));
          }
          if (team.length < 4) {
            if (team.length > 1) {
              // 이미 완성된 5명 팀들에서 paqad를 데려와 최소 4명, 최대 5명이 되도록 맞춘다.
              for (var i = 0; i < totalTeams.length; i++) {
                final completed = totalTeams[i];
                if (team.length == 4) {
                  totalTeams.add(team);
                  break;
                }
                if (completed.length == 5) {
                  team.add(totalTeams[i].removeLast());
                }
              }
            } else {
              // 4명인 팀에 보내서 팀을 완성시킨다.
              for (var i = 0; i < totalTeams.length; i++) {
                final completed = totalTeams[i];
                if (completed.length == 4) {
                  completed.add(team[0]);
                  break;
                }
              }
            }
          } else {
            // 팀이 완성되면 totalTeams에 추가한다.
            totalTeams.add(team);
          }
        }
      }
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

void addAllNames(List<Name> allNames, List<Name> group1, List<Name> group2) {
  for (var i = 0; i < allNames.length; i++) {
    if (allNames[i].type == 'abad') {
      group1.add(allNames[i]);
    } else {
      group2.add(allNames[i]);
    }
  }
}
