import 'package:bank/modules/forecast/domain/entities/forecast_entity.dart';
import 'package:bank/modules/forecast/presentation/bloc/forecast_bloc.dart';
import 'package:bank/modules/forecast/presentation/forecast_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BottomSheetForecast extends StatelessWidget {
  final ForecastEntity forecast;

  const BottomSheetForecast({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ForecastBloc _forecastBloc = BlocProvider.of<ForecastBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ForecastFormPage(
                forecast: forecast,
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
            _forecastBloc.add(DeleteForecastEvent(id: forecast.id ?? ''));
            _forecastBloc.add(const GetListForecastEvent());
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
