import 'package:bank/modules/budget/domain/repositories/budget_repository.dart';
import 'package:bank/modules/forecast/domain/repositories/forecast_repository.dart';
import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class UpdateForecast {
  final ForecastRepository _repository;

  UpdateForecast(this._repository);

  Future<Either<AppError, void>> execute(UpdateForecastParams params) async {
    return _repository.updateForecast(
      id: params.id,
      idPeriod: params.idPeriod,
      idCategory: params.idCategory,
      type: params.type,
      name: params.name,
      amount: params.amount,
    );
  }
}

class UpdateForecastParams {
  final String id;
  final String idPeriod;
  final String idCategory;
  final String type;
  final String name;
  final int amount;

  UpdateForecastParams({required this.id, required this.idPeriod, required this.idCategory, required this.type, required this.name, required this.amount});
}
