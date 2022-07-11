import 'package:bank/modules/period/data/models/period_model.dart';
import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';
import '../entities/period_entity.dart';

class GetListPeriod {
  final PeriodRepository _repository;

  GetListPeriod(this._repository);

  Future<Either<AppError, List<PeriodEntity>>> execute() async {
    return _repository.getListPeriod();
  }
}
