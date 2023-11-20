import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/result.dart';
import 'package:jimanna/utils/date_utils.dart';

final nameRegisterProvider =
    StateNotifierProvider<NameRegisterNotifier, Result<bool>>((ref) {
  return NameRegisterNotifier();
});

class NameRegisterNotifier extends StateNotifier<Result<bool>> {
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

  void addNameIfNotAdmin(String name) {
    if (name != 'admin') {
      nameRef.add(Name(name));
      state = const Result.success(true);
    }
  }

  void alwaysTrueIfAdmin(String name) {
    if (name == 'admin') {
      state = const Result.success(true);
    }
  }
}
