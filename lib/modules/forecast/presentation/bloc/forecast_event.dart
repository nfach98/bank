part of 'forecast_bloc.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class GetListPeriodEvent extends ForecastEvent {
  const GetListPeriodEvent();

  @override
  List<Object?> get props => [];
}

class ChangeDropdownPeriodEvent extends ForecastEvent {
  final String id;

  const ChangeDropdownPeriodEvent(this.id);

  @override
  List<Object?> get props => [id];
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
  final String idPeriod;
  final String idCategory;
  final String type;
  final String name;
  final int amount;

  const CreateForecastEvent({required this.idPeriod, required this.idCategory, required this.type, required this.name, required this.amount});

  @override
  List<Object?> get props => [
    idPeriod,
    idCategory,
    type,
    name,
    amount,
  ];
}

class UpdateForecastEvent extends ForecastEvent {
  final String id;
  final String idPeriod;
  final String idCategory;
  final String type;
  final String name;
  final int amount;

  const UpdateForecastEvent({required this.id, required this.idPeriod, required this.idCategory, required this.type, required this.name, required this.amount});

  @override
  List<Object?> get props => [
    id,
    idPeriod,
    idCategory,
    type,
    name,
    amount,
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