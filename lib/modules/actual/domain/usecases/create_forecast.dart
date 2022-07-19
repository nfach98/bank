import 'package:bank/modules/budget/domain/repositories/budget_repository.dart';
import 'package:bank/modules/forecast/domain/repositories/forecast_repository.dart';
import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class CreateForecast {
  final ForecastRepository _repository;

  CreateForecast(this._repository);

  Future<Either<AppError, int>> execute(CreateForecastParams params) async {
    return _repository.createForecast(
      idCategory: params.idCategory,
      type: params.type,
      name: params.name,
      amount: params.amount,
      date: params.date,
    );
  }
}

class CreateForecastParams {
  final String idCategory;
  final String type;
  final String name;
  final int amount;
  final String date;

  CreateForecastParams({required this.idCategory, required this.type, required this.name, required this.amount, required this.date});
}
