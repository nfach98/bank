part of 'forecast_bloc.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class ChangeCategoryEvent extends ForecastEvent {
  final String id;

  const ChangeCategoryEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ChangeCategoryTypeEvent extends ForecastEvent {
  final String id;

  const ChangeCategoryTypeEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateForecastEvent extends ForecastEvent {
  final String idCategory;
  final String type;
  final String name;
  final int amount;
  final String date;

  const CreateForecastEvent({required this.idCategory, required this.type, required this.name, required this.amount, required this.date});

  @override
  List<Object?> get props => [
    idCategory,
    type,
    name,
    amount,
    date
  ];
}

class UpdateForecastEvent extends ForecastEvent {
  final String id;
  final String idCategory;
  final String type;
  final String name;
  final int amount;
  final String date;

  const UpdateForecastEvent({required this.id, required this.idCategory, required this.type, required this.name, required this.amount, required this.date});

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

class DeleteForecastEvent extends ForecastEvent {
  final String id;

  const DeleteForecastEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetListForecastEvent extends ForecastEvent {
  const GetListForecastEvent();

  @override
  List<Object?> get props => [];
}

class GetListCategoryEvent extends ForecastEvent {
  const GetListCategoryEvent();

  @override
  List<Object?> get props => [];
}