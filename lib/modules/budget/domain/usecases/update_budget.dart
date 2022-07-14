import 'package:bank/modules/budget/domain/repositories/budget_repository.dart';
import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class UpdateBudget {
  final BudgetRepository _repository;

  UpdateBudget(this._repository);

  Future<Either<AppError, void>> execute(UpdateBudgetParams params) async {
    return _repository.updateBudget(
      id: params.id,
      idCategory: params.idCategory,
      type: params.type,
      name: params.name,
      amount: params.amount,
    );
  }
}

class UpdateBudgetParams {
  final String id;
  final String idCategory;
  final String type;
  final String name;
  final int amount;

  UpdateBudgetParams({required this.id, required this.idCategory, required this.type, required this.name, required this.amount});
}
