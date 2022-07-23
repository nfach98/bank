import 'package:bank/modules/actual/domain/repositories/actual_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class CreateActual {
  final ActualRepository _repository;

  CreateActual(this._repository);

  Future<Either<AppError, int>> execute(CreateActualParams params) async {
    return _repository.createActual(
      idCategory: params.idCategory,
      type: params.type,
      name: params.name,
      amount: params.amount,
      date: params.date,
    );
  }
}

class CreateActualParams {
  final String idCategory;
  final String type;
  final String name;
  final int amount;
  final String date;

  CreateActualParams(
      {required this.idCategory,
      required this.type,
      required this.name,
      required this.amount,
      required this.date});
}
