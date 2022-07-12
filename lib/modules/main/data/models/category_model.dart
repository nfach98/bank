import 'dart:collection';

class CategoryModel {
  final String? id;
  final String? name;
  final String? type;
  final int? idIcon;

  CategoryModel({this.id, this.name, this.type, this.idIcon});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      idIcon: json['id_icon'],
    );

  HashMap<String, dynamic> get toMap {
    HashMap<String, dynamic> map = HashMap<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['id_icon'] = idIcon;
    return map;
  }
}
