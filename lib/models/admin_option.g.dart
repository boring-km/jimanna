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
    );

Map<String, dynamic> _$AdminOptionToJson(AdminOption instance) =>
    <String, dynamic>{
      'can_register': instance.can_register,
      'password': instance.password,
      'is_start_draw': instance.is_start_draw,
      'is_draw_end': instance.is_draw_end,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminOptionsHash() => r'a55e9fb7a24c9e33adb17a5d0ea8ec0035899159';

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
