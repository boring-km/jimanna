import 'package:jimanna/models/black_twin.dart';
import 'package:jimanna/models/name.dart';

bool hasBlackTwin(List<List<Name>> teams, List<BlackTwin> blackTwins) {
  for (final team in teams) {
    for (final blackTwin in blackTwins) {
      final names = team.map((e) => e.name).toList();
      if (names.contains(blackTwin.name_first) &&
          names.contains(blackTwin.name_second)) {
        return true;
      }
    }
  }
  return false;
}
