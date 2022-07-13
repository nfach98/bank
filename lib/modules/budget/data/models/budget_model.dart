import 'dart:collection';

class BudgetModel {
  final String? id;
  final String? idCategory;
  final String? type;
  final String? name;
  final int? amount;

  BudgetModel({this.id, this.idCategory, this.type, this.name, this.amount});

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
    BudgetModel(
      id: json['id'],
      idCategory: json['id_category'],
      type: json['type'],
      name: json['name'],
      amount: json['amount'],
    );

  HashMap<String, dynamic> get toMap {
    HashMap<String, dynamic> map = HashMap<String, dynamic>();
    map['id'] = id;
    map['id_category'] = idCategory;
    map['type'] = type;
    map['name'] = name;
    map['amount'] = amount;
    return map;
  }
}
