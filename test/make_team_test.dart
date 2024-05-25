import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:jimanna/data/organize_teams.dart';
import 'package:jimanna/models/name.dart';

void main() {

  test('리스트 add 확인', () {

    final array = [1,2] + [3,4];
    expect(array, [1,2,3,4]);
  });

  test('makeTeamBy4 test', () {
    final group1 = <Name>[
      Name('테스트1', type: 'abad'),
      Name('테스트2', type: 'abad'),
      Name('테스트3', type: 'abad'),
      Name('테스트4', type: 'abad'),
      Name('테스트5', type: 'abad'),
      Name('테스트6', type: 'abad'),
      Name('테스트7', type: 'abad'),
      Name('테스트8', type: 'abad'),
      Name('테스트9', type: 'abad'),
      Name('테스트10', type: 'abad'),
      Name('테스트11', type: 'abad'),
    ];

    final team = makeTeamBy4(group1);
    for (var i = 0; i < team.length; i++) {
      stdout.write('조 ${i + 1}: ');
      for (var j = 0; j < team[i].length; j++) {
        stdout.write('${team[i][j].name}, ');
      }
      stdout.write('\n');
    }
  });

  test('makeTeamBy3 test', () {
    final group2 = <Name>[
      Name('테스트1', type: 'paqad'),
      Name('테스트2', type: 'paqad'),
      Name('테스트3', type: 'paqad'),
      Name('테스트4', type: 'paqad'),
      Name('테스트5', type: 'paqad'),
      Name('테스트6', type: 'paqad'),
      Name('테스트7', type: 'paqad'),
      Name('테스트8', type: 'paqad'),
      Name('테스트9', type: 'paqad'),
      Name('테스트10', type: 'paqad'),
      Name('테스트11', type: 'paqad'),
    ];

    final team = makeTeamBy3(group2);
    for (var i = 0; i < team.length; i++) {
      stdout.write('조 ${i + 1}: ');
      for (var j = 0; j < team[i].length; j++) {
        stdout.write('${team[i][j].name}, ');
      }
      stdout.write('\n');
    }
  });
}