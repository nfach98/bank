import 'package:bank/modules/period/domain/entities/period_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../common/config/themes.dart';
import 'bloc/period_bloc.dart';

class PeriodFormPage extends StatefulWidget {
  final PeriodEntity? period;

  const PeriodFormPage({Key? key, this.period}) : super(key: key);

  @override
  State<PeriodFormPage> createState() => _PeriodFormPageState();
}

class _PeriodFormPageState extends State<PeriodFormPage> {
  late PeriodBloc _periodBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _periodBloc = BlocProvider.of<PeriodBloc>(context);
      if (widget.period != null) {
        _periodBloc.add(ChangeDateTimeRangeEvent(
          startDate: DateTime.parse(widget.period?.dateStart ?? ''),
          endDate: DateTime.parse(widget.period?.dateEnd ?? ''),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PeriodBloc, PeriodState>(
      listener: (_, state) {
        if (state.message == 'success') Navigator.pop(context);
      },
      child: BlocBuilder<PeriodBloc, PeriodState>(
        builder: (_, state) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              widget.period == null
                ? 'New Period'
                : 'Edit Period'
            ),
          ),
          body:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12).r,
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        child: InkWell(
                          onTap: () async {
                            DateTimeRange? date = await showDateRangePicker(
                                context: context,
                                initialDateRange: state.startDate == null || state.endDate == null
                                    ? null
                                    : DateTimeRange(
                                  start: state.startDate!,
                                  end: state.endDate!,
                                ),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                                builder: (_, child) => Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).primaryColor,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                )
                            );
                            if (date != null) {
                              _periodBloc.add(ChangeDateTimeRangeEvent(
                                startDate: date.start,
                                endDate: date.end,
                              ));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12).r,
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.calendar,
                                  size: 20.r,
                                  color: state.startDate != null && state.endDate != null
                                      ? Theme.of(context).primaryColor
                                      : BankTheme.colors.grey,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    state.startDate == null || state.endDate == null
                                        ? 'Choose Date'
                                        : '${DateFormat('dd MMMM yyyy').format(state.startDate!)}'
                                        ' - ${DateFormat('dd MMMM yyyy').format(state.endDate!)}',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: state.startDate != null || state.endDate != null
                                          ? BankTheme.colors.black
                                          : BankTheme.colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 1.0,
                child: TextButton(
                  onPressed: () {
                    if (state.startDate != null && state.endDate != null) {
                      if (widget.period != null) {
                        _periodBloc.add(UpdatePeriodEvent(
                          id: widget.period?.id ?? '',
                          startDate: state.startDate!,
                          endDate: state.endDate!,
                        ));
                      } else {
                        _periodBloc.add(CreatePeriodEvent(
                          startDate: state.startDate!,
                          endDate: state.endDate!,
                        ));
                      }
                    }
                  },
                  child: Text(
                      widget.period == null
                          ? 'Create Period'
                          : 'Update Period'
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
