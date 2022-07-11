import 'package:bank/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'bloc/period_bloc.dart';

class PeriodFormPage extends StatefulWidget {
  const PeriodFormPage({Key? key}) : super(key: key);

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
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(12).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 8.h),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                    ),
                    child: InkWell(
                      onTap: () async {
                        DateTimeRange? date = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          _periodBloc.add(ChangeDateTimeRangeEvent(
                            startDate: date.start,
                            endDate: date.end,
                          ));
                        }
                      },
                      child: Text(
                        state.startDate == null || state.endDate == null
                          ? 'Choose Date'
                          : '${DateFormat('dd MMMM yyyy').format(state.startDate!)}'
                            ' - ${DateFormat('dd MMMM yyyy').format(state.endDate!)}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: TextButton(
                    onPressed: () {
                      if (state.startDate != null && state.endDate != null) {
                        _periodBloc.add(CreatePeriodEvent(
                          startDate: state.startDate!,
                          endDate: state.endDate!,
                        ));
                      }
                    },
                    child: Text(
                      'Buat Periode'
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
