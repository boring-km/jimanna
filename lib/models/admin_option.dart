import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_option.g.dart';

@JsonSerializable()
class AdminOption {
  AdminOption({
    required this.can_register,
    required this.password,
    required this.is_start_draw,
  });

  factory AdminOption.fromJson(Map<String, dynamic> json) =>
      _$AdminOptionFromJson(json);
  final bool can_register;
  final String password;
  final bool is_start_draw;

  Map<String, dynamic> toJson() => _$AdminOptionToJson(this);
}

@Riverpod(keepAlive: true)
class AdminOptions extends _$AdminOptions {

  @override
  Stream<QuerySnapshot<AdminOption>> build() {
    return FirebaseFirestore.instance.collection('admin').withConverter(
      fromFirestore: (sn, _) => AdminOption.fromJson(sn.data()!),
      toFirestore: (adminOption, _) => adminOption.toJson(),
    ).snapshots();
  }
}
