import 'package:freezed_annotation/freezed_annotation.dart';

part 'name.g.dart';

@JsonSerializable()
class Name {
  final String name;
  final String? type;

  Name(this.name, {this.type});

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
  Map<String, dynamic> toJson() => _$NameToJson(this);
}
