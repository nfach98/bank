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
