import 'package:bank/modules/actual/domain/repositories/actual_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class UpdateActual {
  final ActualRepository _repository;

  UpdateActual(this._repository);

  Future<Either<AppError, void>> execute(UpdateActualParams params) async {
    return _repository.updateActual(
      id: params.id,
      idCategory: params.idCategory,
      type: params.type,
      name: params.name,
      amount: params.amount,
      date: params.date,
    );
  }
}

class UpdateActualParams {
  final String id;
  final String idCategory;
  final String type;
  final String name;
  final int amount;
  final String date;

  UpdateActualParams({required this.id, required this.idCategory, required this.type, required this.name, required this.amount, required this.date});
}
