import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';
import '../entities/actual_entity.dart';

abstract class ActualRepository {
  Future<Either<AppError, List<ActualEntity>>> getListActual();

  Future<Either<AppError, int>> createActual(
      {required String idCategory,
      required String type,
      required String name,
      required int amount,
      required String date});

  Future<Either<AppError, void>> updateActual(
      {required String id,
      required String idCategory,
      required String type,
      required String name,
      required int amount,
      required String date});

  Future<Either<AppError, void>> deleteActual({required String id});
}
