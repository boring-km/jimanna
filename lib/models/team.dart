
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.g.dart';

@JsonSerializable(explicitToJson: true)
class Team {
  Team(this.names);

  final List<String> names;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}