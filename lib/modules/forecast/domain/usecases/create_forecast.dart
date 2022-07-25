import 'package:bank/modules/forecast/domain/repositories/forecast_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class CreateForecast {
  final ForecastRepository _repository;

  CreateForecast(this._repository);

  Future<Either<AppError, int>> execute(CreateForecastParams params) async {
    return _repository.createForecast(
      idPeriod: params.idPeriod,
      idCategory: params.idCategory,
      type: params.type,
      name: params.name,
      amount: params.amount,
    );
  }
}

class CreateForecastParams {
  final String idPeriod;
  final String idCategory;
  final String type;
  final String name;
  final int amount;

  CreateForecastParams({required this.idPeriod, required this.idCategory, required this.type, required this.name, required this.amount});
}
