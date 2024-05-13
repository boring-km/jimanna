import 'package:jimanna/models/black_twin.dart';

bool hasBlackTwin(List<List<String>> teams, List<BlackTwin> blackTwins) {
  for (final team in teams) {
    for (final blackTwin in blackTwins) {
      if (team.contains(blackTwin.name_first) &&
          team.contains(blackTwin.name_second)) {
        return true;
      }
    }
  }
  return false;
}
