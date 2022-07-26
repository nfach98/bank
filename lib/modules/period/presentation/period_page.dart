import 'package:bank/common/config/themes.dart';
import 'package:bank/modules/period/domain/entities/period_entity.dart';
import 'package:bank/modules/period/presentation/period_form_page.dart';
import 'package:bank/modules/period/presentation/widgets/bottom_sheet_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../common/utils/bottom_sheet_helper.dart';
import 'bloc/period_bloc.dart';

class PeriodPage extends StatefulWidget {
  const PeriodPage({Key? key}) : super(key: key);

  @override
  State<PeriodPage> createState() => _PeriodPageState();
}

class _PeriodPageState extends State<PeriodPage> {
  late PeriodBloc _periodBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _periodBloc = BlocProvider.of<PeriodBloc>(context);
      _periodBloc.add(const GetListPeriodEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeriodBloc, PeriodState>(
      builder: (_, state) {
        List<PeriodEntity>? listPeriod = state.listPeriod;

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: BankTheme.colors.green,
            title: Text(
              'Period',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 12.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listPeriod?.length ?? 0,
                itemBuilder: (_, index) {
                  PeriodEntity? period = listPeriod?[index];
                  bool isNow = (DateTime.parse(period?.dateStart ?? '').isBefore(DateTime.now())
                      || DateTime.parse(period?.dateStart ?? '').isAtSameMomentAs(DateTime.now()))
                  && DateTime.parse(period?.dateEnd ?? '').isAfter(DateTime.now());

                  if (period != null) {
                    return InkWell(
                      onTap: () {
                        BottomSheetHelper.show(
                          context: context,
                          child: BottomSheetPeriod(
                            period: period,
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        color: isNow
                          ? Theme.of(context).primaryColor
                          : BankTheme.colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 20.h,
                          ),
                          child: Text(
                            '${DateFormat('dd MMM yyyy').format(DateTime.parse(period.dateStart ?? ''))} '
                            '- ${DateFormat('dd MMM yyyy').format(DateTime.parse(period.dateEnd ?? ''))}',
                            style: Theme.of(context).textTheme.headline3?.copyWith(
                              color: isNow
                                ? BankTheme.colors.white
                                : BankTheme.colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                   return Container();
                },
                separatorBuilder: (_, index) => SizedBox(height: 12.h),
              ),
              SizedBox(height: 12.h),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PeriodFormPage())
              );
              _periodBloc.add(const GetListPeriodEvent());
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

