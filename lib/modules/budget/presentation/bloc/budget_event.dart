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

class ChangeCategoryEvent extends BudgetEvent {
  final String id;

  const ChangeCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ChangeCategoryTypeEvent extends BudgetEvent {
  final String id;

  const ChangeCategoryTypeEvent(this.id);

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

class UpdateBudgetEvent extends BudgetEvent {
  final String id;
  final String idCategory;
  final String type;
  final String name;
  final int amount;

  const UpdateBudgetEvent({required this.id, required this.idCategory, required this.type, required this.name, required this.amount});

  @override
  List<Object?> get props => [
    id,
    idCategory,
    type,
    name,
    amount,
  ];
}

class DeleteBudgetEvent extends BudgetEvent {
  final String id;

  const DeleteBudgetEvent({required this.id});

  @override
  List<Object?> get props => [id];
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