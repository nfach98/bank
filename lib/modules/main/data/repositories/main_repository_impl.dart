import 'package:bank/common/errors/app_error.dart';
import 'package:bank/modules/main/domain/entities/category_entity.dart';
import 'package:bank/modules/period/data/datasources/period_local_data_source.dart';
import 'package:bank/modules/period/data/models/period_model.dart';
import 'package:bank/modules/period/domain/entities/period_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/main_repository.dart';
import '../datasources/main_local_data_source.dart';

class MainRepositoryImpl implements MainRepository {
  final MainLocalDataSource _localDataSource;

  MainRepositoryImpl(this._localDataSource);

  @override
  Future<Either<AppError, List<CategoryEntity>>> getListCategory() async {
    try {
      final result = await _localDataSource.getListCategory();
      return Right(result.map((e) => CategoryEntity(
        id: e.id,
        name: e.name,
        type: e.type,
      )).toList());
    } on AppError catch (e) {
      return Left(e);
    }
  }

}
