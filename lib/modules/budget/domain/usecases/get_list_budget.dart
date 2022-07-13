import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:bank/modules/budget/domain/repositories/budget_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class GetListBudget {
  final BudgetRepository _repository;

  GetListBudget(this._repository);

  Future<Either<AppError, List<BudgetEntity>>> execute() async {
    return _repository.getListBudget();
  }
}
