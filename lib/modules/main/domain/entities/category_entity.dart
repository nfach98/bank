import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable{
  final String? id;
  final String? name;
  final String? type;

  const CategoryEntity({this.id, this.name, this.type});

  @override
  List<Object?> get props => [id, name, type];
}
