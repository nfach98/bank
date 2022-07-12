import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable{
  final String? id;
  final String? name;
  final String? type;
  final int? idIcon;

  const CategoryEntity({this.id, this.name, this.type, this.idIcon,});

  @override
  List<Object?> get props => [id, name, type, idIcon];
}
