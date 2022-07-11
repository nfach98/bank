import 'package:bank/modules/period/data/models/period_model.dart';
import 'package:hive/hive.dart';

abstract class PeriodLocalDataSource {
  Future<int> createPeriod({required String dateStart, required String dateEnd});

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
}
