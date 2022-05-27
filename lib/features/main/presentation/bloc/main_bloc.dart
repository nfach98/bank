import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState(currentIndex: 0, isCollapsed: true)) {
    on<ChangePageEvent>((event, emit) {
      emit(state.copyWith(index: event.index));
    });

    on<ClickMenuEvent>((event, emit) {
      emit(state.copyWith(isCollapsed: event.isCollapsed));
    });
  }
}
