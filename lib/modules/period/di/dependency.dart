import 'package:bank/modules/period/data/datasources/period_local_data_source.dart';
import 'package:bank/modules/period/data/repositories/period_repository_impl.dart';
import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:bank/modules/period/domain/usecases/create_period.dart';
import 'package:bank/modules/period/domain/usecases/delete_period.dart';
import 'package:bank/modules/period/domain/usecases/get_list_period.dart';
import 'package:bank/modules/period/domain/usecases/update_period.dart';
import 'package:bank/modules/period/presentation/bloc/period_bloc.dart';

import '../../../injection_container.dart';

class InjectDependencyPeriod extends IconfigureDependencies {
  InjectDependencyPeriod();
  @override
  injectBloc() {
    sl.registerFactory(() => PeriodBloc(sl(), sl(), sl(), sl()));
  }

  @override
  injectDataSource() {
    sl.registerLazySingleton<PeriodLocalDataSource>(
      () => PeriodLocalDataSourceImpl());
  }

  @override
  injectRepository() {
    sl.registerLazySingleton<PeriodRepository>(() => PeriodRepositoryImpl(sl()));
  }

  @override
  injectUseCase() {
    sl.registerLazySingleton(() => CreatePeriod(sl()));
    sl.registerLazySingleton(() => GetListPeriod(sl()));
    sl.registerLazySingleton(() => UpdatePeriod(sl()));
    sl.registerLazySingleton(() => DeletePeriod(sl()));
  }

  @override
  inject() {
    injectBloc();
    injectDataSource();
    injectRepository();
    injectUseCase();
  }
}
