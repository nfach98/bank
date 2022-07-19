import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:bank/modules/forecast/domain/entities/forecast_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

abstract class ForecastRepository {
  Future<Either<AppError, List<ForecastEntity>>> getListForecast();
  Future<Either<AppError, int>> createForecast({required String idCategory, required String type, required String name, required int amount, required String date});
  Future<Either<AppError, void>> updateForecast({required String id, required String idCategory, required String type, required String name, required int amount, required String date});
  Future<Either<AppError, void>> deleteForecast({required String id});
}
