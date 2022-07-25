import 'package:bank/modules/period/data/models/period_model.dart';
import 'package:hive/hive.dart';

abstract class PeriodLocalDataSource {
  Future<int> createPeriod({required String dateStart, required String dateEnd});
  Future<void> updatePeriod({required String id, required String dateStart, required String dateEnd});
  Future<void> deletePeriod({required String id});
  Future<List<PeriodModel>> getListPeriod();
}

class PeriodLocalDataSourceImpl implements PeriodLocalDataSource {
  final boxPeriods = Hive.box('periods');
  PeriodLocalDataSourceImpl();

  @override
  Future<int> createPeriod({required String dateStart, required String dateEnd}) async {
    int key = await boxPeriods.add(PeriodModel(
      dateStart: dateStart,
      dateEnd: dateEnd,
    ).toMap);
    await boxPeriods.put(key, PeriodModel(
      id: key.toString(),
      dateStart: dateStart,
      dateEnd: dateEnd,
    ).toMap);

    return key;
  }

  @override
  Future<List<PeriodModel>> getListPeriod() async {
    List<PeriodModel> list = boxPeriods.keys.map((e) {
      final value = boxPeriods.get(e);
      return PeriodModel(
        id: e.toString(),
        dateEnd: value['date_end'],
        dateStart: value['date_start']
      );
    }).toList();

    return list;
  }

  @override
  Future<void> deletePeriod({required String id}) async {
    await boxPeriods.delete(int.parse(id));
  }

  @override
  Future<void> updatePeriod({required String id, required String dateStart, required String dateEnd}) async {
    await boxPeriods.put(int.parse(id), PeriodModel(
      id: id,
      dateStart: dateStart,
      dateEnd: dateEnd,
    ).toMap);
  }
}
