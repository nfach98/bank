import 'package:bank/modules/period/domain/entities/period_entity.dart';
import 'package:bank/modules/period/domain/usecases/create_period.dart';
import 'package:bank/modules/period/domain/usecases/get_list_period.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  final CreatePeriod createPeriod;
  final GetListPeriod getListPeriod;

  PeriodBloc(this.createPeriod, this.getListPeriod) : super(const PeriodState()) {
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
  }
}