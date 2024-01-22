import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calender_event.dart';
part 'calender_state.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  CalenderBloc() : super(CalenderInitial()) {
    on<InitialDateEvent>(initalDateEvent);
    on<SelectDateEvent>(selectDateEvent);
    on<SelectCustomDateEvent>(selectCustomDateEvent);
    on<DaySelectedEvent>(daySelectedEvent);
    on<CalenderPageChangeEvent>(calenderPageChangeEvent);
    on<CalenderNoDateSelectEvent>(calenderNoDateSelectEvent);
  }

  FutureOr<void> initalDateEvent(
      InitialDateEvent event, Emitter<CalenderState> emit) {}

  FutureOr<void> selectDateEvent(
      SelectDateEvent event, Emitter<CalenderState> emit) {}

  FutureOr<void> selectCustomDateEvent(
      SelectCustomDateEvent event, Emitter<CalenderState> emit) {
    emit(SelectCustomDateState(event.dateTime, event.selectedIndex));
  }

  FutureOr<void> daySelectedEvent(
      DaySelectedEvent event, Emitter<CalenderState> emit) {
    emit(DaySelectedState(
        focusedDate: event.focusedDate, selectedDate: event.selectedDate));
  }

  FutureOr<void> calenderPageChangeEvent(
      CalenderPageChangeEvent event, Emitter<CalenderState> emit) {
    if (event.changedDate.compareTo(event.currentDate) < 0) {
      emit(CalenderChangedState(opacity: 0.5));
    } else {
      emit(CalenderChangedState(opacity: 1.0));
    }
  }

  FutureOr<void> calenderNoDateSelectEvent(CalenderNoDateSelectEvent event, Emitter<CalenderState> emit) {
    emit(CalenderNoDateSelectState(index: event.index, noDate: event.noDate));
  }
}
