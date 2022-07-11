import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/config/themes.dart';
import '../../main/domain/entities/category_entity.dart';
import 'bloc/budget_bloc.dart';

class BudgetFormPage extends StatefulWidget {
  const BudgetFormPage({Key? key}) : super(key: key);

  @override
  State<BudgetFormPage> createState() => _BudgetFormPageState();
}

class _BudgetFormPageState extends State<BudgetFormPage> {
  late BudgetBloc _budgetBloc;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _budgetBloc = BlocProvider.of<BudgetBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetBloc, BudgetState>(
      listener: (_, state) {
        if (state.message == 'success') Navigator.pop(context);
      },
      child: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (_, state) {
          String? selectedPeriod = state.selectedPeriod;
          String? selectedCategory = state.selectedCategory;
          List<CategoryEntity>? listCategory = state.listCategory;

          print(selectedCategory);

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(12).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Card(
                      margin: const EdgeInsets.all(4).r,
                      child: Padding(
                        padding: const EdgeInsets.all(8).r,
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedCategory,
                              onChanged: (value) {
                                _budgetBloc.add(ChangeDropdownCategoryEvent(
                                  value ?? ''
                                ));
                              },
                              items: listCategory?.map((e) => DropdownMenuItem(
                                value: e.id,
                                child: Text(
                                  '${e.name}',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontWeight: e.id == selectedCategory
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                    color: e.id == selectedCategory
                                      ? Theme.of(context).primaryColor
                                      : BankTheme.colors.black,
                                  ),
                                )
                              )).toList(),
                              selectedItemBuilder: (_) => listCategory?.map((e) => Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${e.name}',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )).toList() ?? [],
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: TextField(
                      controller: _nameController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8).r,
                        hintText: 'Name',
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: false,
                        decimal: false,
                      ),
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        contentPadding: const EdgeInsets.all(8).r,
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          )
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: TextButton(
                      onPressed: () {
                        // if (state.startDate != null && state.endDate != null) {
                        //   _budgetBloc.add(CreatePeriodEvent(
                        //     startDate: state.startDate!,
                        //     endDate: state.endDate!,
                        //   ));
                        // }
                      },
                      child: Text(
                          'Create Budget'
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
