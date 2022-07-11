import 'dart:convert';
import 'package:bank/modules/main/data/models/category_model.dart';
import 'package:bank/modules/period/data/models/period_model.dart';
import 'package:hive/hive.dart';

abstract class MainLocalDataSource {
  Future<int> createCategory({required String name, required String type});

  Future<List<CategoryModel>> getListCategory();
}

class MainLocalDataSourceImpl implements MainLocalDataSource {
  final boxCategories = Hive.box('categories');

  MainLocalDataSourceImpl() {
    boxCategories.clear().then((value) {
      boxCategories.add(CategoryModel(name: 'Food', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Utility', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Health', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Housing', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Transportation', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Tax', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Social', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Education', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Shopping', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Internet', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Entertainment', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Personal', type: '1').toMap);
      boxCategories.add(CategoryModel(name: 'Other', type: '1').toMap);

      boxCategories.add(CategoryModel(name: 'Salary', type: '2').toMap);
      boxCategories.add(CategoryModel(name: 'Bonus', type: '2').toMap);
      boxCategories.add(CategoryModel(name: 'Reimbursement', type: '2').toMap);
      boxCategories.add(CategoryModel(name: 'Prize', type: '2').toMap);
      boxCategories.add(CategoryModel(name: 'Sale', type: '2').toMap);
      boxCategories.add(CategoryModel(name: 'Other', type: '2').toMap);

      boxCategories.add(CategoryModel(name: 'Saving', type: '3').toMap);
      boxCategories.add(CategoryModel(name: 'Investment', type: '3').toMap);
    });
  }

  @override
  Future<List<CategoryModel>> getListCategory() async {
    List<CategoryModel> list = boxCategories.keys.map((e) {
      final value = boxCategories.get(e);
      return CategoryModel(
        id: e.toString(),
        name: value['name'],
        type: value['type']
      );
    }).toList();

    return list;
  }

  @override
  Future<int> createCategory({required String name, required String type}) async {
    int key = await boxCategories.add(CategoryModel(
      name: name,
      type: type
    ).toMap);

    return key;
  }
}
