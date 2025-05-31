import 'package:flutter/cupertino.dart';

void main() {
  // 여기에 50명의 이름을 추가하세요.
  final names = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    'AA',
    'BB',
    'CC',
    'DD',
    'EE',
    'FF',
    'GG',
    'HH',
    'II',
    'JJ',
    'KK',
    'LL',
    'MM',
    'NN',
    'OO',
    'PP',
    'QQ',
    'RR',
    'SS',
    'TT',
    'UU',
    'VV',
    'WW',
    'XX',
    // 'YY',
    // 'ZZ',
  ];


  final teams = organizeGroupsOfFourOrThree(names);

  // 조 출력
  for (var i = 0; i < teams.length; i++) {
    debugPrint('조 ${i + 1}: ${teams[i]}');
  }
}

// 4명씩 랜덤으로 조를 짜는데 4명이 안되는 경우는 3명으로 조를 짜도록 함
List<List<String>> organizeGroupsOfFourOrThree(List<String> names) {
  var shuffledNames = List<String>.from(names)..shuffle();
  final teams = <List<String>>[];

  while (shuffledNames.isNotEmpty) {
    final teamSize = (shuffledNames.length % 3 == 0 && shuffledNames.length <= 9) ? 3 : 4;
    teams.add(shuffledNames.sublist(0, teamSize));
    shuffledNames = shuffledNames.sublist(teamSize);
  }

  return teams;
}
