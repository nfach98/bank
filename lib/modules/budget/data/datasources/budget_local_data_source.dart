import 'dart:developer';

import 'package:bank/modules/budget/data/models/budget_model.dart';
import 'package:hive/hive.dart';

abstract class BudgetLocalDataSource {
  Future<int> createBudget({required String idCategory, required String type, required String name, required int amount});

  Future<void> updateBudget({required String id, required String idCategory, required String type, required String name, required int amount});

  Future<void> deleteBudget({required String id});

  Future<List<BudgetModel>> getListBudget();
}

class BudgetLocalDataSourceImpl implements BudgetLocalDataSource {
  final boxBudget = Hive.box('budgets');

  BudgetLocalDataSourceImpl();

  @override
  Future<List<BudgetModel>> getListBudget() async {
    List<BudgetModel> list = boxBudget.keys.map((e) {
      final value = boxBudget.get(e);
      return BudgetModel(
        id: value['id'],
        idCategory: value['id_category'],
        type: value['type'],
        name: value['name'],
        amount: value['amount'],
      );
    }).toList();

    return list;
  }

  @override
  Future<int> createBudget({required String idCategory, required String type, required String name, required int amount}) async {
    int key = await boxBudget.add(BudgetModel(
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
    ).toMap);
    await boxBudget.put(key, BudgetModel(
      id: key.toString(),
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
    ).toMap);

    return key;
  }

  @override
  Future<void> updateBudget({required String id, required String idCategory, required String type, required String name, required int amount}) async {
    await boxBudget.put(int.parse(id), BudgetModel(
      id: id,
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
    ).toMap);
  }

  @override
  Future<void> deleteBudget({required String id}) async {
    await boxBudget.delete(int.parse(id));
  }
}
