import 'dart:collection';

class PeriodModel {
  final String? id;
  final String? dateStart;
  final String? dateEnd;

  PeriodModel({this.id, this.dateStart, this.dateEnd});

  factory PeriodModel.fromJson(Map<String, dynamic> json) =>
    PeriodModel(
      id: json['id'],
      dateStart: json['date_start'],
      dateEnd: json['date_end'],
    );

  HashMap<String, dynamic> get toMap {
    HashMap<String, dynamic> map = HashMap<String, dynamic>();
    map['id'] = id;
    map['date_start'] = dateStart;
    map['date_end'] = dateEnd;
    return map;
  }
}
