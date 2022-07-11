import 'package:bank/app.dart';
import 'package:bank/common/loggers/bloc_event_logger.dart';
import 'package:bank/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await initializeDateFormatting('id');

  await Hive.initFlutter();
  await Hive.openBox('periods');
  await Hive.openBox('categories');
  await Hive.openBox('budgets');

  BlocOverrides.runZoned(() => runApp(const App()),
      blocObserver: BlocEventLogger());
}
