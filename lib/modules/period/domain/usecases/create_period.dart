import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class CreatePeriod {
  final PeriodRepository _repository;

  CreatePeriod(this._repository);

  Future<Either<AppError, int>> execute(CreatePeriodParams params) async {
    return _repository.createPeriod(
      dateStart: params.dateStart,
      dateEnd: params.dateEnd,
    );
  }
}

class CreatePeriodParams {
  final String dateStart;
  final String dateEnd;

  CreatePeriodParams({required this.dateStart, required this.dateEnd});
}
