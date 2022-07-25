import 'package:bank/modules/forecast/domain/entities/forecast_entity.dart';
import 'package:bank/modules/forecast/domain/usecases/create_forecast.dart';
import 'package:bank/modules/forecast/domain/usecases/update_forecast.dart';
import 'package:bank/modules/main/domain/entities/category_entity.dart';
import 'package:bank/modules/main/domain/usecases/get_list_category.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../period/domain/entities/period_entity.dart';
import '../../../period/domain/usecases/get_list_period.dart';
import '../../domain/usecases/delete_forecast.dart';
import '../../domain/usecases/get_list_forecast.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final GetListPeriod getListPeriod;
  final GetListCategory getListCategory;
  final GetListForecast getListForecast;
  final CreateForecast createForecast;
  final UpdateForecast updateForecast;
  final DeleteForecast deleteForecast;

  ForecastBloc(
      this.getListPeriod,
      this.getListForecast,
      this.createForecast,
      this.getListCategory,
      this.updateForecast,
      this.deleteForecast,
    ) : super(const ForecastState()) {
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

    on<CreateForecastEvent>((event, emit) async {
      final createBudgetCase = await createForecast.execute(CreateForecastParams(
        idPeriod: event.idPeriod,
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

    on<UpdateForecastEvent>((event, emit) async {
      final updateBudgetCase = await updateForecast.execute(UpdateForecastParams(
        id: event.id,
        idPeriod: event.idPeriod,
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

    on<DeleteForecastEvent>((event, emit) async {
      final deleteBudgetCase = await deleteForecast.execute(DeleteForecastParams(
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

    on<GetListForecastEvent>((event, emit) async {
      final getListBudgetCase = await getListForecast.execute();
      emit(getListBudgetCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          listForecast: r,
        ),
      ));
    });

    on<ChangePeriodEvent>((event, emit) async {
      emit(state.copyWith(
        selectedPeriod: event.id,
      ));
    });
  }
}
