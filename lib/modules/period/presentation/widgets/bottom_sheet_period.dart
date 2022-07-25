import 'package:bank/modules/period/domain/entities/period_entity.dart';
import 'package:bank/modules/period/presentation/bloc/period_bloc.dart';
import 'package:bank/modules/period/presentation/period_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetPeriod extends StatelessWidget {
  final PeriodEntity period;

  const BottomSheetPeriod({Key? key, required this.period}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PeriodBloc _budgetBloc = BlocProvider.of<PeriodBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => PeriodFormPage(
                period: period,
              ))
            );
            _budgetBloc.add(const GetListPeriodEvent());
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
            _budgetBloc.add(DeletePeriodEvent(id: period.id ?? ''));
            _budgetBloc.add(const GetListPeriodEvent());
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
