import 'dart:developer';

import 'package:bank/modules/main/domain/usecases/get_list_category.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetListCategory getListCategory;

  MainBloc(this.getListCategory) : super(const MainState(currentIndex: 0, isCollapsed: true)) {
    on<ChangePageEvent>((event, emit) {
      emit(state.copyWith(index: event.index));
    });

    on<ClickMenuEvent>((event, emit) {
      emit(state.copyWith(isCollapsed: event.isCollapsed));
    });

    on<GetCategoryEvent>((event, emit) async {
      final getListPeriodCase = await getListCategory.execute();
      emit(getListPeriodCase.fold(
        (l) => state.copyWith(),
        (r) {
          log(r.toString(), name: 'category');
          return state.copyWith();
        },
      ));
    });
  }
}
