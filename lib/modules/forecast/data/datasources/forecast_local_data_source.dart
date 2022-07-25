import 'dart:developer';

import 'package:bank/modules/budget/data/models/budget_model.dart';
import 'package:bank/modules/forecast/data/models/forecast_model.dart';
import 'package:hive/hive.dart';

abstract class ForecastLocalDataSource {
  Future<int> createForecast({required String idPeriod, required String idCategory, required String type, required String name, required int amount});

  Future<void> updateForecast({required String id, required String idPeriod, required String idCategory, required String type, required String name, required int amount});

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
        idPeriod: value['id_period'],
        idCategory: value['id_category'],
        type: value['type'],
        name: value['name'],
        amount: value['amount'],
      );
    }).toList();

    return list;
  }

  @override
  Future<int> createForecast({required String idPeriod, required String idCategory, required String type, required String name, required int amount}) async {
    int key = await boxForecast.add(ForecastModel(
      idCategory: idCategory,
      idPeriod: idPeriod,
      type: type,
      name: name,
      amount: amount,
    ).toMap);
    await boxForecast.put(key, ForecastModel(
      id: key.toString(),
      idPeriod: idPeriod,
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
    ).toMap);

    return key;
  }

  @override
  Future<void> updateForecast({required String id, required String idPeriod, required String idCategory, required String type, required String name, required int amount}) async {
    await boxForecast.put(int.parse(id), ForecastModel(
      id: id,
      idPeriod: idPeriod,
      idCategory: idCategory,
      type: type,
      name: name,
      amount: amount,
    ).toMap);
  }

  @override
  Future<void> deleteForecast({required String id}) async {
    await boxForecast.delete(int.parse(id));
  }
}
