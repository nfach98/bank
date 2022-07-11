import 'package:equatable/equatable.dart';

class BudgetEntity extends Equatable{
  final String? id;
  final String? idPeriod;
  final String? idCategory;
  final String? name;
  final int? amount;

  const BudgetEntity({this.id, this.idPeriod, this.idCategory, this.name, this.amount});

  @override
  List<Object?> get props => [id, idPeriod, idCategory, name, amount];
}
