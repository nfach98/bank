import 'package:bank/common/utils/dio_config.dart';
import 'package:bank/modules/budget/di/dependency.dart';
import 'package:bank/modules/forecast/di/dependency.dart';
import 'package:bank/modules/main/di/dependency.dart';
import 'package:bank/modules/period/di/dependency.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

abstract class IconfigureDependencies {
  inject();

  injectDataSource();
  injectRepository();
  injectBloc();
  injectUseCase();
}

Future configureDependencies() async {
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => createDio(sharedPreferences: sl()));

  //! features dependencies
  InjectDependencyMain().inject();
  InjectDependencyPeriod().inject();
  InjectDependencyBudget().inject();
  InjectDependencyForecast().inject();
}
