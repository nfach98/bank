import 'package:bank/modules/actual/data/models/actual_model.dart';
import 'package:hive/hive.dart';

abstract class ActualLocalDataSource {
  Future<int> createActual({required String idCategory, required String type, required String name, required int amount, required String date});

  Future<void> updateActual({required String id, required String idCategory, required String type, required String name, required int amount, required String date});

  Future<void> deleteActual({required String id});

  Future<List<ActualModel>> getListActual();
}

class ActualLocalDataSourceImpl implements ActualLocalDataSource {
  final boxForecast = Hive.box('actuals');

  ActualLocalDataSourceImpl();

  @override
  Future<List<ActualModel>> getListActual() async {
    List<ActualModel> list = boxForecast.keys.map((e) {
      final value = boxForecast.get(e);
      return ActualModel(
        id: value['id'],
        idCategory: value['id_category'],
        type: value['type'],
        name: value['name'],
        amount: value['amount'],
        date: value['date'],
      );
    }).toList();

    return list;
  }

  @override
  Future<int> createActual({required String idCategory, required String type, required String name, required int amount, required String date}) async {
    int key = await boxForecast.add(ActualModel(
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
      date: date,
    ).toMap);
    await boxForecast.put(key, ActualModel(
      id: key.toString(),
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
      date: date,
    ).toMap);

    return key;
  }

  @override
  Future<void> updateActual({required String id, required String idCategory, required String type, required String name, required int amount, required String date}) async {
    await boxForecast.put(int.parse(id), ActualModel(
      id: id,
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
      date: date,
    ).toMap);
  }

  @override
  Future<void> deleteActual({required String id}) async {
    await boxForecast.delete(int.parse(id));
  }
}
