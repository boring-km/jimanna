// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminOption _$AdminOptionFromJson(Map<String, dynamic> json) => AdminOption(
      can_register: json['can_register'] as bool,
      group_number: json['group_number'] as int,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AdminOptionToJson(AdminOption instance) =>
    <String, dynamic>{
      'can_register': instance.can_register,
      'group_number': instance.group_number,
      'password': instance.password,
    };
