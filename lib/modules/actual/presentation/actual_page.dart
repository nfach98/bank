import 'package:bank/common/constants/route_constants.dart';
import 'package:bank/common/utils/datetime_formatter.dart';
import 'package:bank/modules/actual/domain/entities/actual_entity.dart';
import 'package:bank/modules/actual/presentation/bloc/actual_bloc.dart';
import 'package:bank/modules/actual/presentation/widgets/card_list_actual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';

import '../../../common/config/themes.dart';
import '../../main/presentation/bloc/main_bloc.dart';
import '../../period/domain/entities/period_entity.dart';

class ActualPage extends StatefulWidget {
  const ActualPage({Key? key}) : super(key: key);

  @override
  State<ActualPage> createState() => _ActualPageState();
}

class _ActualPageState extends State<ActualPage> {
  late ActualBloc _actualBloc;
  late MainBloc _mainBloc;

  @override
  void initState() {
    super.initState();
    _actualBloc = BlocProvider.of<ActualBloc>(context);
    _mainBloc = BlocProvider.of<MainBloc>(context);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _actualBloc.add(const GetListActualEvent());
      _actualBloc.add(const GetListPeriodEvent());
      _actualBloc.add(const GetListCategoryEvent());
      _actualBloc.add(const ChangeCategoryTypeEvent('1'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActualBloc, ActualState>(
      builder: (_, state) {
        List<ActualEntity>? listActual = state.listActual;
        List<PeriodEntity>? listPeriod = state.listPeriod;
        String? idSelectedPeriod = _mainBloc.state.selectedPeriod;

        Map? mapGroupedAllocation;

        final now = DateTime.now();
        DateTime? dateStart;
        DateTime? dateEnd;
        int date = 28;

        if (now.day < date) {
          dateEnd = DateTime.now().add(Duration(days: date - now.day));
          dateEnd = DateTime(dateEnd.year, dateEnd.month, dateEnd.day);
          dateStart = DateTime(
            now.month == 1 ? now.year - 1 : now.year,
            now.month == 1 ? 12 : now.month - 1,
            date,
          );
        } else {
          dateStart = DateTime.now().subtract(Duration(days: now.day - date));
          dateStart = DateTime(dateStart.year, dateStart.month, dateStart.day);
          dateEnd = DateTime(
            now.month == 12 ? now.year + 1 : now.year,
            now.month == 12 ? 1 : now.month + 1,
            date,
          );
        }

        if (listActual != null && listActual.isNotEmpty) {
          mapGroupedAllocation = groupBy(listActual, (e) => (e as ActualEntity).date);
        }

        List<List<ActualEntity?>> listActualGrouped = [];
        mapGroupedAllocation?.values.toList().forEach((e) {
          listActualGrouped.add(e);
        });
        listActualGrouped.sort((a, b) =>
          ((b[0]?.date ?? '')).compareTo((a[0]?.date ?? ''))
        );

        if (idSelectedPeriod != null) {
          listActualGrouped = listActualGrouped.where(
            (e) {
              PeriodEntity? period = listPeriod?.firstWhere((e) => e.id == idSelectedPeriod);
              return DateTime.parse(e[0]?.date ?? '').isBetween(
                DateTime.parse(period?.dateStart ?? ''),
                DateTime.parse(period?.dateEnd ?? ''),
              );
            }
          ).toList();
        }

        // listActualGrouped = listActualGrouped.where((e) {
        //   final date = DateTime.parse(e[0]?.date ?? '');
        //   if (dateStart != null && dateEnd != null) {
        //     return (dateStart.isBefore(date)
        //       || dateStart.isAtSameMomentAs(date)
        //         && dateEnd.isAfter(date));
        //   }
        //   return false;
        // }).toList();

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: BankTheme.colors.green,
            title: Text(
              'Actual',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _mainBloc.state.selectedPeriod,
                      onChanged: (value) {
                        setState(() {
                          _mainBloc.add(ChangeSelectedPeriodEvent(id: value));
                        });
                      },
                      items: listPeriod?.map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            '${DateFormat('dd/MM/yyyy').format(DateTime.parse(e.dateStart ?? ''))} '
                                '- ${DateFormat('dd/MM/yyyy').format(DateTime.parse(e.dateEnd ?? ''))}',
                            style: Theme.of(context).textTheme.headline3?.copyWith(
                              fontWeight: e.id == idSelectedPeriod
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          )
                      )).toList() ?? [],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SingleChildScrollView(
                child: Expanded(
                  child: Column(
                    children: [
                      if (idSelectedPeriod != null) ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listActualGrouped.length,
                        itemBuilder: (_, index) {
                          List<ActualEntity?> list = listActualGrouped[index];

                          if (list.isNotEmpty) {
                            return CardListActual(
                              listActual: list,
                              date: list[0]?.date ?? '',
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
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                RouteConstants.actualForm,
              );
              _actualBloc.add(const GetListActualEvent());
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
