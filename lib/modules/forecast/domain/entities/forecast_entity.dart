import 'package:equatable/equatable.dart';

class ForecastEntity extends Equatable{
  final String? id;
  final String? idPeriod;
  final String? idCategory;
  final String? type;
  final String? name;
  final int? amount;
  final int? color;

  const ForecastEntity({this.idPeriod, this.id, this.idCategory, this.type, this.name, this.amount, this.color});

  @override
  List<Object?> get props => [id, idPeriod, idCategory, type, name, amount, color];
}
