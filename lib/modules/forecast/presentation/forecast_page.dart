import 'dart:math';

import 'package:bank/common/constants/route_constants.dart';
import 'package:bank/common/utils/currency_formatter.dart';
import 'package:bank/common/utils/extensions.dart';
import 'package:bank/modules/forecast/domain/entities/forecast_entity.dart';
import 'package:bank/modules/forecast/presentation/bloc/forecast_bloc.dart';
import 'package:bank/modules/forecast/presentation/widgets/card_list_forecast.dart';
import 'package:bank/modules/main/domain/entities/category_entity.dart';
import 'package:bank/modules/period/domain/entities/period_entity.dart';
import 'package:bank/modules/period/presentation/bloc/period_bloc.dart' as p;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';

import '../../../common/config/themes.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late ForecastBloc _forecastBloc;
  late p.PeriodBloc _periodBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _forecastBloc = BlocProvider.of<ForecastBloc>(context);
      _periodBloc = BlocProvider.of<p.PeriodBloc>(context);

      _forecastBloc.add(const GetListForecastEvent());
      _forecastBloc.add(const GetListCategoryEvent());
      _forecastBloc.add(const GetListPeriodEvent());
      _forecastBloc.add(const ChangeCategoryTypeEvent('1'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastBloc, ForecastState>(
      builder: (_, state) {
        List<CategoryEntity>? listCategory = state.listCategory;
        List<String>? listCategoryTypes = listCategory?.map(
          (e) => e.type ?? ''
        ).toSet().toList();

        List<ForecastEntity>? listForecast = state.listForecast;
        List<ForecastEntity>? listAllocation = listForecast?.where(
          (e) => e.type == '1' || e.type == '3'
        ).toList();
        List<ForecastEntity>? listIncome = listForecast?.where(
          (e) => e.type == '2'
        ).toList();

        Map? mapGroupedAllocation;
        int totalAllocation = 0;

        if (listAllocation != null && listAllocation.isNotEmpty) {
          mapGroupedAllocation = groupBy(listAllocation, (e) => (e as ForecastEntity).idCategory);
          totalAllocation = listAllocation.map((e) => e.amount ?? 0).reduce(
          (value, element) => value + element);
        }

        List<ForecastEntity?> listAllocationGrouped = [];
        mapGroupedAllocation?.values.toList().forEach((e) {
          listAllocationGrouped.add(ForecastEntity(
            amount: (e as List<ForecastEntity>).map((e) => e.amount)
              .reduce((value, element) => (value ?? 0) + (element ?? 0)),
            idCategory: e[0].idCategory,
            color: (Random().nextDouble() * 0xFFFFFF).toInt()
          ));
        });
        listAllocationGrouped.sort((a, b) =>
            ((b?.amount ?? 0) / totalAllocation * 100).compareTo(
              (a?.amount ?? 0) / totalAllocation * 100)
        );

        int remaining = 0;
        int income = listIncome != null && listIncome.isNotEmpty
          ? listIncome.map((e) => e.amount ?? 0).reduce((p, n) => p + n)
          : 0;
        int outcome = listAllocation != null && listAllocation.isNotEmpty
          ? listAllocation.map((e) => e.amount ?? 0).reduce((p, n) => p + n)
          : 0;
        remaining = income - outcome;

        List<PeriodEntity>? listPeriod = state.listPeriod;

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: BankTheme.colors.green,
            title: Text(
              'Forecast',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: state.selectedPeriod,
                        onChanged: (value) {
                          _periodBloc.add(p.ChangePeriodEvent(id: value ?? ''));
                        },
                        items: listPeriod?.map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            '${DateFormat('dd MMM yyyy').format(DateTime.parse(e.dateStart ?? ''))} '
                            '- ${DateFormat('dd MMM yyyy').format(DateTime.parse(e.dateEnd ?? ''))}',
                            style: Theme.of(context).textTheme.headline3,
                          )
                        )).toList() ?? [],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listCategoryTypes?.length ?? 0,
                  itemBuilder: (_, index) {
                    List<ForecastEntity>? list =
                    listForecast?.where((e) => e.type == listCategoryTypes?[index]).toList();

                    if (list != null && list.isNotEmpty) {
                      return CardListForecast(
                        listForecast: list,
                        categoryType: listCategoryTypes?[index] ?? '',
                      );
                    }

                    return Container();
                  },
                  separatorBuilder: (_, index) => SizedBox(height: 12.h),
                ),
                SizedBox(height: 12.h),
                if (mapGroupedAllocation != null && mapGroupedAllocation.isNotEmpty) Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly allocation',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Container(
                          height: 1.h,
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          color: BankTheme.colors.grey.withOpacity(0.5),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: context.screenWidth / 8,
                              sections: listAllocationGrouped.map((e) {
                                // int value = (e.value as List<BudgetEntity>)
                                //     .map((e) => e.amount ?? 0)
                                //     .reduce((value, element) => value + element);
                                CategoryEntity? category = listCategory?.where(
                                    (c) => c.id == e?.idCategory
                                ).toList()[0];
                                double percentage = (e?.amount ?? 0) / totalAllocation * 100;

                                return PieChartSectionData(
                                  color: Color(e?.color ?? 0xFFFFF).withOpacity(1.0),
                                  value: percentage,
                                  title: percentage > 15
                                    ? '${category?.name}\n'
                                      '(${percentage.toStringAsFixed(2)}.%)'
                                    : '',
                                  radius: context.screenWidth / 5,
                                  titleStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffffffff),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        if (remaining != 0) Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Remaining budget'
                              ),
                            ),
                            Text(
                              remaining.toSeparatedDecimal(),
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: remaining < 0
                                  ? Colors.red
                                  : BankTheme.colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listAllocationGrouped.length,
                          itemBuilder: (_, index) {
                            ForecastEntity? budget = listAllocationGrouped[index];
                            CategoryEntity? category = listCategory?.firstWhere(
                              (c) => c.id == budget?.idCategory
                            );
                            double percentage =
                                (budget?.amount ?? 0) / totalAllocation * 100;

                            return Row(
                              children: [
                                Container(
                                  width: 12.r,
                                  height: 12.r,
                                  margin: const EdgeInsets.only(right: 8).r,
                                  color: Color(budget?.color ?? 0xFFFFF).withOpacity(1.0),
                                ),
                                Expanded(
                                  child: Text(
                                    category?.name ?? ''
                                  ),
                                ),
                                Text(
                                  '${percentage.toStringAsFixed(2)} %',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (_, index) => SizedBox(height: 4.h),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                RouteConstants.forecastForm,
              );
              _forecastBloc.add(const GetListForecastEvent());
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.add_rounded,
              color: Theme.of(context).accentColor,
              size: 32.sp,
            ),
          ),
        );
      },
    );
  }
}
