import 'package:flutter/material.dart';
import 'package:jimanna/home_page.dart';
import 'package:jimanna/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '평화교회 아바드 지만나',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.home,
      onGenerateRoute: Pages.getPages,
      home: const HomePage(),
    );
  }
}
