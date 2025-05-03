import 'package:flutter_test/flutter_test.dart';
import 'package:jimanna/data/organize_teams.dart';
import 'package:jimanna/models/name.dart';

void main() {
  test('organize_teams 11, 6 test', () {
    // abad 11명, paqad 7명
    final names = [
      Name('1', type: 'abad'),
      Name('2', type: 'abad'),
      Name('3', type: 'abad'),
      Name('4', type: 'abad'),
      Name('5', type: 'abad'),
      Name('6', type: 'abad'),
      Name('7', type: 'abad'),
      Name('8', type: 'abad'),
      Name('9', type: 'abad'),
      Name('10', type: 'abad'),
      Name('11', type: 'abad'),
      Name('12', type: 'paqad'),
      Name('13', type: 'paqad'),
      Name('14', type: 'paqad'),
      Name('15', type: 'paqad'),
      Name('16', type: 'paqad'),
      Name('17', type: 'paqad'),
    ];

    // Act
    final teams = organizeTeams(names);

    // 각 팀에 paqad가 2명 이상 있거나, 없으면 성공
    for (final team in teams) {
      final paqadCount = team.where((name) => name.type == 'paqad').length;
      expect(paqadCount >= 2 || paqadCount == 0, isTrue);
      // 각 팀에 4명 이상 5명 이하인지 확인
      expect(team.length >= 4 && team.length <= 5, isTrue);
    }
  });

  test('organize_teams 11, 7 test', () {
    // abad 11명, paqad 8명
    final names = [
      Name('1', type: 'abad'),
      Name('2', type: 'abad'),
      Name('3', type: 'abad'),
      Name('4', type: 'abad'),
      Name('5', type: 'abad'),
      Name('6', type: 'abad'),
      Name('7', type: 'abad'),
      Name('8', type: 'abad'),
      Name('9', type: 'abad'),
      Name('10', type: 'abad'),
      Name('11', type: 'abad'),
      Name('12', type: 'paqad'),
      Name('13', type: 'paqad'),
      Name('14', type: 'paqad'),
      Name('15', type: 'paqad'),
      Name('16', type: 'paqad'),
      Name('17', type: 'paqad'),
      Name('18', type: 'paqad'),
    ];

    // Act
    final teams = organizeTeams(names);

    // 각 팀에 paqad가 2명 이상 있거나, 없으면 성공
    for (final team in teams) {
      final paqadCount = team.where((name) => name.type == 'paqad').length;
      expect(paqadCount >= 2 || paqadCount == 0, isTrue);
      // 각 팀에 4명 이상 5명 이하인지 확인
      expect(team.length >= 4 && team.length <= 5, isTrue);
    }
  });

  test('organize_teams 11, 8 test', () {
    // abad 11명, paqad 9명
    final names = [
      Name('1', type: 'abad'),
      Name('2', type: 'abad'),
      Name('3', type: 'abad'),
      Name('4', type: 'abad'),
      Name('5', type: 'abad'),
      Name('6', type: 'abad'),
      Name('7', type: 'abad'),
      Name('8', type: 'abad'),
      Name('9', type: 'abad'),
      Name('10', type: 'abad'),
      Name('11', type: 'abad'),
      Name('12', type: 'paqad'),
      Name('13', type: 'paqad'),
      Name('14', type: 'paqad'),
      Name('15', type: 'paqad'),
      Name('16', type: 'paqad'),
      Name('17', type: 'paqad'),
      Name('18', type: 'paqad'),
      Name('19', type: 'paqad'),
    ];

    // Act
    final teams = organizeTeams(names);

    // 각 팀에 paqad가 2명 이상 있거나, 없으면 성공
    for (final team in teams) {
      final paqadCount = team.where((name) => name.type == 'paqad').length;
      expect(paqadCount >= 2 || paqadCount == 0, isTrue);
      // 각 팀에 4명 이상 5명 이하인지 확인
      expect(team.length >= 4 && team.length <= 5, isTrue);
    }
  });

  test('organize_teams 11, 9 test', () {
    // abad 12명, paqad 10명
    final names = [
      Name('1', type: 'abad'),
      Name('2', type: 'abad'),
      Name('3', type: 'abad'),
      Name('4', type: 'abad'),
      Name('5', type: 'abad'),
      Name('6', type: 'abad'),
      Name('7', type: 'abad'),
      Name('8', type: 'abad'),
      Name('9', type: 'abad'),
      Name('10', type: 'abad'),
      Name('11', type: 'abad'),
      Name('12', type: 'paqad'),
      Name('13', type: 'paqad'),
      Name('14', type: 'paqad'),
      Name('15', type: 'paqad'),
      Name('16', type: 'paqad'),
      Name('17', type: 'paqad'),
      Name('18', type: 'paqad'),
      Name('19', type: 'paqad'),
      Name('20', type: 'paqad'),
    ];

    // Act
    final teams = organizeTeams(names);

    // 각 팀에 paqad가 2명 이상 있거나, 없으면 성공
    for (final team in teams) {
      final paqadCount = team.where((name) => name.type == 'paqad').length;
      expect(paqadCount >= 2 || paqadCount == 0, isTrue);
      // 각 팀에 4명 이상 5명 이하인지 확인
      expect(team.length >= 4 && team.length <= 5, isTrue);
    }
  });

  test('organize_teams many paqad test', () {

    final names = [
      Name('1', type: 'abad'),
      Name('2', type: 'abad'),
      Name('3', type: 'abad'),
      Name('4', type: 'abad'),
      Name('5', type: 'abad'),
      Name('6', type: 'abad'),
      Name('7', type: 'abad'),
      Name('8', type: 'abad'),
      Name('9', type: 'abad'),
      Name('10', type: 'abad'),
      Name('11', type: 'abad'),
      Name('12', type: 'paqad'),
      Name('13', type: 'paqad'),
      Name('14', type: 'paqad'),
      Name('15', type: 'paqad'),
      Name('16', type: 'paqad'),
      Name('17', type: 'paqad'),
      Name('18', type: 'paqad'),
      Name('19', type: 'paqad'),
      Name('20', type: 'paqad'),
      Name('21', type: 'paqad'),
      Name('22', type: 'paqad'),
      Name('23', type: 'paqad'),
      Name('24', type: 'paqad'),
      Name('25', type: 'paqad'),
      Name('26', type: 'paqad'),
      Name('27', type: 'paqad'),
      Name('28', type: 'paqad'),
    ];

    // Act
    final teams = organizeTeams(names);

    // 각 팀에 paqad가 2명 이상 있거나, 없으면 성공
    for (final team in teams) {
      final paqadCount = team.where((name) => name.type == 'paqad').length;
      expect(paqadCount >= 2 || paqadCount == 0, isTrue);
      // 각 팀에 4명 이상 5명 이하인지 확인
      expect(team.length >= 4 && team.length <= 5, isTrue);
    }
  });

  test('organize_teams many abad test', () {

    final names = [
      Name('1', type: 'abad'),
      Name('2', type: 'abad'),
      Name('3', type: 'abad'),
      Name('4', type: 'abad'),
      Name('5', type: 'abad'),
      Name('6', type: 'abad'),
      Name('7', type: 'abad'),
      Name('8', type: 'abad'),
      Name('9', type: 'abad'),
      Name('10', type: 'abad'),
      Name('11', type: 'abad'),
      Name('12', type: 'abad'),
      Name('13', type: 'abad'),
      Name('14', type: 'abad'),
      Name('15', type: 'abad'),
      Name('16', type: 'abad'),
      Name('17', type: 'abad'),
      Name('18', type: 'abad'),
      Name('12', type: 'paqad'),
      Name('13', type: 'paqad'),
      Name('14', type: 'paqad'),
      Name('15', type: 'paqad'),
    ];

    // Act
    final teams = organizeTeams(names);

    // 각 팀에 paqad가 2명 이상 있거나, 없으면 성공
    for (final team in teams) {
      final paqadCount = team.where((name) => name.type == 'paqad').length;
      expect(paqadCount >= 2 || paqadCount == 0, isTrue);
      // 각 팀에 4명 이상 5명 이하인지 확인
      expect(team.length >= 4 && team.length <= 5, isTrue);
    }
  });
}
