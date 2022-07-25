import 'dart:collection';

class ForecastModel {
  final String? id;
  final String? idPeriod;
  final String? idCategory;
  final String? type;
  final String? name;
  final int? amount;

  ForecastModel({this.id, this.idCategory, this.type, this.name, this.amount, this.idPeriod});

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
    ForecastModel(
      id: json['id'],
      idPeriod: json['id_period'],
      idCategory: json['id_category'],
      type: json['type'],
      name: json['name'],
      amount: json['amount'],
    );

  HashMap<String, dynamic> get toMap {
    HashMap<String, dynamic> map = HashMap<String, dynamic>();
    map['id'] = id;
    map['id_period'] = idPeriod;
    map['id_category'] = idCategory;
    map['type'] = type;
    map['name'] = name;
    map['amount'] = amount;
    return map;
  }
}
