import 'package:bank/common/constants/color_constants.dart';
import 'package:bank/common/constants/route_constants.dart';
import 'package:bank/features/main/presentation/bloc/main_bloc.dart';
import 'package:bank/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (_) => sl<MainBloc>()),
      ],
      child: MaterialApp(
        title: 'bank',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: ColorConstants.colorPrimary,
            accentColor: Colors.white,
          ),
        ),
        initialRoute: RouteConstants.home,
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
