import 'package:equatable/equatable.dart';

class ForecastEntity extends Equatable{
  final String? id;
  final String? idCategory;
  final String? type;
  final String? name;
  final int? amount;
  final int? color;
  final String? date;

  const ForecastEntity({this.id, this.idCategory, this.type, this.name, this.amount, this.color, this.date});

  @override
  List<Object?> get props => [id, idCategory, type, name, amount, date];
}
