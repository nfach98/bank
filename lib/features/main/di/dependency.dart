import '../../../injection_container.dart';
import '../presentation/bloc/main_bloc.dart';

class InjectDependencyMain extends IconfigureDependencies {
  InjectDependencyMain();
  @override
  injectBloc() {
    sl.registerFactory(() => MainBloc());
  }

  @override
  injectDataSource() {}

  @override
  injectRepository() {}

  @override
  injectUseCase() {}

  @override
  inject() {
    injectBloc();
    injectDataSource();
    injectRepository();
    injectUseCase();
  }
}
