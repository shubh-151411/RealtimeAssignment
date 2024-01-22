part of 'calender_bloc.dart';

@immutable
sealed class CalenderState {}

final class CalenderInitial extends CalenderState {}

class SelectDateState extends CalenderState {}

class SelectCustomDateState extends CalenderState {
  final DateTime? dateTime;
  final int? selectedIndex;

  SelectCustomDateState(this.dateTime, this.selectedIndex);
}

class DaySelectedState extends CalenderState {
  final DateTime selectedDate;
  final DateTime focusedDate;

  DaySelectedState({required this.selectedDate, required this.focusedDate});
}

class CalenderChangedState extends CalenderState {
  final double? opacity;

  CalenderChangedState({this.opacity});
}

class CalenderNoDateSelectState extends CalenderState {
  final int? index;
  final String? noDate;
  CalenderNoDateSelectState({required this.index, required this.noDate});
}
