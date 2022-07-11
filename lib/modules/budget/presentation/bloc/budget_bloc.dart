import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../period/domain/entities/period_entity.dart';
import '../../../period/domain/usecases/get_list_period.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final GetListPeriod getListPeriod;

  BudgetBloc(this.getListPeriod) : super(const BudgetState()) {
    on<GetListPeriodEvent>((event, emit) async {
      final getListPeriodCase = await getListPeriod.execute();
      emit(getListPeriodCase.fold(
        (l) => state.copyWith(
          message: l.message,
        ),
        (r) {
          String? selected = r.where((e) => (DateTime.parse(e.dateStart ?? '').isBefore(DateTime.now())
              || DateTime.parse(e.dateStart ?? '').isAtSameMomentAs(DateTime.now()))
              && DateTime.parse(e.dateEnd ?? '').isAfter(DateTime.now())).toList()[0].id;
          return state.copyWith(
            listPeriod: r,
            selectedPeriod: selected,
          );
        },
      ));
    });

    on<ChangeDropdownPeriodEvent>((event, emit) async {
      emit(BudgetState(
        selectedPeriod: event.id,
        listPeriod: state.listPeriod,
      ));
    });
  }
}
