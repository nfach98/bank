import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:bank/modules/budget/domain/usecases/create_budget.dart';
import 'package:bank/modules/budget/domain/usecases/get_list_budget.dart';
import 'package:bank/modules/main/domain/entities/category_entity.dart';
import 'package:bank/modules/main/domain/usecases/get_list_category.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../period/domain/entities/period_entity.dart';
import '../../../period/domain/usecases/get_list_period.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final GetListPeriod getListPeriod;
  final GetListCategory getListCategory;
  final GetListBudget getListBudget;
  final CreateBudget createBudget;

  BudgetBloc(this.getListPeriod, this.getListBudget, this.createBudget, this.getListCategory) : super(const BudgetState()) {
    on<GetListPeriodEvent>((event, emit) async {
      final getListPeriodCase = await getListPeriod.execute();
      emit(getListPeriodCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) {
          String? selected = r.where((e) => (DateTime.parse(e.dateStart ?? '').isBefore(DateTime.now())
              || DateTime.parse(e.dateStart ?? '').isAtSameMomentAs(DateTime.now()))
              && DateTime.parse(e.dateEnd ?? '').isAfter(DateTime.now())).toList()[0].id;
          return state.copyWith(
            listPeriod: r,
            selectedPeriod: selected,
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

    on<ChangeDropdownPeriodEvent>((event, emit) async {
      emit(state.copyWith(
        selectedPeriod: event.id,
      ));
    });

    on<ChangeDropdownCategoryEvent>((event, emit) async {
      emit(state.copyWith(
        selectedCategory: event.id,
      ));
    });

    on<ChangeTypeCategoryEvent>((event, emit) async {
      emit(state.copyWith(
        selectedTypeCategory: event.id,
      ));
    });

    on<CreateBudgetEvent>((event, emit) async {
      final createBudgetCase = await createBudget.execute(CreateBudgetParams(
        idPeriod: event.idPeriod,
        idCategory: event.idCategory,
        name: event.name,
        amount: event.amount
      ));
      emit(createBudgetCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          message: 'success',
          listCategory: state.listCategory,
          listPeriod: state.listPeriod,
        ),
      ));
    });

    on<GetListBudgetEvent>((event, emit) async {
      final getListBudgetCase = await getListBudget.execute(GetListBudgetParams(
        idPeriod: event.idPeriod,
      ));
      emit(getListBudgetCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          listBudget: r,
          listCategory: state.listCategory,
          listPeriod: state.listPeriod,
        ),
      ));
    });
  }
}
