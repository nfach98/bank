import 'dart:math';

import 'package:bank/common/constants/route_constants.dart';
import 'package:bank/modules/forecast/domain/entities/forecast_entity.dart';
import 'package:bank/modules/forecast/presentation/bloc/forecast_bloc.dart';
import 'package:bank/modules/forecast/presentation/widgets/card_list_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:collection/collection.dart";

import '../../../common/config/themes.dart';
import '../../main/domain/entities/category_entity.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late ForecastBloc _forecastBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _forecastBloc = BlocProvider.of<ForecastBloc>(context);
      _forecastBloc.add(const GetListForecastEvent());
      _forecastBloc.add(const GetListCategoryEvent());
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
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(
                  context,
                  RouteConstants.forecastForm
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
      }
    );
  }
}
