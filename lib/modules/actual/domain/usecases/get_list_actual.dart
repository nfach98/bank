import 'package:bank/modules/actual/domain/entities/actual_entity.dart';
import 'package:bank/modules/actual/domain/repositories/actual_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class GetListActual {
  final ActualRepository _repository;

  GetListActual(this._repository);

  Future<Either<AppError, List<ActualEntity>>> execute() async {
    return _repository.getListActual();
  }
}
