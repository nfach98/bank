import 'package:bank/common/config/themes.dart';
import 'package:bank/common/constants/route_constants.dart';
import 'package:bank/modules/budget/presentation/bloc/budget_bloc.dart';
import 'package:bank/modules/forecast/presentation/bloc/forecast_bloc.dart';
import 'package:bank/modules/main/presentation/bloc/main_bloc.dart';
import 'package:bank/modules/period/presentation/bloc/period_bloc.dart';
import 'package:bank/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'injection_container.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (_) => sl<MainBloc>()),
        BlocProvider<PeriodBloc>(create: (_) => sl<PeriodBloc>()),
        BlocProvider<BudgetBloc>(create: (_) => sl<BudgetBloc>()),
        BlocProvider<ForecastBloc>(create: (_) => sl<ForecastBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 720),
        minTextAdapt: false,
        builder: (_, child) => MaterialApp(
          title: 'bank',
          theme: BankTheme.theme,
          initialRoute: RouteConstants.home,
          onGenerateRoute: AppRouter().onGenerateRoute,
        ),
      ),
    );
  }
}
