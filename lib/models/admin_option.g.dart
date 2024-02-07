// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminOption _$AdminOptionFromJson(Map<String, dynamic> json) => AdminOption(
      can_register: json['can_register'] as bool,
      group_number: json['group_number'] as int,
      password: json['password'] as String,
      is_start_draw: json['is_start_draw'] as bool,
    );

Map<String, dynamic> _$AdminOptionToJson(AdminOption instance) =>
    <String, dynamic>{
      'can_register': instance.can_register,
      'group_number': instance.group_number,
      'password': instance.password,
      'is_start_draw': instance.is_start_draw,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminOptionsHash() => r'4ecfc11b1152da93d846f64e177723814f671c49';

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
