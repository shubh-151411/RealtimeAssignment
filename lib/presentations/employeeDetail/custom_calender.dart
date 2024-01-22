import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realtime_innovations/utils/assets/icon_assets.dart';
import 'package:realtime_innovations/utils/colors/colors.dart';
import 'package:realtime_innovations/utils/decoration/calender_btn.dart';
import 'package:realtime_innovations/utils/decoration/size_config.dart';
import 'package:realtime_innovations/utils/decoration/text_decoration.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget {
  final Function(String?)? onTap;
  final String? activeDate;
  const CalendarDialog({super.key, this.onTap, this.activeDate});

  @override
  _CalendarDialogState createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  int? selectedDateIndex;
  DateTime? _selectedDay = DateTime.now();
  List<String?> listChooseDate = [
    'Today',
    'Next Monday',
    'Next Tuesday',
    'After 1 week'
  ];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: Builder(builder: (context) {
          return SizedBox(
            width: SizeConfig.width! - 20,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: SizeConfig.width! * 0.05,
                    runSpacing: SizeConfig.width! * 0.02,
                    children: listChooseDate.asMap().entries.map((e) {
                      final index = e.key;
                      final value = e.value;
                      return CalenderBtn(
                        onTap: () {
                          _selectedDay = getUserSelectDate(e.value);
                          setState(() {
                            selectedDateIndex = index;
                          });
                        },
                        backGroundColor: selectedDateIndex == index
                            ? primaryBlue
                            : blueLight,
                        text: e.value,
                        textColor: selectedDateIndex == index
                            ? Colors.white
                            : primaryBlue,
                      );
                    }).toList(),
                  ),
                  TableCalendar(
                    calendarFormat: _calendarFormat,
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2050),
                    currentDay: DateTime.now(),
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month'
                    },
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      titleTextStyle: normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: textColor),
                      headerPadding: EdgeInsets.zero,
                      headerMargin: EdgeInsets.only(
                          top: SizeConfig.width! * 0.04,
                          bottom: SizeConfig.width! * 0.04),
                      leftChevronPadding:
                          EdgeInsets.only(left: SizeConfig.width! * 0.16),
                      rightChevronMargin:
                          EdgeInsets.only(right: SizeConfig.width! * 0.12),
                      formatButtonPadding: EdgeInsets.zero,
                      leftChevronIcon: Image.asset(
                        IconPath.arrow_left_calender,
                        width: SizeConfig.width! * 0.06,
                        height: SizeConfig.width! * 0.06,
                      ),
                      rightChevronPadding: EdgeInsets.zero,
                      rightChevronIcon: Image.asset(
                        IconPath.arrow_right_calender,
                        width: SizeConfig.width! * 0.06,
                        height: SizeConfig.width! * 0.06,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                        cellPadding: EdgeInsets.all(3.0),
                        tablePadding: const EdgeInsets.all(3.0),
                        todayTextStyle:
                            normalTextStyle.copyWith(color: primaryBlue),
                        isTodayHighlighted: true,
                        todayDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryBlue),
                        ),
                        defaultTextStyle: normalTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        outsideTextStyle: normalTextStyle,
                        selectedDecoration: BoxDecoration(
                          color: primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle:
                            normalTextStyle.copyWith(color: Colors.white)),
                    selectedDayPredicate: (day) => isSameDay(
                      _selectedDay,
                      day,
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                  ),
                  SizedBox(height: SizeConfig.height! * 0.05),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: borderGrey)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              IconPath.calender_icon,
                              color: primaryBlue,
                              scale: 2.0,
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              DateFormat('d MMM y')
                                  .format(_selectedDay ?? DateTime.now()),
                              style: normalTextStyle.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            )
                          ],
                        )),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            decoration: BoxDecoration(
                              color: blueLight,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: normalTextStyle.copyWith(
                                  color: primaryBlue, fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        InkWell(
                          onTap: () {
                            widget.onTap!(DateFormat('d MMM y')
                                .format(_selectedDay ?? DateTime.now()));
                            Navigator.pop(
                              context,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            decoration: BoxDecoration(
                              color: primaryBlue,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Text(
                              'Save',
                              style: normalTextStyle.copyWith(
                                  color: Colors.white, fontSize: 13),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      );
    });
  }

  DateTime _getNextDayOfWeek(DateTime currentDate, int day) {
    int daysUntilNextDay = (day - currentDate.weekday + 7) % 7;
    return currentDate.add(Duration(days: daysUntilNextDay));
  }

  DateTime getUserSelectDate(String? selectedOption) {
    switch (selectedOption) {
      case 'Today':
        return DateTime.now();

      case 'Next Monday':
        return _getNextDayOfWeek(DateTime.now(), DateTime.monday);

      case 'Next Tuesday':
        return _getNextDayOfWeek(DateTime.now(), DateTime.tuesday);

      case 'After 1 week':
        return DateTime.now().add(Duration(days: 7));

      default:
        return DateTime.now();
    }
  }
}
