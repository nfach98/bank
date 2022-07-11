part of 'budget_bloc.dart';

class BudgetState extends Equatable {
  final String? message;
  final String? selectedPeriod;
  final String? selectedCategory;
  final List<PeriodEntity>? listPeriod;
  final List<CategoryEntity>? listCategory;
  final List<BudgetEntity>? listBudget;

  const BudgetState({
    this.message,
    this.selectedPeriod,
    this.selectedCategory,
    this.listPeriod,
    this.listCategory,
    this.listBudget,
  });

  BudgetState copyWith({
    String? message,
    String? selectedPeriod,
    String? selectedCategory,
    List<PeriodEntity>? listPeriod,
    List<CategoryEntity>? listCategory,
    List<BudgetEntity>? listBudget,
  }) {
    return BudgetState(
      message: message,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      listPeriod: listPeriod ?? this.listPeriod,
      listCategory: listCategory ?? this.listCategory,
      listBudget: listBudget ?? this.listBudget,
    );
  }

  @override
  List<Object?> get props => [
    message,
    selectedPeriod,
    selectedCategory,
    listPeriod,
    listCategory,
    listBudget,
  ];
}
