import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/data/organize_teams.dart';
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


  Future<List<Name>> getTotalNames() async => (await _nameRef.get()).docs.map((e) => e.data()).toList();
}
