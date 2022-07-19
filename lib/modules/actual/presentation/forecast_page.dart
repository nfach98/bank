import 'package:bank/common/constants/route_constants.dart';
import 'package:bank/modules/forecast/presentation/forecast_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common/config/themes.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: BankTheme.colors.green,
        title: Text(
          'Forecast',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            RouteConstants.forecastForm
          );
          // _budgetBloc.add(const GetListBudgetEvent());
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
}
