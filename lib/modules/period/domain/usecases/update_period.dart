import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class UpdatePeriod {
  final PeriodRepository _repository;

  UpdatePeriod(this._repository);

  Future<Either<AppError, void>> execute(UpdatePeriodParams params) async {
    return _repository.updatePeriod(
      id: params.id,
      dateStart: params.dateStart,
      dateEnd: params.dateEnd,
    );
  }
}

class UpdatePeriodParams {
  final String id;
  final String dateStart;
  final String dateEnd;

  UpdatePeriodParams({required this.id, required this.dateStart, required this.dateEnd});
}
