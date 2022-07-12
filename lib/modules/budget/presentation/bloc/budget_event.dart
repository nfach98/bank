part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();
}

class GetListPeriodEvent extends BudgetEvent {
  const GetListPeriodEvent();

  @override
  List<Object?> get props => [];
}

class ChangeDropdownPeriodEvent extends BudgetEvent {
  final String id;

  const ChangeDropdownPeriodEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ChangeDropdownCategoryEvent extends BudgetEvent {
  final String id;

  const ChangeDropdownCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ChangeTypeCategoryEvent extends BudgetEvent {
  final String id;

  const ChangeTypeCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateBudgetEvent extends BudgetEvent {
  final String idPeriod;
  final String idCategory;
  final String name;
  final int amount;

  CreateBudgetEvent({required this.idPeriod, required this.idCategory, required this.name, required this.amount});

  @override
  List<Object?> get props => [
    idPeriod,
    idCategory,
    name,
    amount,
  ];
}

class GetListBudgetEvent extends BudgetEvent {
  final String idPeriod;

  const GetListBudgetEvent({required this.idPeriod});

  @override
  List<Object?> get props => [idPeriod];
}

class GetListCategoryEvent extends BudgetEvent {
  const GetListCategoryEvent();

  @override
  List<Object?> get props => [];
}