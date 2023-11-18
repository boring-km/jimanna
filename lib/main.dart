import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/firebase_options.dart';
import 'package:jimanna/pages/admin_black_list_page.dart';
import 'package:jimanna/pages/admin_draw_page.dart';
import 'package:jimanna/pages/admin_draw_result_page.dart';
import 'package:jimanna/pages/admin_name_list_page.dart';
import 'package:jimanna/pages/admin_page.dart';
import 'package:jimanna/pages/home_page.dart';
import 'package:jimanna/pages/register_page.dart';
import 'package:jimanna/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: '평화교회 아바드 지만나',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'NotoSansKR',
          useMaterial3: true,
        ),
        initialRoute: Routes.register,
        routes: {
          Routes.home: (context) => const HomePage(),
          Routes.register: (context) => const RegisterPage(),
          Routes.admin: (context) => const AdminPage(),
          Routes.adminDraw: (context) => const AdminDrawPage(),
          Routes.adminDrawResult: (context) => const AdminDrawResultPage(),
          Routes.adminBlackList: (context) => const AdminBlackListPage(),
          Routes.adminNameList: (context) => const AdminNameListPage(),
        },
        home: const HomePage(),
      ),
    );
  }
}
