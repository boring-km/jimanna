import 'package:flutter/material.dart';
import 'package:jimanna/pages/admin_black_list_page.dart';
import 'package:jimanna/pages/admin_draw_page.dart';
import 'package:jimanna/pages/admin_draw_result_page.dart';
import 'package:jimanna/pages/admin_name_list_page.dart';
import 'package:jimanna/pages/admin_page.dart';
import 'package:jimanna/pages/current_month_name_list_page.dart';
import 'package:jimanna/pages/home_page.dart';
import 'package:jimanna/pages/register_page.dart';

class Routes {
  static const String register = '/register';
  static const String home = '/home';
  static const String admin = '/qlalftmfjdnsghkaus';
  static const String adminDraw = '/qlalftmfjdnsghkaus/draw';
  static const String adminDrawResult = '/qlalftmfjdnsghkaus/drawResult';
  static const String adminBlackList = '/qlalftmfjdnsghkaus/blacklist';
  static const String adminNameList = '/qlalftmfjdnsghkaus/namelist';
  static const String adminCurrentParticipants = '/qlalftmfjdnsghkaus/currentParticipants';
}

class Pages {
  static Route<dynamic>? getPages(RouteSettings settings) {
    final arguments = settings.arguments;
    final router = _PageRouter(arguments);
    switch (settings.name) {
      case Routes.register:
        return router.create(child: const RegisterPage());
      case Routes.home:
        return router.create(child: const HomePage());
      case Routes.admin:
        return router.create(child: const AdminPage());
      case Routes.adminDraw:
        return router.create(child: const AdminDrawPage());
      case Routes.adminDrawResult:
        return router.create(child: const AdminDrawResultPage());
      case Routes.adminBlackList:
        return router.create(child: const AdminBlackListPage());
      case Routes.adminNameList:
        return router.create(child: const AdminNameListPage());
      case Routes.adminCurrentParticipants:
        return router.create(child: const CurrentMonthNameListPage());
    }
    return null;
  }
}

class _PageRouter {
  _PageRouter(this.arguments);

  final Object? arguments;

  PageRoute<dynamic> create({
    required Widget child,
    bool? maintainState = true,
    bool? fullscreenDialog = false,
  }) {
    return MaterialPageRoute(
      builder: (context) => child,
      settings: RouteSettings(
        arguments: arguments,
      ),
      maintainState: maintainState!,
      fullscreenDialog: fullscreenDialog!,
    );
  }
}

