import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_option.g.dart';

@JsonSerializable()
class AdminOption {
  AdminOption({
    required this.can_register,
    required this.password,
    required this.is_start_draw,
    required this.is_draw_end,
  });

  factory AdminOption.fromJson(Map<String, dynamic> json) =>
      _$AdminOptionFromJson(json);
  final bool can_register;
  final String password;
  final bool is_start_draw;
  final bool is_draw_end;

  Map<String, dynamic> toJson() => _$AdminOptionToJson(this);
}

@Riverpod(keepAlive: true)
class AdminOptions extends _$AdminOptions {
  @override
  Stream<QuerySnapshot<AdminOption>> build() {
    return FireStoreFactory.adminOptionRef().snapshots();
  }

  void endDraw() {
    FireStoreFactory.adminOptionRef().get().then((value) {
      FirebaseFirestore.instance
          .collection('admin')
          .doc(value.docs.first.id)
          .update({
        'is_draw_end': true,
      });
    });
  }

  void setTeamOpened(int teamNumber) {
    FireStoreFactory.adminOptionRef().get().then((value) {
      FirebaseFirestore.instance
          .collection('admin')
          .doc(value.docs.first.id)
          .update({
        'opened_team_number': teamNumber,
      });
    });
  }

  void changePassword(String text) {
    FireStoreFactory.adminOptionRef().get().then((value) {
      FirebaseFirestore.instance
          .collection('admin')
          .doc(value.docs.first.id)
          .update({
        'password': text,
      });
    });
  }
}
