import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/admin_option.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/result.dart';
import 'package:jimanna/routes.dart';
import 'package:jimanna/utils/date_utils.dart';

final nameRegisterProvider =
    StateNotifierProvider<NameRegisterNotifier, Result<String>>((ref) {
  return NameRegisterNotifier();
});

class NameRegisterNotifier extends StateNotifier<Result<String>> {
  NameRegisterNotifier() : super(const Result.empty()) {
    final yearMonth = getYearMonthOnly();
    nameRef = FirebaseFirestore.instance.collection(yearMonth).withConverter(
        fromFirestore: (sn, _) => Name.fromJson(sn.data()!),
        toFirestore: (name, _) => name.toJson());

    adminOptionRef = FirebaseFirestore.instance.collection('current').withConverter(
        fromFirestore: (sn, _) => AdminOption.fromJson(sn.data()!),
        toFirestore: (name, _) => name.toJson());
  }

  late final CollectionReference<Name> nameRef;
  late final CollectionReference<AdminOption> adminOptionRef;

  void registerNameToFirestore(String name) {
    alwaysTrueIfAdmin(name);
    addNameIfNotAdmin(name);
    Future.delayed(
      const Duration(milliseconds: 500),
      () => state = const Result.empty(),
    );
  }

  final adminPassword = 'qlalfdlwlfhd';
  final screenOnly = '관리자';

  void addNameIfNotAdmin(String name) {
    if (name != adminPassword && name != screenOnly && name.isNotEmpty) {
      nameRef.add(Name(name));
      state = const Result.success(Routes.home);
    }
  }

  void alwaysTrueIfAdmin(String name) {
    if (name == adminPassword) {
      state = const Result.success(Routes.admin);
    } else if (name == screenOnly) {
      state = const Result.success(Routes.home);
    }
  }

  void checkAdmin(String name) {
    if (name == adminPassword) {
      state = const Result.success(Routes.admin);
    } else if (name == screenOnly) {
      state = const Result.success(Routes.home);
    }
  }
}
