import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/firebase_options.dart';
import 'package:jimanna/gen/colors.gen.dart';
import 'package:jimanna/gen/fonts.gen.dart';
import 'package:jimanna/pages/error/error_page.dart';
import 'package:jimanna/routes.dart';
import 'package:jimanna/ui/themes.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
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
        title: '평화교회 영피스 지만나',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorName.blueDark),
          fontFamily: FontFamily.dungGeunMo,
          useMaterial3: true,
          textTheme: textTheme,
        ),
        initialRoute: Routes.register,
        onGenerateRoute: Pages.getPages,
        onUnknownRoute: (_) => MaterialPageRoute(
          builder: (_) => const ErrorPage(),
        ),
      ),
    );
  }
}
