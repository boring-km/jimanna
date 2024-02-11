import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jimanna/models/admin_option.dart';
import 'package:jimanna/models/black_twin.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/team.dart';

class FireStoreFactory {
  static CollectionReference<BlackTwin> blackTwinRef() =>
      FirebaseFirestore.instance.collection('blacklist').withConverter(
            fromFirestore: (sn, _) => BlackTwin.fromJson(sn.data()!),
            toFirestore: (name, _) => name.toJson(),
          );

  static CollectionReference<AdminOption> adminOptionRef() =>
      FirebaseFirestore.instance.collection('admin').withConverter(
            fromFirestore: (sn, _) => AdminOption.fromJson(sn.data()!),
            toFirestore: (adminOption, _) => adminOption.toJson(),
          );

  static CollectionReference<Team> teamRef() =>
      FirebaseFirestore.instance.collection('teams').withConverter(
            fromFirestore: (sn, _) => Team.fromJson(sn.data()!),
            toFirestore: (team, _) => team.toJson(),
          );

  static CollectionReference<Name> namesByCurrentYearMonthRef() =>
      FirebaseFirestore.instance
          // TODO 최종은 여기로
          // .collection(getCurrentYearMonthOnly())
          .collection('names')
          .withConverter(
            fromFirestore: (sn, _) => Name.fromJson(sn.data()!),
            toFirestore: (name, _) => name.toJson(),
          );

  static CollectionReference<Name> namesRef() =>
      FirebaseFirestore.instance.collection('names').withConverter(
            fromFirestore: (sn, _) => Name.fromJson(sn.data()!),
            toFirestore: (name, _) => name.toJson(),
          );
}
