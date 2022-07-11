import 'package:equatable/equatable.dart';

class PeriodEntity extends Equatable {
  final String? id;
  final String? dateStart;
  final String? dateEnd;

  const PeriodEntity({this.id, this.dateStart, this.dateEnd});

  @override
  List<Object?> get props => [id, dateStart, dateEnd];
}
