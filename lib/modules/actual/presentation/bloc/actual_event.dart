part of 'actual_bloc.dart';

abstract class ActualEvent extends Equatable {
  const ActualEvent();
}

class GetListPeriodEvent extends ActualEvent {
  const GetListPeriodEvent();

  @override
  List<Object?> get props => [];
}

class ChangeCategoryEvent extends ActualEvent {
  final String id;

  const ChangeCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ChangeCategoryTypeEvent extends ActualEvent {
  final String id;

  const ChangeCategoryTypeEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ChangeDateEvent extends ActualEvent {
  final DateTime date;

  const ChangeDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class CreateActualEvent extends ActualEvent {
  final String idCategory;
  final String type;
  final String name;
  final int amount;
  final String date;

  const CreateActualEvent({required this.idCategory, required this.type, required this.name, required this.amount, required this.date});

  @override
  List<Object?> get props => [
    idCategory,
    type,
    name,
    amount,
    date
  ];
}

class UpdateActualEvent extends ActualEvent {
  final String id;
  final String idCategory;
  final String type;
  final String name;
  final int amount;
  final String date;

  const UpdateActualEvent({required this.id, required this.idCategory, required this.type, required this.name, required this.amount, required this.date});

  @override
  List<Object?> get props => [
    id,
    idCategory,
    type,
    name,
    amount,
    date
  ];
}

class DeleteActualEvent extends ActualEvent {
  final String id;

  const DeleteActualEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetListActualEvent extends ActualEvent {
  const GetListActualEvent();

  @override
  List<Object?> get props => [];
}

class GetListCategoryEvent extends ActualEvent {
  const GetListCategoryEvent();

  @override
  List<Object?> get props => [];
}