import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:track_trek/core/utils/app_color.dart';
class MultipleDatePicker extends StatefulWidget {
  final List<DateTime> preSelectedDates;
  final List<DateTime>? selectedDates;
  final Function(List<DateTime>) onDateSelected;
  final bool allowSelection;
  final bool multipleSelection;
  const MultipleDatePicker({
    super.key,
    required this.preSelectedDates,
    required this.onDateSelected,  this.selectedDates,  this.allowSelection=true,this.multipleSelection=true,
  });

  @override
  _MultipleDatePickerState createState() => _MultipleDatePickerState();
}

class _MultipleDatePickerState extends State<MultipleDatePicker> {
  late List<DateTime> _selectedDates;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDates = widget.selectedDates != null
        ? List<DateTime>.from(widget.selectedDates!)
        : List<DateTime>.from(widget.preSelectedDates);    _focusedDay = DateTime.now(); // Start with the current month
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    if (!widget.allowSelection) return;

    setState(() {
      if (widget.multipleSelection) {
        // MULTIPLE SELECTION MODE
        if (_selectedDates.any((d) => _isSameDay(d, day))) {
          _selectedDates.removeWhere((d) => _isSameDay(d, day));
        } else {
          _selectedDates.add(day);
        }
      } else {
        // SINGLE SELECTION MODE
        _selectedDates = [day];
      }
    });

    widget.onDateSelected(_selectedDates);
  }
  void _onMonthChanged(DateTime focusedDay) {
    // setState(() {
    //   _focusedDay = focusedDay; // Update only when user navigates months
    // });
  }
  @override
  Widget build(BuildContext context) {
    return TableCalendar(

      firstDay: DateTime.utc(DateTime.now().year, 1, 1),
      lastDay: DateTime.utc(DateTime.now().year, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => _selectedDates.any((d) => _isSameDay(d, day)),
      onDaySelected:  // 👈 stop selecting
    _onDaySelected,
      // ❌ Disable swiping between months
      pageJumpingEnabled: false,
      pageAnimationEnabled: false,
      availableGestures: AvailableGestures.none,

      // ❌ Hide header arrows so user cannot click next/prev month
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      onPageChanged: _onMonthChanged,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.rectangle,/*borderRadius: BorderRadius.circular(6.r)*/
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.rectangle,/*borderRadius: BorderRadius.circular(6.r)*/
        ),

        outsideDaysVisible: false,
        weekendTextStyle: const TextStyle(color: Colors.black,fontSize: 12),
        defaultTextStyle: const TextStyle(color: Colors.black,fontSize: 12),
      ),
      daysOfWeekHeight: 20,
calendarBuilders: CalendarBuilders(defaultBuilder: (context, day, focusedDay) {
      if ( widget.preSelectedDates.any((d) => _isSameDay(d, day))) {
        return Container(
          margin: EdgeInsets.all(3.sp),
          decoration: BoxDecoration(
            color: AppColors.greenColor,

          ),
          alignment: Alignment.center,
          child: Text('${day.day}', style: TextStyle(color: Colors.white)),
        );
      }


},),
daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: TextStyle(color: Colors.black, fontSize: 12),weekendStyle: TextStyle(color: Colors.black, fontSize: 12)),
      // headerStyle: const HeaderStyle(
      //
      //   formatButtonVisible: false,
      //   titleCentered: true,
      //   titleTextStyle: TextStyle(
      //     fontSize: 16,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.black,
      //   ),
      // ),
    );
  }
}