import 'package:bank/modules/actual/domain/entities/actual_entity.dart';
import 'package:bank/modules/actual/domain/usecases/create_actual.dart';
import 'package:bank/modules/actual/domain/usecases/delete_actual.dart';
import 'package:bank/modules/actual/domain/usecases/get_list_actual.dart';
import 'package:bank/modules/actual/domain/usecases/update_actual.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../main/domain/entities/category_entity.dart';
import '../../../main/domain/usecases/get_list_category.dart';
import '../../../period/domain/entities/period_entity.dart';
import '../../../period/domain/usecases/get_list_period.dart';

part 'actual_event.dart';
part 'actual_state.dart';

class ActualBloc extends Bloc<ActualEvent, ActualState> {
  final GetListPeriod getListPeriod;
  final GetListCategory getListCategory;
  final GetListActual getListActual;
  final CreateActual createActual;
  final UpdateActual updateActual;
  final DeleteActual deleteActual;

  ActualBloc(
      this.getListPeriod,
      this.getListCategory,
      this.getListActual,
      this.createActual,
      this.updateActual,
      this.deleteActual,
    ) : super(const ActualState()) {
    on<GetListPeriodEvent>((event, emit) async {
      final getListPeriodCase = await getListPeriod.execute();
      emit(getListPeriodCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) {
          return state.copyWith(
            listPeriod: r,
          );
        },
      ));
    });

    on<GetListCategoryEvent>((event, emit) async {
      final getListCategoryCase = await getListCategory.execute();
      emit(getListCategoryCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          listCategory: r,
          listTypeCategory: r.map((e) => e.type ?? '').toSet().toList(),
        ),
      ));
    });

    on<ChangeCategoryEvent>((event, emit) async {
      emit(state.copyWith(
        selectedCategory: event.id,
      ));
    });

    on<ChangeCategoryTypeEvent>((event, emit) async {
      emit(state.copyWith(
        selectedTypeCategory: event.id,
      ));
    });

    on<ChangeDateEvent>((event, emit) async {
      emit(state.copyWith(
        date: event.date,
      ));
    });

    on<CreateActualEvent>((event, emit) async {
      final createBudgetCase = await createActual.execute(CreateActualParams(
        idCategory: event.idCategory,
        type: event.type,
        name: event.name,
        amount: event.amount,
        date: event.date,
      ));
      emit(createBudgetCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          message: 'success',
        ),
      ));
    });

    on<UpdateActualEvent>((event, emit) async {
      final updateBudgetCase = await updateActual.execute(UpdateActualParams(
        id: event.id,
        idCategory: event.idCategory,
        type: event.type,
        name: event.name,
        amount: event.amount,
        date: event.date,
      ));
      emit(updateBudgetCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          message: 'success',
        ),
      ));
    });

    on<DeleteActualEvent>((event, emit) async {
      final deleteBudgetCase = await deleteActual.execute(DeleteActualParams(
        id: event.id,
      ));
      emit(deleteBudgetCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          message: 'success',
        ),
      ));
    });

    on<GetListActualEvent>((event, emit) async {
      final getListForecaseCase = await getListActual.execute();
      emit(getListForecaseCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          listActual: r,
        ),
      ));
    });
  }
}
