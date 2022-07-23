import 'package:equatable/equatable.dart';

class ActualEntity extends Equatable{
  final String? id;
  final String? idCategory;
  final String? type;
  final String? name;
  final int? amount;
  final int? color;
  final String? date;

  const ActualEntity({this.id, this.idCategory, this.type, this.name, this.amount, this.color, this.date});

  @override
  List<Object?> get props => [id, idCategory, type, name, amount, date];
}
