import 'package:equatable/equatable.dart';

class BudgetEntity extends Equatable{
  final String? id;
  final String? idCategory;
  final String? type;
  final String? name;
  final int? amount;

  const BudgetEntity({this.id, this.idCategory, this.type, this.name, this.amount});

  @override
  List<Object?> get props => [id, idCategory, type, name, amount];
}
