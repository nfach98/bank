import 'package:bank/modules/forecast/domain/entities/forecast_entity.dart';
import 'package:bank/modules/forecast/domain/repositories/forecast_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class GetListForecast {
  final ForecastRepository _repository;

  GetListForecast(this._repository);

  Future<Either<AppError, List<ForecastEntity>>> execute() async {
    return _repository.getListForecast();
  }
}
