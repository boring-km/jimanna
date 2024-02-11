import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/pages/home/home_desktop_view.dart';
import 'package:jimanna/pages/home/home_mobile_view.dart';
import 'package:jimanna/providers/admin_draw_provider.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:jimanna/providers/is_start_draw_provider.dart';
import 'package:jimanna/routes.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, this.isAdmin = false});

  final bool isAdmin;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  void initState() {
    super.initState();

    FireStoreFactory.adminOptionRef().snapshots().listen((event) {
      if (event.docs.first.data().is_start_draw) {
        Navigator.popAndPushNamed(context, Routes.drawResult);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isMobile = width < 787 || height < 787;

    return Scaffold(
      body: isMobile
          ? const HomeMobileView()
          : HomeDesktopView(
              isAdmin: widget.isAdmin,
            ),
    );
  }
}
