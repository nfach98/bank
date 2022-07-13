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
      boxCategories.add(CategoryModel(name: 'Food', type: '1', idIcon: 0xf2e7).toMap);
      boxCategories.add(CategoryModel(name: 'Utility', type: '1', idIcon: 0xf571).toMap);
      boxCategories.add(CategoryModel(name: 'Health', type: '1', idIcon: 0xf469).toMap);
      boxCategories.add(CategoryModel(name: 'Housing', type: '1', idIcon: 0xf015).toMap);
      boxCategories.add(CategoryModel(name: 'Transportation', type: '1', idIcon: 0xf1b9).toMap);
      boxCategories.add(CategoryModel(name: 'Tax', type: '1', idIcon: 0xf571).toMap);
      boxCategories.add(CategoryModel(name: 'Social', type: '1', idIcon: 0xf0c0).toMap);
      boxCategories.add(CategoryModel(name: 'Education', type: '1', idIcon: 0xf19d).toMap);
      boxCategories.add(CategoryModel(name: 'Shopping', type: '1', idIcon: 0xf290).toMap);
      boxCategories.add(CategoryModel(name: 'Internet', type: '1', idIcon: 0xf1eb).toMap);
      boxCategories.add(CategoryModel(name: 'Entertainment', type: '1', idIcon: 0xf630).toMap);
      boxCategories.add(CategoryModel(name: 'Personal', type: '1', idIcon: 0xf007).toMap);
      boxCategories.add(CategoryModel(name: 'Other', type: '1', idIcon: 0xf141).toMap);

      boxCategories.add(CategoryModel(name: 'Salary', type: '2', idIcon: 0xf81d).toMap);
      boxCategories.add(CategoryModel(name: 'Bonus', type: '2', idIcon: 0xf4b9).toMap);
      boxCategories.add(CategoryModel(name: 'Reimbursement', type: '2', idIcon: 0xf3d1).toMap);
      boxCategories.add(CategoryModel(name: 'Prize', type: '2', idIcon: 0xf06b).toMap);
      boxCategories.add(CategoryModel(name: 'Sale', type: '2', idIcon: 0xf02b).toMap);
      boxCategories.add(CategoryModel(name: 'Other', type: '2', idIcon: 0xf141).toMap);

      boxCategories.add(CategoryModel(name: 'Saving', type: '3', idIcon: 0xf4d3).toMap);
      boxCategories.add(CategoryModel(name: 'Investment', type: '3', idIcon: 0xf4c0).toMap);
    });
  }

  @override
  Future<List<CategoryModel>> getListCategory() async {
    List<CategoryModel> list = boxCategories.keys.map((e) {
      final value = boxCategories.get(e);
      return CategoryModel(
        id: e.toString(),
        name: value['name'],
        type: value['type'],
        idIcon: value['id_icon']
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
