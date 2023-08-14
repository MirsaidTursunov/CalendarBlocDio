import 'package:calendar_app/constants/app_colors.dart';
import 'package:calendar_app/constants/app_constants.dart';
import 'package:calendar_app/core/date_time.dart';
import 'package:calendar_app/core/formz/formz_status.dart';
import 'package:calendar_app/features/home/data/models/get_colors_response.dart';
import 'package:calendar_app/features/home/data/models/get_date_response.dart';
import 'package:calendar_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:calendar_app/features/home/presentation/widgets/calendar_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Calendar'),
          ),
          body: state.status == FormzStatus.submissionSuccess
              ? Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          AppConstants.daysOfWeekWords.length,
                          (index) {
                            return Text(
                              AppConstants.daysOfWeekWords[index],
                              style: TextStyle(
                                color:
                                    index == 6 ? AppColors.red : AppColors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final week in state.calendarMonthData!.weeks)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                children: week.map((d) {
                                  String getColorForDay() {
                                    final day = d.date.day;
                                    final selectedDay = state.dateResult?.days
                                        ?.firstWhere(
                                            (element) => element.day == day,
                                            orElse: () => Days());

                                    if (selectedDay != null) {
                                      final colorResponse = state.colorsData
                                          ?.firstWhere(
                                              (color) =>
                                                  color.type ==
                                                  selectedDay.type,
                                              orElse: () =>
                                                  GetColorsResponse());
                                      if (colorResponse != null) {
                                        return colorResponse.color ??
                                            '#FFFFFF'; // Default color if not found
                                      }
                                    }
                                    return '#FFFFFF'; // Default color if no data found
                                  }

                                  return Expanded(
                                    child: CalendarItemWidget(
                                      date: d.date,
                                      isActiveMonth: d.isActiveMonth,
                                      dateColor: getColorForDay(),
                                      onTap: () {
                                        context.read<HomeBloc>().add(
                                            SelectDayEvent(newDate: d.date));

                                          final selectedDay = state.dateResult?.days?.firstWhere((element) => element.day == d.date.day, orElse: () => Days());
                                          if (selectedDay?.day != null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                duration: const Duration(milliseconds: 300),
                                                content: Text(
                                                  'Day: ${selectedDay?.day??''}, Type: ${selectedDay?.type ?? ''}',
                                                ),
                                              ));
                                          }
                                      },
                                      isSelected: state.selectedDate != null &&
                                          state.selectedDate!
                                              .isSameDate(d.date),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: SizedBox(
                      height: 36,
                      width: 36,
                      child: CircularProgressIndicator())),
        );
      },
    );
  }
}
