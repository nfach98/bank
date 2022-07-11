import 'package:bank/modules/main/data/datasources/main_local_data_source.dart';
import 'package:bank/modules/main/data/repositories/main_repository_impl.dart';
import 'package:bank/modules/main/domain/repositories/main_repository.dart';
import 'package:bank/modules/main/domain/usecases/get_list_category.dart';

import '../../../injection_container.dart';
import '../presentation/bloc/main_bloc.dart';

class InjectDependencyMain extends IconfigureDependencies {
  InjectDependencyMain();
  @override
  injectBloc() {
    sl.registerFactory(() => MainBloc(sl()));
  }

  @override
  injectDataSource() {
    sl.registerLazySingleton<MainLocalDataSource>(
            () => MainLocalDataSourceImpl());
  }

  @override
  injectRepository() {
    sl.registerLazySingleton<MainRepository>(() => MainRepositoryImpl(sl()));
  }

  @override
  injectUseCase() {
    sl.registerLazySingleton(() => GetListCategory(sl()));
  }

  @override
  inject() {
    injectBloc();
    injectDataSource();
    injectRepository();
    injectUseCase();
  }
}
