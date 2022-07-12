import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:bank/modules/budget/presentation/bloc/budget_bloc.dart';
import 'package:bank/modules/budget/presentation/budget_form_page.dart';
import 'package:bank/modules/main/domain/entities/category_entity.dart';
import 'package:bank/modules/period/domain/entities/period_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../common/config/themes.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late BudgetBloc _budgetBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _budgetBloc = BlocProvider.of<BudgetBloc>(context);
      _budgetBloc.add(const GetListPeriodEvent());
      _budgetBloc.add(const GetListCategoryEvent());
      _budgetBloc.add(const ChangeTypeCategoryEvent('1'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (_, state) {
        String? selectedPeriod = state.selectedPeriod;
        List<PeriodEntity>? listPeriod = state.listPeriod;
        List<CategoryEntity>? listCategory = state.listCategory;
        List<BudgetEntity>? listBudget = state.listBudget;

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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FractionallySizedBox(
                widthFactor: 1.0,
                child: Card(
                  margin: const EdgeInsets.all(12).r,
                  child: Padding(
                    padding: const EdgeInsets.all(8).r,
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          onChanged: (value) {
                            _budgetBloc.add(ChangeDropdownPeriodEvent(
                                value ?? ''
                            ));
                          },
                          items: listPeriod?.map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(
                              '${DateFormat('dd MMM yyyy').format(DateTime.parse(e.dateStart ?? ''))}'
                                  ' - ${DateFormat('dd MMM yyyy').format(DateTime.parse(e.dateEnd ?? ''))}',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                fontWeight: e.id == selectedPeriod
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                                color: e.id == selectedPeriod
                                  ? Theme.of(context).primaryColor
                                  : BankTheme.colors.black,
                              ),
                            )
                          )).toList(),
                          selectedItemBuilder: (_) => listPeriod?.map((e) => Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${DateFormat('dd MMM yyyy').format(DateTime.parse(e.dateStart ?? ''))}'
                                  ' - ${DateFormat('dd MMM yyyy').format(DateTime.parse(e.dateEnd ?? ''))}',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )).toList() ?? [],
                          value: selectedPeriod,
                        )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listBudget?.length ?? 0,
                  itemBuilder: (_, index) {
                    BudgetEntity? budget = listBudget?[index];
                    CategoryEntity? category = listCategory?.where(
                      (e) => e.id == budget?.idCategory
                    ).toList()[0];

                    return budget != null
                      ? Card(
                        margin: EdgeInsets.symmetric(vertical: 12.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                category?.name ?? '',
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              budget.amount.toString(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      )
                      : Container();
                  },
                )
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BudgetFormPage()
              ));
              _budgetBloc.add(GetListBudgetEvent(
                idPeriod: selectedPeriod ?? ''
              ));
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
