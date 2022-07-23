import 'package:bank/common/utils/bottom_sheet_helper.dart';
import 'package:bank/common/utils/currency_formatter.dart';
import 'package:bank/modules/actual/domain/entities/actual_entity.dart';
import 'package:bank/modules/actual/presentation/bloc/actual_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../common/config/themes.dart';
import '../../../main/domain/entities/category_entity.dart';
import 'bottom_sheet_actual.dart';

class CardListActual extends StatelessWidget {
  final List<ActualEntity?> listActual;
  final String date;

  const CardListActual({Key? key, required this.listActual, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActualBloc, ActualState>(
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
                  DateFormat('dd MMMM yyyy').format(
                    DateTime.parse(date)
                  ),
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 1.h,
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  color: BankTheme.colors.grey.withOpacity(0.5),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listActual.length,
                  itemBuilder: (_, index) {
                    ActualEntity? actual = listActual[index];
                    CategoryEntity? category = listCategory?.firstWhere(
                      (e) => e.id == actual?.idCategory
                    );

                    if (actual != null) {
                      return InkWell(
                        onTap: () {
                          BottomSheetHelper.show(
                            context: context,
                            child: BottomSheetActual(
                              actual: actual,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0).r,
                          child: Row(
                            children: [
                              if (category != null) CircleAvatar(
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
                                  actual.name ?? '',
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                (actual.amount ?? 0).toSeparatedDecimal(),
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
