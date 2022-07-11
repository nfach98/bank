import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';
import '../../data/models/period_model.dart';
import '../entities/period_entity.dart';

abstract class PeriodRepository {
  Future<Either<AppError, int>> createPeriod({required String dateStart, required String dateEnd});
  Future<Either<AppError, List<PeriodEntity>>> getListPeriod();
}
