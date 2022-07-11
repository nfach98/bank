import 'package:bank/modules/budget/domain/repositories/budget_repository.dart';
import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class CreateBudget {
  final BudgetRepository _repository;

  CreateBudget(this._repository);

  Future<Either<AppError, int>> execute(CreateBudgetParams params) async {
    return _repository.createBudget(
      idPeriod: params.idPeriod,
      idCategory: params.idCategory,
      name: params.name,
      amount: params.amount,
    );
  }
}

class CreateBudgetParams {
  final String idPeriod;
  final String idCategory;
  final String name;
  final int amount;

  CreateBudgetParams({required this.idPeriod, required this.idCategory, required this.name, required this.amount});
}
