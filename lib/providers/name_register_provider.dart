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
          toFirestore: (name, _) => name.toJson(),
        );

    adminOptionRef =
        FirebaseFirestore.instance.collection('admin').withConverter(
              fromFirestore: (sn, _) => AdminOption.fromJson(sn.data()!),
              toFirestore: (name, _) => name.toJson(),
            );

    nameListRef = FirebaseFirestore.instance.collection('names').withConverter(
          fromFirestore: (sn, _) => Name.fromJson(sn.data()!),
          toFirestore: (name, _) => name.toJson(),
        );

    getAdminPassword().then((value) => _adminPassword = value);
  }

  late final CollectionReference<Name> nameRef;
  late final CollectionReference<AdminOption> adminOptionRef;
  late final CollectionReference<Name> nameListRef;

  void registerNameToFirestore(String name) {
    alwaysTrueIfAdmin(name);
    addNameIfNotAdmin(name);
    Future.delayed(
      const Duration(milliseconds: 500),
      () => state = const Result.empty(),
    );
  }

  final screenOnly = '관리자';
  String _adminPassword = 'adminPassword';

  Future<void> addNameIfNotAdmin(String name) async {
    // get password from adminOptionRef

    if (name != _adminPassword && name != screenOnly && name.isNotEmpty) {
      // nameListRef 에 모든 doc 중에 name이 있을 때만 추가
      final nameListDocs = await nameListRef.get();
      if (nameListDocs.docs.any((element) => element.data().name == name)) {
        // nameRef 에 name이 없을 때만 추가
        final nameDocs = await nameRef.get();
        if (!nameDocs.docs.any((element) => element.data().name == name)) {
          await nameRef.add(Name(name));
          state = const Result.success(Routes.home);
        } else {
          state = const Result.error('이미 등록된 이름입니다.');
        }
      } else {
        state = const Result.error('등록되지 않은 이름입니다.');
      }
    }
  }

  Future<String> getAdminPassword() async {
    final adminOptionDocs = await adminOptionRef.get();
    final adminOption = adminOptionDocs.docs.first.data();
    final adminPassword = adminOption.password;
    return adminPassword;
  }

  void alwaysTrueIfAdmin(String name) {
    if (name == _adminPassword) {
      state = const Result.success(Routes.admin);
    } else if (name == screenOnly) {
      state = const Result.success(Routes.home);
    }
  }

  void checkAdmin(String name) {
    if (name == _adminPassword) {
      state = const Result.success(Routes.admin);
    } else if (name == screenOnly) {
      state = const Result.success(Routes.home);
    }
  }
}
