import 'package:freezed_annotation/freezed_annotation.dart';

part 'black_twin.g.dart';

@JsonSerializable()
class BlackTwin {

  BlackTwin({required this.name_first, required this.name_second});

  factory BlackTwin.fromJson(Map<String, dynamic> json) =>
      _$BlackTwinFromJson(json);
  final String name_first;
  final String name_second;

  Map<String, dynamic> toJson() => _$BlackTwinToJson(this);
}
