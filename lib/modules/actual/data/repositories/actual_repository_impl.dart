import 'package:bank/common/errors/app_error.dart';
import 'package:bank/modules/actual/domain/entities/actual_entity.dart';
import 'package:bank/modules/forecast/domain/entities/forecast_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/actual_repository.dart';
import '../datasources/actual_local_data_source.dart';

class ActualRepositoryImpl implements ActualRepository {
  final ActualLocalDataSource _localDataSource;

  ActualRepositoryImpl(this._localDataSource);

  @override
  Future<Either<AppError, List<ActualEntity>>> getListActual() async {
    try {
      final result = await _localDataSource.getListActual();
      return Right(result.map((e) => ActualEntity(
        id: e.id,
        idCategory: e.idCategory,
        type: e.type,
        name: e.name,
        amount: e.amount,
        date: e.date,
      )).toList());
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, int>> createActual({
    required String idCategory,
    required String type,
    required String name,
    required int amount,
    required String date,
  }) async {
    try {
      final result = await _localDataSource.createActual(
        idCategory: idCategory,
        type: type,
        name: name,
        amount: amount,
        date: date,
      );
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, void>> updateActual({required String id, required String idCategory, required String type, required String name, required int amount, required String date}) async {
    try {
      final result = await _localDataSource.updateActual(
        id: id,
        idCategory: idCategory,
        type: type,
        name: name,
        amount: amount,
        date: date,
      );
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, void>> deleteActual({required String id}) async {
    try {
      final result = await _localDataSource.deleteActual(id: id);
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

}
