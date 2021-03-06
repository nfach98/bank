import 'package:bank/modules/budget/presentation/bloc/budget_bloc.dart';
import 'package:bank/modules/forecast/data/datasources/forecast_local_data_source.dart';
import 'package:bank/modules/forecast/domain/repositories/forecast_repository.dart';
import 'package:bank/modules/forecast/domain/usecases/create_forecast.dart';
import 'package:bank/modules/forecast/domain/usecases/get_list_forecast.dart';
import 'package:bank/modules/forecast/presentation/bloc/forecast_bloc.dart';

import '../../../injection_container.dart';
import '../data/repositories/forecast_repository_impl.dart';
import '../domain/usecases/delete_forecast.dart';
import '../domain/usecases/update_forecast.dart';

class InjectDependencyForecast extends IconfigureDependencies {
  InjectDependencyForecast();

  @override
  injectBloc() {
    sl.registerFactory(() => ForecastBloc(sl(), sl(), sl(), sl(), sl(), sl()));
  }

  @override
  injectDataSource() {
    sl.registerLazySingleton<ForecastLocalDataSource>(
      () => ForecastLocalDataSourceImpl());
  }

  @override
  injectRepository() {
    sl.registerLazySingleton<ForecastRepository>(() => ForecastRepositoryImpl(sl()));
  }

  @override
  injectUseCase() {
    sl.registerLazySingleton(() => CreateForecast(sl()));
    sl.registerLazySingleton(() => UpdateForecast(sl()));
    sl.registerLazySingleton(() => DeleteForecast(sl()));
    sl.registerLazySingleton(() => GetListForecast(sl()));
  }

  @override
  inject() {
    injectBloc();
    injectDataSource();
    injectRepository();
    injectUseCase();
  }
}
