part of 'budget_bloc.dart';

class BudgetState extends Equatable {
  final String? message;
  final List<PeriodEntity>? listPeriod;
  final String? selectedPeriod;

  const BudgetState({
    this.message,
    this.listPeriod,
    this.selectedPeriod,
  });

  BudgetState copyWith({
    String? message,
    List<PeriodEntity>? listPeriod,
    String? selectedPeriod,
  }) {
    return BudgetState(
      message: message,
      listPeriod: listPeriod ?? this.listPeriod,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }

  @override
  List<Object?> get props => [
    message,
    listPeriod,
    selectedPeriod
  ];
}
