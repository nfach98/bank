import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class DeletePeriod {
  final PeriodRepository _repository;

  DeletePeriod(this._repository);

  Future<Either<AppError, void>> execute(DeletePeriodParams params) async {
    return _repository.deletePeriod(
      id: params.id
    );
  }
}

class DeletePeriodParams {
  final String id;

  DeletePeriodParams({required this.id});
}
