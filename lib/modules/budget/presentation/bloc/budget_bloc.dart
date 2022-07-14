import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:bank/modules/budget/domain/usecases/create_budget.dart';
import 'package:bank/modules/budget/domain/usecases/delete_budget.dart';
import 'package:bank/modules/budget/domain/usecases/get_list_budget.dart';
import 'package:bank/modules/budget/domain/usecases/update_budget.dart';
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
  final UpdateBudget updateBudget;
  final DeleteBudget deleteBudget;

  BudgetBloc(
      this.getListPeriod,
      this.getListBudget,
      this.createBudget,
      this.getListCategory,
      this.updateBudget,
      this.deleteBudget,
    ) : super(const BudgetState()) {
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

    on<ChangeDropdownPeriodEvent>((event, emit) async {
      emit(state.copyWith(
        selectedPeriod: event.id,
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

    on<CreateBudgetEvent>((event, emit) async {
      final createBudgetCase = await createBudget.execute(CreateBudgetParams(
        idCategory: event.idCategory,
        type: event.type,
        name: event.name,
        amount: event.amount
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

    on<UpdateBudgetEvent>((event, emit) async {
      final updateBudgetCase = await updateBudget.execute(UpdateBudgetParams(
        id: event.id,
        idCategory: event.idCategory,
        type: event.type,
        name: event.name,
        amount: event.amount
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

    on<DeleteBudgetEvent>((event, emit) async {
      final deleteBudgetCase = await deleteBudget.execute(DeleteBudgetParams(
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

    on<GetListBudgetEvent>((event, emit) async {
      final getListBudgetCase = await getListBudget.execute();
      emit(getListBudgetCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          listBudget: r,
        ),
      ));
    });
  }
}
