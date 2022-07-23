
import 'package:bank/modules/forecast/domain/entities/forecast_entity.dart';
import 'package:bank/modules/forecast/domain/usecases/create_forecast.dart';
import 'package:bank/modules/forecast/domain/usecases/update_forecast.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../forecast/domain/usecases/delete_forecast.dart';
import '../../../forecast/domain/usecases/get_list_forecast.dart';
import '../../../main/domain/entities/category_entity.dart';
import '../../../main/domain/usecases/get_list_category.dart';
import '../../../period/domain/entities/period_entity.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final GetListCategory getListCategory;
  final GetListForecast getListForecast;
  final CreateForecast createForecast;
  final UpdateForecast updateForecast;
  final DeleteForecast deleteForecast;

  ForecastBloc(
      this.getListCategory,
      this.getListForecast,
      this.createForecast,
      this.updateForecast,
      this.deleteForecast,
    ) : super(const ForecastState()) {
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

    on<CreateForecastEvent>((event, emit) async {
      final createBudgetCase = await createForecast.execute(CreateForecastParams(
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

    on<UpdateForecastEvent>((event, emit) async {
      final updateBudgetCase = await updateForecast.execute(UpdateForecastParams(
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
      final getListForecaseCase = await getListForecast.execute();
      emit(getListForecaseCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          listForecast: r,
        ),
      ));
    });
  }
}
