import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/config/themes.dart';
import '../../main/domain/entities/category_entity.dart';
import '../domain/entities/budget_entity.dart';
import 'bloc/budget_bloc.dart';

class BudgetFormPage extends StatefulWidget {
  final BudgetEntity? budget;

  const BudgetFormPage({Key? key, this.budget}) : super(key: key);

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
      if (widget.budget != null) {
        _budgetBloc.add(ChangeCategoryTypeEvent(widget.budget?.type ?? ''));
        _budgetBloc.add(ChangeCategoryEvent(widget.budget?.idCategory ?? ''));
        _nameController.text = widget.budget?.name ?? '';
        _amountController.text = widget.budget?.amount?.toString() ?? '';
      }
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
          String? selectedCategory = state.selectedCategory;
          String? selectedTypeCategory = state.selectedTypeCategory;

          List<CategoryEntity>? listCategory = state.listCategory?.where(
            (e) => e.type == selectedTypeCategory).toList();
          List<String>? listTypeCategory = state.listTypeCategory;

          List<BudgetEntity>? listBudget = state.listBudget;
          List<BudgetEntity> listIncome = listBudget?.where(
            (e) => e.type == '2'
          ).toList() ?? [];
          List<BudgetEntity> listOutcome = listBudget?.where(
            (e) => e.type == '1' || e.type == '3'
          ).toList() ?? [];

          int remaining = 0;
          if (listIncome.isNotEmpty) {
            int income = listIncome.map((e) => e.amount ?? 0).reduce((p, n) => p + n);
            int outcome = listOutcome.isNotEmpty
              ? listOutcome.map((e) => e.amount ?? 0).reduce((p, n) => p + n)
              : 0;
            remaining = income - outcome;
          }

          return WillPopScope(
            onWillPop: () async {
              _budgetBloc.add(const ChangeCategoryEvent(''));
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text('New Budget'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FractionallySizedBox(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8).r,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: listTypeCategory?.map((e) {
                                  String type = '';
                                  if (e == '1') type = 'Expenses';
                                  if (e == '2') type = 'Incomes';
                                  if (e == '3') type = 'Savings';

                                  return Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        _budgetBloc.add(ChangeCategoryTypeEvent(e));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8).r,
                                        alignment: Alignment.center,
                                        color: e == selectedTypeCategory
                                            ? Theme.of(context).primaryColor
                                            : BankTheme.colors.white,
                                        child: Text(
                                          type,
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                            color: e == selectedTypeCategory
                                                ? BankTheme.colors.white
                                                : BankTheme.colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList() ?? [],
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemCount: listCategory?.length ?? 0,
                              itemBuilder: (_, index) {
                                CategoryEntity? category = listCategory?[index];

                                return GestureDetector(
                                  onTap: () {
                                    _budgetBloc.add(ChangeCategoryEvent(
                                        category?.id ?? ''
                                    ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12).r,
                                      color: category?.id == selectedCategory
                                          ? Theme.of(context).primaryColor
                                          : BankTheme.colors.white,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FaIcon(
                                            IconDataSolid(category?.idIcon ?? 0),
                                            size: 20.r,
                                            color: category?.id == selectedCategory
                                                ? BankTheme.colors.white
                                                : BankTheme.colors.black,
                                          ),
                                          SizedBox(height: 8.h),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8
                                            ).r,
                                            child: Text(
                                              '${category?.name}',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                fontWeight: category?.id == selectedCategory
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                                color: category?.id == selectedCategory
                                                    ? BankTheme.colors.white
                                                    : BankTheme.colors.black,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: TextField(
                                  controller: _nameController,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8).r,
                                    hintText: 'Name',
                                    hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: BankTheme.colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _amountController,
                                  style: Theme.of(context).textTheme.headline2,
                                  keyboardType: const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: false,
                                  ),
                                  textAlign: TextAlign.right,
                                  cursorWidth: 0,
                                  cursorHeight: 0,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: '0',
                                    hintStyle: Theme.of(context).textTheme.headline2,
                                    contentPadding: const EdgeInsets.all(8).r,
                                    border: InputBorder.none,
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: TextButton(
                      onPressed: () {
                        CategoryEntity? category;
                        bool isIncome = selectedTypeCategory == '2';
                        bool isSufficientBudget = (selectedTypeCategory == '1' || selectedTypeCategory == '3')
                            && remaining - int.parse(_amountController.text) >= 0;

                        var cat = listCategory?.where(
                          (e) => e.id == selectedCategory
                        ).toList();
                        if (cat != null && cat.isNotEmpty) {
                          category = cat[0];
                        }

                        if (selectedCategory != null
                            && selectedTypeCategory != null
                            && category?.type == selectedTypeCategory
                            && _nameController.text.isNotEmpty
                            && _amountController.text.isNotEmpty
                            // && (isIncome || isSufficientBudget)
                        ) {
                          if (widget.budget != null) {
                            _budgetBloc.add(UpdateBudgetEvent(
                              id: widget.budget?.id ?? '',
                              idCategory: selectedCategory,
                              type: selectedTypeCategory,
                              name: _nameController.text,
                              amount: int.parse(_amountController.text),
                            ));
                            _budgetBloc.add(const GetListBudgetEvent());
                          } else {
                            _budgetBloc.add(CreateBudgetEvent(
                              idCategory: selectedCategory,
                              type: selectedTypeCategory,
                              name: _nameController.text,
                              amount: int.parse(_amountController.text),
                            ));
                          }
                        }
                        // else if (!isSufficientBudget) {
                        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //     content: Text(
                        //       'Your budget is insufficient to add this plan'
                        //     ),
                        //   ));
                        // }
                      },
                      style: Theme.of(context).textButtonTheme.style?.copyWith(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(16).r
                        ),
                      ),
                      child: Text(
                        widget.budget == null ? 'Create Budget' : 'Update Budget',
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                          color: BankTheme.colors.white,
                        ),
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
