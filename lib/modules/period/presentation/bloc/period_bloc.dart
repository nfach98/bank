import 'package:bank/modules/period/domain/entities/period_entity.dart';
import 'package:bank/modules/period/domain/usecases/create_period.dart';
import 'package:bank/modules/period/domain/usecases/delete_period.dart';
import 'package:bank/modules/period/domain/usecases/get_list_period.dart';
import 'package:bank/modules/period/domain/usecases/update_period.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  final CreatePeriod createPeriod;
  final GetListPeriod getListPeriod;
  final UpdatePeriod updatePeriod;
  final DeletePeriod deletePeriod;

  PeriodBloc(this.createPeriod, this.getListPeriod, this.updatePeriod, this.deletePeriod) : super(const PeriodState()) {
    on<ChangeDateTimeRangeEvent>((event, emit) {
      emit(state.copyWith(
        startDate: event.startDate,
        endDate: event.endDate,
      ));
    });

    on<CreatePeriodEvent>((event, emit) async {
      final createPeriodCase = await createPeriod.execute(CreatePeriodParams(
        dateStart: DateFormat('yyyy-MM-dd').format(event.startDate),
        dateEnd: DateFormat('yyyy-MM-dd').format(event.endDate),
      ));
      emit(createPeriodCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          message: 'success',
        ),
      ));
    });

    on<GetListPeriodEvent>((event, emit) async {
      final getListPeriodCase = await getListPeriod.execute();
      emit(getListPeriodCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) => state.copyWith(
          listPeriod: r,
        ),
      ));
    });

    on<UpdatePeriodEvent>((event, emit) async {
      final updateBudgetCase = await updatePeriod.execute(UpdatePeriodParams(
        id: event.id,
        dateStart: DateFormat('yyyy-MM-dd').format(event.startDate),
        dateEnd: DateFormat('yyyy-MM-dd').format(event.endDate),
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

    on<DeletePeriodEvent>((event, emit) async {
      final deleteBudgetCase = await deletePeriod.execute(DeletePeriodParams(
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
  }
}