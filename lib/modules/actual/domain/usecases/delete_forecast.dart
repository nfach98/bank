import 'package:bank/modules/budget/domain/repositories/budget_repository.dart';
import 'package:bank/modules/forecast/domain/repositories/forecast_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class DeleteForecast {
  final ForecastRepository _repository;

  DeleteForecast(this._repository);

  Future<Either<AppError, void>> execute(DeleteForecastParams params) async {
    return _repository.deleteForecast(
      id: params.id
    );
  }
}

class DeleteForecastParams {
  final String id;

  DeleteForecastParams({required this.id});
}
