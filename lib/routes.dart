import 'package:flutter/material.dart';
import 'package:jimanna/home_page.dart';
import 'package:jimanna/register_page.dart';

class Routes {
  static const String home = '/';
  static const String register = '/register';
}

class Pages {
  static Route<dynamic>? getPages(RouteSettings settings) {
    final arguments = settings.arguments;
    final router = _PageRouter(arguments);
    switch (settings.name) {
      case Routes.home:
        return router.create(child: const HomePage());
      case Routes.register:
        return router.create(child: const RegisterPage());
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
