import 'package:bank/common/constants/route_constants.dart';
import 'package:bank/features/main/presentation/main_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstants.home:
        return MaterialPageRoute(
            builder: (_) => const MainPage());
      default:
        return null;
    }
  }
}
