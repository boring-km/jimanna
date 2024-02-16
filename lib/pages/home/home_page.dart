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

  final isMobileState = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    FireStoreFactory.adminOptionRef().snapshots().listen((event) {
      if (event.docs.first.data().is_start_draw) {
        final isDrawEnd = event.docs.first.data().is_draw_end;
        if (isMobileState.value) {
          Navigator.popAndPushNamed(context, Routes.drawMobileResult, arguments: isDrawEnd);
        } else {
          Navigator.popAndPushNamed(context, Routes.drawResult, arguments: isDrawEnd);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isMobile = width < 787 || height < 787;
    isMobileState.value = isMobile;

    return Scaffold(
      body: isMobile
          ? const HomeMobileView()
          : HomeDesktopView(
              isAdmin: widget.isAdmin,
            ),
    );
  }
}
