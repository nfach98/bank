import 'package:bank/modules/budget/domain/repositories/budget_repository.dart';
import 'package:bank/modules/period/domain/repositories/period_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class DeleteBudget {
  final BudgetRepository _repository;

  DeleteBudget(this._repository);

  Future<Either<AppError, void>> execute(DeleteBudgetParams params) async {
    return _repository.deleteBudget(
      id: params.id
    );
  }
}

class DeleteBudgetParams {
  final String id;

  DeleteBudgetParams({required this.id});
}
