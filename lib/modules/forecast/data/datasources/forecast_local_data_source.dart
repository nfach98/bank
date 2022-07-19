import 'dart:developer';

import 'package:bank/modules/budget/data/models/budget_model.dart';
import 'package:bank/modules/forecast/data/models/forecast_model.dart';
import 'package:hive/hive.dart';

abstract class ForecastLocalDataSource {
  Future<int> createForecast({required String idCategory, required String type, required String name, required int amount, required String date});

  Future<void> updateForecast({required String id, required String idCategory, required String type, required String name, required int amount, required String date});

  Future<void> deleteForecast({required String id});

  Future<List<ForecastModel>> getListForecast();
}

class ForecastLocalDataSourceImpl implements ForecastLocalDataSource {
  final boxForecast = Hive.box('forecasts');

  ForecastLocalDataSourceImpl();

  @override
  Future<List<ForecastModel>> getListForecast() async {
    List<ForecastModel> list = boxForecast.keys.map((e) {
      final value = boxForecast.get(e);
      return ForecastModel(
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
  Future<int> createForecast({required String idCategory, required String type, required String name, required int amount, required String date}) async {
    int key = await boxForecast.add(ForecastModel(
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
      date: date,
    ).toMap);
    await boxForecast.put(key, ForecastModel(
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
  Future<void> updateForecast({required String id, required String idCategory, required String type, required String name, required int amount, required String date}) async {
    await boxForecast.put(int.parse(id), ForecastModel(
      id: id,
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
      date: date,
    ).toMap);
  }

  @override
  Future<void> deleteForecast({required String id}) async {
    await boxForecast.delete(int.parse(id));
  }
}
