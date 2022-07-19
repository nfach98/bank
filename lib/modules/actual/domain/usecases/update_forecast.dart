import 'package:bank/modules/forecast/domain/repositories/forecast_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class UpdateForecast {
  final ForecastRepository _repository;

  UpdateForecast(this._repository);

  Future<Either<AppError, void>> execute(UpdateForecastParams params) async {
    return _repository.updateForecast(
      id: params.id,
      idCategory: params.idCategory,
      type: params.type,
      name: params.name,
      amount: params.amount,
      date: params.date,
    );
  }
}

class UpdateForecastParams {
  final String id;
  final String idCategory;
  final String type;
  final String name;
  final int amount;
  final String date;

  UpdateForecastParams({required this.id, required this.idCategory, required this.type, required this.name, required this.amount, required this.date});
}
