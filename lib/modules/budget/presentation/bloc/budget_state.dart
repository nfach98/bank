part of 'budget_bloc.dart';

class BudgetState extends Equatable {
  final String? message;
  final String? selectedPeriod;
  final List<PeriodEntity>? listPeriod;
  final List<CategoryEntity>? listCategory;
  final List<BudgetEntity>? listBudget;

  const BudgetState({
    this.message,
    this.selectedPeriod,
    this.listPeriod,
    this.listCategory,
    this.listBudget,
  });

  BudgetState copyWith({
    String? message,
    String? selectedPeriod,
    List<PeriodEntity>? listPeriod,
    List<CategoryEntity>? listCategory,
    List<BudgetEntity>? listBudget,
  }) {
    return BudgetState(
      message: message,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      listPeriod: listPeriod ?? this.listPeriod,
      listCategory: listCategory ?? this.listCategory,
      listBudget: listBudget ?? this.listBudget,
    );
  }

  @override
  List<Object?> get props => [
    message,
    selectedPeriod,
    listPeriod,
    listCategory,
    listBudget,
  ];
}
