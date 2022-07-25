import 'package:bank/common/errors/app_error.dart';
import 'package:bank/modules/period/data/datasources/period_local_data_source.dart';
import 'package:bank/modules/period/domain/entities/period_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/period_repository.dart';

class PeriodRepositoryImpl implements PeriodRepository {
  final PeriodLocalDataSource _localDataSource;

  PeriodRepositoryImpl(this._localDataSource);

  @override
  Future<Either<AppError, int>> createPeriod({
    required String dateStart,
    required String dateEnd,
  }) async {
    try {
      final result = await _localDataSource.createPeriod(
        dateStart: dateStart,
        dateEnd: dateEnd
      );
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, List<PeriodEntity>>> getListPeriod() async {
    try {
      final result = await _localDataSource.getListPeriod();
      return Right(result.map((e) => PeriodEntity(
        id: e.id,
        dateStart: e.dateStart,
        dateEnd: e.dateEnd,
      )).toList());
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, void>> deletePeriod({required String id}) async {
    try {
      final result = await _localDataSource.deletePeriod(id: id);
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, void>> updatePeriod({required String id, required String dateStart, required String dateEnd}) async {
    try {
      final result = await _localDataSource.updatePeriod(
        id: id,
        dateStart: dateStart,
        dateEnd: dateEnd
      );
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

}
