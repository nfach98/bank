import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

abstract class BudgetRepository {
  Future<Either<AppError, List<BudgetEntity>>> getListBudget({required String idPeriod});
  Future<Either<AppError, int>> createBudget({required String idPeriod, required String idCategory, required String name, required int amount});
}
