import 'package:bank/modules/actual/domain/entities/actual_entity.dart';
import 'package:bank/modules/actual/presentation/actual_form_page.dart';
import 'package:bank/modules/actual/presentation/bloc/actual_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BottomSheetActual extends StatelessWidget {
  final ActualEntity actual;

  const BottomSheetActual({Key? key, required this.actual}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ActualBloc _actualBloc = BlocProvider.of<ActualBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ActualFormPage(
                actual: actual,
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
            _actualBloc.add(DeleteActualEvent(id: actual.id ?? ''));
            _actualBloc.add(const GetListActualEvent());
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
