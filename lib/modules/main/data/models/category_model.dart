import 'dart:collection';

class CategoryModel {
  final String? id;
  final String? name;
  final String? type;

  CategoryModel({this.id, this.name, this.type});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );

  HashMap<String, dynamic> get toMap {
    HashMap<String, dynamic> map = HashMap<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    return map;
  }
}
