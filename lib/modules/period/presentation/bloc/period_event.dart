part of 'period_bloc.dart';

abstract class PeriodEvent extends Equatable {
  const PeriodEvent();
}

class ChangeDateTimeRangeEvent extends PeriodEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const ChangeDateTimeRangeEvent({this.startDate, this.endDate});

  @override
  List<Object?> get props => [
    startDate,
    endDate,
  ];
}

class CreatePeriodEvent extends PeriodEvent {
  final DateTime startDate;
  final DateTime endDate;

  const CreatePeriodEvent({required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [
    startDate,
    endDate,
  ];
}

class GetListPeriodEvent extends PeriodEvent {
  const GetListPeriodEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePeriodEvent extends PeriodEvent {
  final String id;
  final DateTime startDate;
  final DateTime endDate;

  const UpdatePeriodEvent({required this.id, required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [
    id,
    startDate,
    endDate,
  ];
}

class DeletePeriodEvent extends PeriodEvent {
  final String id;

  const DeletePeriodEvent({required this.id});

  @override
  List<Object?> get props => [
    id,
  ];
}

class ChangePeriodEvent extends PeriodEvent {
  final String id;

  const ChangePeriodEvent({required this.id});

  @override
  List<Object?> get props => [id];
}