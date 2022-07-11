import 'dart:developer';

import 'package:bank/modules/budget/presentation/bloc/budget_bloc.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (_, state) {
        List<PeriodEntity>? listPeriod = state.listPeriod;
        String? selectedPeriod = state.selectedPeriod;
        log(listPeriod.toString(), name: 'period');
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
                              style: Theme.of(context).textTheme.bodyText1,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
