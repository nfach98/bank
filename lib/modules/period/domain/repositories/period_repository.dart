import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';
import '../entities/period_entity.dart';

abstract class PeriodRepository {
  Future<Either<AppError, int>> createPeriod({required String dateStart, required String dateEnd});
  Future<Either<AppError, void>> updatePeriod({required String id, required String dateStart, required String dateEnd});
  Future<Either<AppError, void>> deletePeriod({required String id});
  Future<Either<AppError, List<PeriodEntity>>> getListPeriod();
}
