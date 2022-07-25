import 'package:bank/common/constants/route_constants.dart';
import 'package:bank/modules/actual/presentation/actual_form_page.dart';
import 'package:bank/modules/actual/presentation/actual_page.dart';
import 'package:bank/modules/budget/presentation/budget_form_page.dart';
import 'package:bank/modules/budget/presentation/budget_page.dart';
import 'package:bank/modules/main/presentation/main_page.dart';
import 'package:bank/modules/period/presentation/period_form_page.dart';
import 'package:bank/modules/period/presentation/period_page.dart';
import 'package:flutter/material.dart';

import 'modules/forecast/presentation/forecast_form_page.dart';
import 'modules/forecast/presentation/forecast_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstants.home:
        return MaterialPageRoute(
            builder: (_) => const MainPage());
      case RouteConstants.period:
        return MaterialPageRoute(
            builder: (_) => const PeriodPage());
      case RouteConstants.periodForm:
        return MaterialPageRoute(
            builder: (_) => const PeriodFormPage());
      case RouteConstants.budget:
        return MaterialPageRoute(
            builder: (_) => const BudgetPage());
      case RouteConstants.budgetForm:
        return MaterialPageRoute(
            builder: (_) => const BudgetFormPage());
      case RouteConstants.forecast:
        return MaterialPageRoute(
            builder: (_) => const ForecastPage());
      case RouteConstants.forecastForm:
        return MaterialPageRoute(
            builder: (_) => const ForecastFormPage());
      case RouteConstants.actual:
        return MaterialPageRoute(
            builder: (_) => const ActualPage());
      case RouteConstants.actualForm:
        return MaterialPageRoute(
            builder: (_) => const ActualFormPage());
      default:
        return null;
    }
  }
}
