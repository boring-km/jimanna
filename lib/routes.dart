import 'package:flutter/material.dart';
import 'package:jimanna/pages/admin/admin_black_list_page.dart';
import 'package:jimanna/pages/admin/admin_draw_page.dart';
import 'package:jimanna/pages/admin/admin_draw_result_page.dart';
import 'package:jimanna/pages/admin/admin_name_list_page.dart';
import 'package:jimanna/pages/admin/admin_page.dart';
import 'package:jimanna/pages/admin/admin_current_month_name_list_page.dart';
import 'package:jimanna/pages/draw_result_page.dart';
import 'package:jimanna/pages/error/error_page.dart';
import 'package:jimanna/pages/home/home_page.dart';
import 'package:jimanna/pages/register_page.dart';

class Routes {
  static const String register = '/register';
  static const String home = '/home';
  static const String admin = '/qlalftmfjdnsghkaus';
  static const String adminDraw = '/qlalftmfjdnsghkaus/draw';
  static const String adminDrawResult = '/qlalftmfjdnsghkaus/drawResult';
  static const String adminBlackList = '/qlalftmfjdnsghkaus/blacklist';
  static const String adminNameList = '/qlalftmfjdnsghkaus/namelist';
  static const String adminCurrentParticipants =
      '/qlalftmfjdnsghkaus/currentParticipants';
  static const String homeAdmin = '/homeAdmin';

  static const String drawResult = '/drawResult';
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
      case Routes.homeAdmin:
        return router.create(child: const HomePage(isAdmin: true));
      case Routes.drawResult:
        return router.create(child: const DrawResultPage());
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
        return router.create(child: const AdminCurrentMonthNameListPage());
      default:
        return router.create(child: const ErrorPage());
    }
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
