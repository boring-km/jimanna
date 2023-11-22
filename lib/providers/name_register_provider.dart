import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/register_state.dart';
import 'package:jimanna/models/result.dart';
import 'package:jimanna/utils/date_utils.dart';

final nameRegisterProvider =
    StateNotifierProvider<NameRegisterNotifier, Result<RegisterState>>((ref) {
  return NameRegisterNotifier();
});

class NameRegisterNotifier extends StateNotifier<Result<RegisterState>> {
  NameRegisterNotifier() : super(const Result.empty()) {
    final yearMonth = getYearMonthOnly();
    nameRef = FirebaseFirestore.instance.collection(yearMonth).withConverter(
        fromFirestore: (sn, _) => Name.fromJson(sn.data()!),
        toFirestore: (name, _) => name.toJson());
  }

  late final CollectionReference<Name> nameRef;

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
    if (name != adminPassword && name != screenOnly) {
      nameRef.add(Name(name));
      state = const Result.success(RegisterState.success);
    }
  }

  void alwaysTrueIfAdmin(String name) {
    if (name == adminPassword) {
      state = const Result.success(RegisterState.admin);
    } else if (name == screenOnly) {
      state = const Result.success(RegisterState.success);
    }
  }
}
