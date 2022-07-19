import 'package:bank/modules/budget/data/datasources/budget_local_data_source.dart';
import 'package:bank/modules/budget/data/repositories/budget_repository_impl.dart';
import 'package:bank/modules/budget/domain/repositories/budget_repository.dart';
import 'package:bank/modules/budget/domain/usecases/create_budget.dart';
import 'package:bank/modules/budget/domain/usecases/get_list_budget.dart';
import 'package:bank/modules/budget/presentation/bloc/budget_bloc.dart';
import 'package:bank/modules/forecast/domain/usecases/delete_forecast.dart';
import 'package:bank/modules/forecast/domain/usecases/get_list_forecast.dart';

import '../../../injection_container.dart';
import '../domain/usecases/delete_budget.dart';
import '../domain/usecases/update_budget.dart';

class InjectDependencyBudget extends IconfigureDependencies {
  InjectDependencyBudget();

  @override
  injectBloc() {
    sl.registerFactory(() => BudgetBloc(sl(), sl(), sl(), sl(), sl(), sl()));
  }

  @override
  injectDataSource() {
    sl.registerLazySingleton<BudgetLocalDataSource>(
      () => BudgetLocalDataSourceImpl());
  }

  @override
  injectRepository() {
    sl.registerLazySingleton<BudgetRepository>(() => BudgetRepositoryImpl(sl()));
  }

  @override
  injectUseCase() {
    sl.registerLazySingleton(() => CreateBudget(sl()));
    sl.registerLazySingleton(() => UpdateBudget(sl()));
    sl.registerLazySingleton(() => DeleteBudget(sl()));
    sl.registerLazySingleton(() => GetListBudget(sl()));
  }

  @override
  inject() {
    injectBloc();
    injectDataSource();
    injectRepository();
    injectUseCase();
  }
}
