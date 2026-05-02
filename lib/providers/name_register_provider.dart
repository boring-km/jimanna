import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/name.dart';
import 'package:jimanna/models/result.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:jimanna/routes.dart';

final nameRegisterProvider =
    NotifierProvider<NameRegisterNotifier, Result<String>>(
  NameRegisterNotifier.new,
);

class NameRegisterNotifier extends Notifier<Result<String>> {
  static const _screenOnly = '관리자';
  String _adminPassword = 'adminPassword';

  late final currentParticipantRef =
      FireStoreFactory.namesByCurrentYearMonthRef();
  late final adminOptionRef = FireStoreFactory.adminOptionRef();
  late final nameListRef = FireStoreFactory.abadNamesRef();
  late final secondNameListRef = FireStoreFactory.secondNamesRef();

  @override
  Result<String> build() {
    getAdminPassword().then((value) => _adminPassword = value);
    return const Result<String>.empty();
  }

  void registerNameToFirestore(String name) {
    alwaysTrueIfAdmin(name);
    addNameIfNotAdmin(name);
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => state = const Result<String>.empty(),
    );
  }

  Future<void> addNameIfNotAdmin(String name) async {
    if (name != _adminPassword && name != _screenOnly && name.isNotEmpty) {
      final abadNameList = await nameListRef.get();
      final secondNameList = await secondNameListRef.get();

      final isAbad = abadNameList.docs.any((e) => e.data().name == name);
      final isPaqad = secondNameList.docs.any((e) => e.data().name == name);
      if (isAbad) {
        await addParticipant(Name(name, type: 'abad'));
        state = const Result<String>.success(Routes.home);
      } else if (isPaqad) {
        await addParticipant(Name(name, type: 'paqad'));
        state = const Result<String>.success(Routes.home);
      } else {
        state = const Result<String>.error('등록되지 않은 이름입니다.');
      }
    }
  }

  Future<void> addParticipant(Name name) async {
    final nameDocs = await currentParticipantRef.get();
    if (!hasNamesInParticipantList(nameDocs, name)) {
      await currentParticipantRef.add(name);
    }
  }

  bool hasNamesInPaqad(QuerySnapshot<Name> secondNameList, String name) =>
      secondNameList.docs.any((e) => e.data().name == name);

  bool hasNamesInAbad(QuerySnapshot<Name> abadNameList, String name) =>
      abadNameList.docs.any((element) => element.data().name == name);

  bool hasNamesInParticipantList(QuerySnapshot<Name> nameDocs, Name name) =>
      nameDocs.docs.any((element) => element.data().name == name.name);

  Future<String> getAdminPassword() async {
    final adminOptionDocs = await adminOptionRef.get();
    final adminOption = adminOptionDocs.docs.first.data();
    final adminPassword = adminOption.password;
    return adminPassword;
  }

  void alwaysTrueIfAdmin(String name) {
    if (name == _adminPassword) {
      state = const Result<String>.success(Routes.admin);
    } else if (name == _screenOnly) {
      state = const Result<String>.success(Routes.homeAdmin);
    }
  }

  void checkAdmin(String name) {
    if (name == _adminPassword) {
      state = const Result<String>.success(Routes.admin);
    } else if (name == _screenOnly) {
      state = const Result<String>.success(Routes.homeAdmin);
    }
  }

  void initialize() {
    state = const Result<String>.empty();
  }
}
