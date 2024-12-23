import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

Future<dynamic> showCustomCalenderWidget(BuildContext context,
    { Function(DateTime)? onDateSelected, bool goButton = false }) {
  return showDialog(
    context: context,
    builder: (context) {
      // Define selected date and focused date within this widget
      DateTime selectedDay = DateTime.now(); // Default to today's date
      DateTime focusedDay = DateTime.now(); // Focus on today's date

      return SimpleDialog(
        backgroundColor: Colors.transparent,
        children: [
          GradientContainerWidget(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8, // Limit height
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Adjusts size based on children
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height / 2,
                      child: TableCalendar(
                        daysOfWeekVisible: false,

                        headerStyle: HeaderStyle(
                          formatButtonPadding: EdgeInsets.zero,
                          leftChevronIcon: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.blackLightColor,
                            size: 15.sp,
                          ),
                          rightChevronIcon: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.blackLightColor,
                            size: 15.sp,
                          ),
                          formatButtonVisible: false,
                          titleTextStyle: poppinsMedium.copyWith(
                            fontSize: getFontSizeDefault(context),
                            color: AppColors.blackLightColor,
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          disabledTextStyle: poppinsMedium.copyWith(
                            fontSize: getFontSizeDefault(context),
                            color: AppColors.normalDarkWhite,
                          ),
                          todayDecoration: BoxDecoration(
                            color: AppColors.blackLightColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          weekendTextStyle: poppinsMedium.copyWith(
                            fontSize: getFontSizeDefault(context),
                            color: AppColors.blackLightColor,
                          ),
                          cellMargin: EdgeInsets.zero,
                          cellPadding: EdgeInsets.zero,
                          defaultTextStyle: poppinsMedium.copyWith(
                            fontSize: getFontSizeDefault(context),
                            color: AppColors.blackLightColor,
                          ),
                        ),
                        weekNumbersVisible: false,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: focusedDay,
                        onDaySelected: (selectedDate, focusedDay) {
                          selectedDay = selectedDate;
                          focusedDay = focusedDay;

                          // Trigger the callback if available to notify the parent widget
                          if (onDateSelected != null) {
                            onDateSelected(selectedDay); // Pass selected day back to the parent
                          }
                        },
                      ),
                    ),
                    goButton
                        ? InkWell(
                      onTap: () {
                        // Optionally, handle custom logic here
                        if (onDateSelected != null) {
                          onDateSelected(selectedDay); // Notify parent with selected date
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'GO',
                            style: poppinsMedium.copyWith(
                              fontSize: getFontSizeLarge(context),
                              color: AppColors.blackLightColor,
                            ),
                          ),
                          space12W,
                          Image.asset(
                            arrowForwardIconUrl,
                            height: 24.w,
                            width: 24.w,
                            color: AppColors.blackLightColor,
                          ),
                        ],
                      ),
                    )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

