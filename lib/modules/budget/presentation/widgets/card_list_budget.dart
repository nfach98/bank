import 'package:bank/common/utils/currency_formatter.dart';
import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:bank/modules/budget/presentation/bloc/budget_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/config/themes.dart';
import '../../../main/domain/entities/category_entity.dart';

class CardListBudget extends StatelessWidget {
  final List<BudgetEntity> listBudget;
  final String categoryType;

  const CardListBudget({Key? key, required this.listBudget, required this.categoryType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (_, state) {
        List<CategoryEntity>? listCategory = state.listCategory;

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTitle(categoryType),
                  style: Theme.of(context).textTheme.headline3,
                ),
                Container(
                  height: 1.h,
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  color: BankTheme.colors.grey.withOpacity(0.5),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listBudget.length,
                  itemBuilder: (_, index) {
                    BudgetEntity? budget = listBudget[index];
                    CategoryEntity? category = listCategory?.where(
                      (e) => e.id == budget.idCategory
                    ).toList()[0];

                    if (category != null) {
                      return InkWell(
                        onTap: () { },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0).r,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: FaIcon(
                                  IconDataSolid(category.idIcon ?? 0),
                                  size: 16.r,
                                  color: BankTheme.colors.white,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  budget.name ?? '',
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                (budget.amount ?? 0).toSeparatedDecimal(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                  separatorBuilder: (_, index) => Container(
                    height: 1.h,
                  ),
                ),
                Container(
                  height: 1.h,
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  color: BankTheme.colors.grey.withOpacity(0.5),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Monthly ${getTitle(categoryType).toLowerCase()}'
                      ),
                    ),
                    Text(
                      listBudget.map((e) => e.amount ?? 0).toList()
                          .reduce((value, element) => value + element).toSeparatedDecimal(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Annual ${getTitle(categoryType).toLowerCase()}'
                      ),
                    ),
                    Text(
                      (listBudget.map((e) => e.amount ?? 0).toList()
                          .reduce((value, element) => value + element) * 12).toSeparatedDecimal(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        );
      }
    );
  }

  String getTitle(String index) {
    switch(index) {
      case '1': return 'Expenses';
      case '2': return 'Incomes';
      case '3': return 'Savings';
      default: return '';
    }
  }
}
