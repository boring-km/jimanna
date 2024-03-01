import 'package:jimanna/models/black_twin.dart';
import 'package:jimanna/models/team.dart';

class TeamDraw {
  TeamDraw(this.teams, this.blackTwins);

  final List<Team> teams;
  final List<BlackTwin> blackTwins;
}
