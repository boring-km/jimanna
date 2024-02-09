import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/pages/home/home_desktop_view.dart';
import 'package:jimanna/pages/home/home_mobile_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, this.isAdmin = false});

  final bool isAdmin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isMobile = width < 787 || height < 787;

    return Scaffold(
      body: isMobile
          ? const HomeMobileView()
          : HomeDesktopView(
              isAdmin: isAdmin,
            ),
    );
  }
}
