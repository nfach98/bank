import 'package:bank/modules/main/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/errors/app_error.dart';

abstract class MainRepository {
  Future<Either<AppError, List<CategoryEntity>>> getListCategory();
}
