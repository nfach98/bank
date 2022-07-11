part of 'period_bloc.dart';

class PeriodState extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? message;
  final List<PeriodEntity>? listPeriod;

  const PeriodState({
    this.startDate,
    this.endDate,
    this.message,
    this.listPeriod,
  });

  PeriodState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? message,
    List<PeriodEntity>? listPeriod,
  }) {
    return PeriodState(
      startDate: startDate,
      endDate: endDate,
      message: message,
      listPeriod: listPeriod ?? []
    );
  }

  @override
  List<Object?> get props => [
    startDate,
    endDate,
    message,
    listPeriod,
  ];
}