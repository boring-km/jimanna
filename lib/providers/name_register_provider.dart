import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/result.dart';
import 'package:jimanna/providers/current_name.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:jimanna/routes.dart';

final nameRegisterProvider =
    StateNotifierProvider<NameRegisterNotifier, Result<String>>((ref) {
  return NameRegisterNotifier();
});

class NameRegisterNotifier extends StateNotifier<Result<String>> {
  NameRegisterNotifier() : super(const Result.empty()) {
    getAdminPassword().then((value) => _adminPassword = value);
  }

  final nameRef = FireStoreFactory.namesByCurrentYearMonthRef;
  final adminOptionRef = FireStoreFactory.adminOptionRef;
  final nameListRef = FireStoreFactory.namesRef;

  void registerNameToFirestore(String name) {
    alwaysTrueIfAdmin(name);
    addNameIfNotAdmin(name);
    Future.delayed(
      const Duration(milliseconds: 500),
      () => state = const Result.empty(),
    );
  }

  final screenOnly = '관리자';
  var _adminPassword = 'adminPassword';

  Future<void> addNameIfNotAdmin(String name) async {
    // get password from adminOptionRef

    if (name != _adminPassword && name != screenOnly && name.isNotEmpty) {
      // nameListRef 에 모든 doc 중에 name이 있을 때만 추가
      final nameListDocs = await nameListRef.get();
      if (nameListDocs.docs.any((element) => element.data().name == name)) {
        // nameRef 에 name이 없을 때만 추가
        final nameDocs = await nameRef.get();
        CurrentName.value = name;
        if (!nameDocs.docs.any((element) => element.data().name == name)) {
          await nameRef.add(Name(name));
          state = const Result.success(Routes.home);
        } else {
          state = const Result.success(Routes.home);
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
      state = const Result.success(Routes.homeAdmin);
    }
  }

  void checkAdmin(String name) {
    if (name == _adminPassword) {
      state = const Result.success(Routes.admin);
    } else if (name == screenOnly) {
      state = const Result.success(Routes.homeAdmin);
    }
  }
}
