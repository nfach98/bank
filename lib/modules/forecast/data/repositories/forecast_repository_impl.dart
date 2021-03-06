import 'package:bank/common/errors/app_error.dart';
import 'package:bank/modules/forecast/domain/entities/forecast_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/forecast_repository.dart';
import '../datasources/forecast_local_data_source.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastLocalDataSource _localDataSource;

  ForecastRepositoryImpl(this._localDataSource);

  @override
  Future<Either<AppError, List<ForecastEntity>>> getListForecast() async {
    try {
      final result = await _localDataSource.getListForecast();
      return Right(result.map((e) => ForecastEntity(
        id: e.id,
        idPeriod: e.idPeriod,
        idCategory: e.idCategory,
        type: e.type,
        name: e.name,
        amount: e.amount,
      )).toList());
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, int>> createForecast({
    required String idPeriod,
    required String idCategory,
    required String type,
    required String name,
    required int amount,
  }) async {
    try {
      final result = await _localDataSource.createForecast(
        idPeriod: idPeriod,
        idCategory: idCategory,
        type: type,
        name: name,
        amount: amount
      );
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, void>> updateForecast({required String id, required String idPeriod, required String idCategory, required String type, required String name, required int amount}) async {
    try {
      final result = await _localDataSource.updateForecast(
        id: id,
        idPeriod: idPeriod,
        idCategory: idCategory,
        type: type,
        name: name,
        amount: amount
      );
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, void>> deleteForecast({required String id}) async {
    try {
      final result = await _localDataSource.deleteForecast(id: id);
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

}
