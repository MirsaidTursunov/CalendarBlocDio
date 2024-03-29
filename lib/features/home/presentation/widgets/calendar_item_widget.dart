import 'package:calendar_app/constants/app_colors.dart';
import 'package:calendar_app/core/color_extention.dart';
import 'package:flutter/material.dart';

class CalendarItemWidget extends StatelessWidget {
  const CalendarItemWidget({
    super.key,
    required this.isSelected,
    required this.isActiveMonth,
    required this.date,
    required this.onTap,
    required this.dateColor,
    required this.offDays,
  });

  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;
  final bool offDays;
  final DateTime date;
  final String dateColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isActiveMonth,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          decoration: isSelected
              ? const BoxDecoration(
                  color: Colors.lightBlue, shape: BoxShape.circle)
              : BoxDecoration(
                  color: dateColor.toColor(), shape: BoxShape.circle),
          child: Text(
            date.day.toString(),
            style: TextStyle(
                fontSize: 14, color: offDays ? AppColors.red : AppColors.black),
          ),
        ),
      ),
    );
  }
}
