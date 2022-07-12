part of 'budget_bloc.dart';

class BudgetState extends Equatable {
  final String? message;
  final String? selectedPeriod;
  final String? selectedCategory;
  final String? selectedTypeCategory;
  final List<PeriodEntity>? listPeriod;
  final List<CategoryEntity>? listCategory;
  final List<String>? listTypeCategory;
  final List<BudgetEntity>? listBudget;

  const BudgetState({
    this.message,
    this.selectedPeriod,
    this.selectedCategory,
    this.selectedTypeCategory,
    this.listPeriod,
    this.listCategory,
    this.listTypeCategory,
    this.listBudget,
  });

  BudgetState copyWith({
    String? message,
    String? selectedPeriod,
    String? selectedCategory,
    String? selectedTypeCategory,
    List<PeriodEntity>? listPeriod,
    List<CategoryEntity>? listCategory,
    List<String>? listTypeCategory,
    List<BudgetEntity>? listBudget,
  }) {
    return BudgetState(
      message: message,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedTypeCategory: selectedTypeCategory ?? this.selectedTypeCategory,
      listPeriod: listPeriod ?? this.listPeriod,
      listCategory: listCategory ?? this.listCategory,
      listTypeCategory: listTypeCategory ?? this.listTypeCategory,
      listBudget: listBudget ?? this.listBudget,
    );
  }

  @override
  List<Object?> get props => [
    message,
    selectedPeriod,
    selectedCategory,
    selectedTypeCategory,
    listPeriod,
    listCategory,
    listBudget,
  ];
}
