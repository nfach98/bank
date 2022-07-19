import 'dart:collection';

class ForecastModel {
  final String? id;
  final String? idCategory;
  final String? type;
  final String? name;
  final int? amount;
  final String? date;

  ForecastModel({this.id, this.idCategory, this.type, this.name, this.amount, this.date});

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
    ForecastModel(
      id: json['id'],
      idCategory: json['id_category'],
      type: json['type'],
      name: json['name'],
      amount: json['amount'],
      date: json['date'],
    );

  HashMap<String, dynamic> get toMap {
    HashMap<String, dynamic> map = HashMap<String, dynamic>();
    map['id'] = id;
    map['id_category'] = idCategory;
    map['type'] = type;
    map['name'] = name;
    map['amount'] = amount;
    map['date'] = date;
    return map;
  }
}
