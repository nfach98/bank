import 'package:bank/common/errors/app_error.dart';
import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/budget_repository.dart';
import '../datasources/budget_local_data_source.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetLocalDataSource _localDataSource;

  BudgetRepositoryImpl(this._localDataSource);

  @override
  Future<Either<AppError, List<BudgetEntity>>> getListBudget() async {
    try {
      final result = await _localDataSource.getListBudget();
      return Right(result.map((e) => BudgetEntity(
        id: e.id,
        idCategory: e.idCategory,
        type: e.type,
        name: e.name,
        amount: e.amount,
      )).toList());
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, int>> createBudget({
    required String idCategory,
    required String type,
    required String name,
    required int amount,
  }) async {
    try {
      final result = await _localDataSource.createBudget(
        idCategory: idCategory,
        type: type,
        name: name,
        amount: amount
      );
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, void>> updateBudget({required String id, required String idCategory, required String type, required String name, required int amount}) async {
    try {
      final result = await _localDataSource.updateBudget(
        id: id,
        idCategory: idCategory,
        type: type,
        name: name,
        amount: amount
      );
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppError, void>> deleteBudget({required String id}) async {
    try {
      final result = await _localDataSource.deleteBudget(id: id);
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }

}
