import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.g.dart';

@JsonSerializable(explicitToJson: true)
class Team {
  Team(this.names);

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  final List<String> names;

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
