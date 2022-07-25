import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';
import '../entities/forecast_entity.dart';

abstract class ForecastRepository {
  Future<Either<AppError, List<ForecastEntity>>> getListForecast();
  Future<Either<AppError, int>> createForecast({required String idPeriod, required String idCategory, required String type, required String name, required int amount});
  Future<Either<AppError, void>> updateForecast({required String id, required String idPeriod, required String idCategory, required String type, required String name, required int amount});
  Future<Either<AppError, void>> deleteForecast({required String id});
}
