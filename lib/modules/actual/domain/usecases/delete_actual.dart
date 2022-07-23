import 'package:bank/modules/actual/domain/repositories/actual_repository.dart';
import 'package:bank/modules/budget/domain/repositories/budget_repository.dart';
import 'package:bank/modules/forecast/domain/repositories/forecast_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class DeleteActual {
  final ActualRepository _repository;

  DeleteActual(this._repository);

  Future<Either<AppError, void>> execute(DeleteActualParams params) async {
    return _repository.deleteActual(
      id: params.id
    );
  }
}

class DeleteActualParams {
  final String id;

  DeleteActualParams({required this.id});
}
