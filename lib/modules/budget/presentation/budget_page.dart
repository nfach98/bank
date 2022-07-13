import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:bank/modules/budget/presentation/bloc/budget_bloc.dart';
import 'package:bank/modules/budget/presentation/budget_form_page.dart';
import 'package:bank/modules/budget/presentation/widgets/card_list_budget.dart';
import 'package:bank/modules/main/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      _budgetBloc.add(const GetListBudgetEvent());
      _budgetBloc.add(const GetListPeriodEvent());
      _budgetBloc.add(const GetListCategoryEvent());
      _budgetBloc.add(const ChangeTypeCategoryEvent('1'));
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
          body: ListView.separated(
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
