part of 'calender_bloc.dart';

@immutable
sealed class CalenderEvent {}

class InitialDateEvent extends CalenderEvent {}

class SelectDateEvent extends CalenderEvent {}

class SelectCustomDateEvent extends CalenderEvent {
  final DateTime? dateTime;
  final int? selectedIndex;

  SelectCustomDateEvent(this.dateTime, this.selectedIndex);
}

class DaySelectedEvent extends CalenderEvent {
  final DateTime selectedDate;
  final DateTime focusedDate;

  DaySelectedEvent({required this.selectedDate, required this.focusedDate});
}

class CalenderPageChangeEvent extends CalenderEvent {
  final DateTime currentDate;
  final DateTime changedDate;

  CalenderPageChangeEvent(
      {required this.currentDate, required this.changedDate});
}

class CalenderNoDateSelectEvent extends CalenderEvent {
  final int? index;
  final String? noDate;
  CalenderNoDateSelectEvent({required this.index, required this.noDate});
}
