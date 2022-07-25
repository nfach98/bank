part of 'period_bloc.dart';

class PeriodState extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? message;
  final List<PeriodEntity>? listPeriod;
  final String? selectedPeriod;

  const PeriodState({
    this.startDate,
    this.endDate,
    this.message,
    this.listPeriod,
    this.selectedPeriod,
  });

  PeriodState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? message,
    List<PeriodEntity>? listPeriod,
    String? selectedPeriod,
  }) {
    return PeriodState(
      startDate: startDate,
      endDate: endDate,
      message: message,
      listPeriod: listPeriod ?? this.listPeriod,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }

  @override
  List<Object?> get props => [
    startDate,
    endDate,
    message,
    listPeriod,
    selectedPeriod,
  ];
}