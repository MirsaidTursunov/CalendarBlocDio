import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendar_app/core/calendar_month.dart';
import 'package:calendar_app/core/formz/formz_status.dart';
import 'package:calendar_app/features/home/data/models/get_colors_response.dart';
import 'package:calendar_app/features/home/data/models/get_date_response.dart';
import 'package:calendar_app/features/home/domain/network/home_remote_data_source.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchMonthEvent>(_onFetchMonth);
    on<FetchColorsEvent>(_onFetchColors);
    on<SelectDayEvent>(_changeSelectedDay);
  }

  final _homeRepository = HomeRemoteDataSource();

  Future<void> _onFetchMonth(FetchMonthEvent event,
      Emitter<HomeState> emit) async {
    final result = await _homeRepository.fetchDate();

    emit(state.copyWith(
      status: FormzStatus.submissionSuccess,
      dateResult: result,
      calendarMonthData: CalendarMonthData(
        year: result.year ?? 2022,
        month: int.parse(result.month ?? '1'),
      ),
    ));
  }

  Future<void> _onFetchColors(FetchColorsEvent event,
      Emitter<HomeState> emit) async {
    final result = await _homeRepository.fetchColors();

    emit(state.copyWith(
      status: FormzStatus.submissionSuccess,
      colorsData: result,
    ));
  }

  _changeSelectedDay(SelectDayEvent event, Emitter<HomeState> emit) {
    if (state.selectedDate != event.newDate) {
      emit(state.copyWith(selectedDate: event.newDate));
    }
    // if (state.dateResult?.days?.where((element) => element.day == event.newDate.day)!=null) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(
    //     duration: const Duration(milliseconds: 300),
    //     content: Text(
    //       'Day: ${event.newDate.day}',
    //     ),
    //   ));
    // }
  }
}
