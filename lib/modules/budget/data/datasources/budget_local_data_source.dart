import 'package:bank/modules/budget/data/models/budget_model.dart';
import 'package:hive/hive.dart';

abstract class BudgetLocalDataSource {
  Future<int> createBudget({required String idPeriod, required String idCategory, required String name, required int amount});

  Future<List<BudgetModel>> getListBudget({required String idPeriod});
}

class BudgetLocalDataSourceImpl implements BudgetLocalDataSource {
  final boxBudget = Hive.box('budgets');

  BudgetLocalDataSourceImpl();

  @override
  Future<List<BudgetModel>> getListBudget({required String idPeriod}) async {
    List<BudgetModel> list = boxBudget.keys.map((e) {
      final value = boxBudget.get(e);
      return BudgetModel(
        id: value['id'],
        idPeriod: value['id_period'],
        idCategory: value['id_category'],
        name: value['name'],
        amount: value['amount'],
      );
    }).toList();

    return list.where((e) => e.idPeriod == idPeriod).toList();
  }

  @override
  Future<int> createBudget({required String idPeriod, required String idCategory, required String name, required int amount}) async {
    int key = await boxBudget.add(BudgetModel(
      idPeriod: idPeriod,
      idCategory: idCategory,
      name: name,
      amount: amount,
    ).toMap);

    return key;
  }
}
