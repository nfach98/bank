import 'package:bank/modules/actual/data/datasources/actual_local_data_source.dart';
import 'package:bank/modules/actual/data/repositories/actual_repository_impl.dart';
import 'package:bank/modules/actual/domain/repositories/actual_repository.dart';
import 'package:bank/modules/actual/domain/usecases/create_actual.dart';
import 'package:bank/modules/actual/domain/usecases/delete_actual.dart';
import 'package:bank/modules/actual/domain/usecases/get_list_actual.dart';
import 'package:bank/modules/actual/domain/usecases/update_actual.dart';
import 'package:bank/modules/actual/presentation/bloc/actual_bloc.dart';

import '../../../injection_container.dart';

class InjectDependencyActual extends IconfigureDependencies {
  InjectDependencyActual();

  @override
  injectBloc() {
    sl.registerFactory(() => ActualBloc(sl(), sl(), sl(), sl(), sl()));
  }

  @override
  injectDataSource() {
    sl.registerLazySingleton<ActualLocalDataSource>(
      () => ActualLocalDataSourceImpl());
  }

  @override
  injectRepository() {
    sl.registerLazySingleton<ActualRepository>(() => ActualRepositoryImpl(sl()));
  }

  @override
  injectUseCase() {
    sl.registerLazySingleton(() => CreateActual(sl()));
    sl.registerLazySingleton(() => UpdateActual(sl()));
    sl.registerLazySingleton(() => DeleteActual(sl()));
    sl.registerLazySingleton(() => GetListActual(sl()));
  }

  @override
  inject() {
    injectBloc();
    injectDataSource();
    injectRepository();
    injectUseCase();
  }
}
