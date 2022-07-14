import 'package:bank/modules/budget/domain/entities/budget_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/budget_bloc.dart';
import '../budget_form_page.dart';

class BottomSheetBudget extends StatelessWidget {
  final BudgetEntity budget;

  const BottomSheetBudget({Key? key, required this.budget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BudgetBloc _budgetBloc = BlocProvider.of<BudgetBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => BudgetFormPage(
                budget: budget,
              ))
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 16,
            ).r,
            child: Row(
              children: [
                SizedBox(
                  height: 16.r,
                  width: 16.r,
                  child: FaIcon(
                    FontAwesomeIcons.pen,
                    size: 16.r,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Edit',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _budgetBloc.add(DeleteBudgetEvent(id: budget.id ?? ''));
            _budgetBloc.add(const GetListBudgetEvent());
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 16,
            ).r,
            child: Row(
              children: [
                SizedBox(
                  height: 16.r,
                  width: 16.r,
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    size: 16.r,
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Delete',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.red
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
