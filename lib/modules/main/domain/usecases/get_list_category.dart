import 'package:bank/modules/main/domain/entities/category_entity.dart';
import 'package:bank/modules/main/domain/repositories/main_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

class GetListCategory {
  final MainRepository _repository;

  GetListCategory(this._repository);

  Future<Either<AppError, List<CategoryEntity>>> execute() async {
    return _repository.getListCategory();
  }
}
