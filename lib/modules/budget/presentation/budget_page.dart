import 'dart:math';

import 'package:bank/common/utils/extensions.dart';
import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:bank/modules/budget/presentation/bloc/budget_bloc.dart';
import 'package:bank/modules/budget/presentation/budget_form_page.dart';
import 'package:bank/modules/budget/presentation/widgets/card_list_budget.dart';
import 'package:bank/modules/main/domain/entities/category_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:collection/collection.dart";

import '../../../common/config/themes.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late BudgetBloc _budgetBloc;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _budgetBloc = BlocProvider.of<BudgetBloc>(context);
      _budgetBloc.add(const GetListBudgetEvent());
      _budgetBloc.add(const GetListCategoryEvent());
      _budgetBloc.add(const ChangeCategoryTypeEvent('1'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (_, state) {
        List<CategoryEntity>? listCategory = state.listCategory;
        List<String>? listCategoryTypes = listCategory?.map(
          (e) => e.type ?? ''
        ).toSet().toList();

        List<BudgetEntity>? listBudget = state.listBudget;
        List<BudgetEntity>? listAllocation = listBudget?.where(
          (e) => e.type == '1' || e.type == '3'
        ).toList();

        Map? groupedAllocation;
        int totalAllocation = 0;

        if (listAllocation != null && listAllocation.isNotEmpty) {
          groupedAllocation = groupBy(listAllocation, (e) => (e as BudgetEntity).idCategory);
          totalAllocation = listAllocation.map((e) => e.amount ?? 0).reduce(
          (value, element) => value + element);
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: BankTheme.colors.green,
            title: Text(
              "Budget",
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
                    List<BudgetEntity>? list =
                    listBudget?.where((e) => e.type == listCategoryTypes?[index]).toList();

                    if (list != null && list.isNotEmpty) {
                      return CardListBudget(
                        listBudget: list,
                        categoryType: listCategoryTypes?[index] ?? '',
                      );
                    }

                    return Container();
                  },
                  separatorBuilder: (_, index) => SizedBox(height: 12.h),
                ),
                SizedBox(height: 12.h),
                if (groupedAllocation != null && groupedAllocation.isNotEmpty) Card(
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
                              centerSpaceRadius: 0,
                              sections: groupedAllocation.entries.map((e) {
                                int value = (e.value as List<BudgetEntity>)
                                    .map((e) => e.amount ?? 0)
                                    .reduce((value, element) => value + element);
                                CategoryEntity? category = listCategory?.where(
                                        (c) => c.id == e.value[0].idCategory
                                ).toList()[0];
                                double percentage = value / totalAllocation * 100;

                                return PieChartSectionData(
                                  color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                  value: value / totalAllocation * 100,
                                  title: '${category?.name}\n'
                                      '(${percentage.toStringAsFixed(2)}.%)',
                                  radius: context.screenWidth / 3,
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BudgetFormPage()
              ));
              _budgetBloc.add(const GetListBudgetEvent());
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
