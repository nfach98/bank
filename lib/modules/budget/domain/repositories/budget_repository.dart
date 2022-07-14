import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

abstract class BudgetRepository {
  Future<Either<AppError, List<BudgetEntity>>> getListBudget();
  Future<Either<AppError, int>> createBudget({required String idCategory, required String type, required String name, required int amount});
  Future<Either<AppError, void>> updateBudget({required String id, required String idCategory, required String type, required String name, required int amount});
  Future<Either<AppError, void>> deleteBudget({required String id});
}
