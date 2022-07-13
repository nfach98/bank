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
  final String idCategory;
  final String type;
  final String name;
  final int amount;

  const CreateBudgetEvent({required this.idCategory, required this.type, required this.name, required this.amount});

  @override
  List<Object?> get props => [
    idCategory,
    type,
    name,
    amount,
  ];
}

class GetListBudgetEvent extends BudgetEvent {
  const GetListBudgetEvent();

  @override
  List<Object?> get props => [];
}

class GetListCategoryEvent extends BudgetEvent {
  const GetListCategoryEvent();

  @override
  List<Object?> get props => [];
}