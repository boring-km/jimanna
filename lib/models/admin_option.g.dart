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
  current_showed_team_number: (json['current_showed_team_number'] as num)
      .toInt(),
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminOptions)
final adminOptionsProvider = AdminOptionsProvider._();

final class AdminOptionsProvider
    extends $StreamNotifierProvider<AdminOptions, QuerySnapshot<AdminOption>> {
  AdminOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminOptionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminOptionsHash();

  @$internal
  @override
  AdminOptions create() => AdminOptions();
}

String _$adminOptionsHash() => r'66b26b80d537ee9406a5012fcf84c38e7181ed05';

abstract class _$AdminOptions
    extends $StreamNotifier<QuerySnapshot<AdminOption>> {
  Stream<QuerySnapshot<AdminOption>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<QuerySnapshot<AdminOption>>,
              QuerySnapshot<AdminOption>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<QuerySnapshot<AdminOption>>,
                QuerySnapshot<AdminOption>
              >,
              AsyncValue<QuerySnapshot<AdminOption>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
