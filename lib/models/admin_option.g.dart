// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminOption _$AdminOptionFromJson(Map<String, dynamic> json) => AdminOption(
      can_register: json['can_register'] as bool,
      password: json['password'] as String,
      is_start_draw: json['is_start_draw'] as bool,
      is_draw_end: json['is_draw_end'] as bool,
      current_showed_team_number: json['current_showed_team_number'] as int,
    );

Map<String, dynamic> _$AdminOptionToJson(AdminOption instance) =>
    <String, dynamic>{
      'can_register': instance.can_register,
      'password': instance.password,
      'is_start_draw': instance.is_start_draw,
      'is_draw_end': instance.is_draw_end,
      'current_showed_team_number': instance.current_showed_team_number,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminOptionsHash() => r'66b26b80d537ee9406a5012fcf84c38e7181ed05';

/// See also [AdminOptions].
@ProviderFor(AdminOptions)
final adminOptionsProvider =
    StreamNotifierProvider<AdminOptions, QuerySnapshot<AdminOption>>.internal(
  AdminOptions.new,
  name: r'adminOptionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$adminOptionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AdminOptions = StreamNotifier<QuerySnapshot<AdminOption>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
