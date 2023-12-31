import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_option.g.dart';

@JsonSerializable()
class AdminOption {
  AdminOption({
    required this.can_register,
    required this.group_number,
    required this.password,
  });

  factory AdminOption.fromJson(Map<String, dynamic> json) =>
      _$AdminOptionFromJson(json);
  final bool can_register;
  final int group_number;
  final String password;

  Map<String, dynamic> toJson() => _$AdminOptionToJson(this);
}
