import 'package:bank/common/constants/route_constants.dart';
import 'package:bank/modules/actual/domain/entities/actual_entity.dart';
import 'package:bank/modules/actual/presentation/bloc/actual_bloc.dart';
import 'package:bank/modules/actual/presentation/widgets/card_list_actual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:collection/collection.dart";

import '../../../common/config/themes.dart';

class ActualPage extends StatefulWidget {
  const ActualPage({Key? key}) : super(key: key);

  @override
  State<ActualPage> createState() => _ActualPageState();
}

class _ActualPageState extends State<ActualPage> {
  late ActualBloc _actualBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _actualBloc = BlocProvider.of<ActualBloc>(context);
      _actualBloc.add(const GetListActualEvent());
      _actualBloc.add(const GetListCategoryEvent());
      _actualBloc.add(const ChangeCategoryEvent('1'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActualBloc, ActualState>(
      builder: (_, state) {
        List<ActualEntity>? listActual = state.listActual;

        Map? mapGroupedAllocation;

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
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 12.h),
                ListView.separated(
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
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                RouteConstants.actualForm
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
