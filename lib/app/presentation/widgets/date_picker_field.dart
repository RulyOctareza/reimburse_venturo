import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:reimburse_venturo/core/constants/app_colors.dart';
import 'package:reimburse_venturo/core/theme/app_text_styles.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final String hint;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerField({
    super.key,
    required this.label,
    required this.hint,
    required this.selectedDate,
    required this.onDateSelected,
  });

  void _showDatePicker(BuildContext context) {
    DateTime focusedDay = selectedDate ?? DateTime.now();
    DateTime? tempSelectedDate = selectedDate;

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Calendar
                TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(tempSelectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      tempSelectedDate = selectedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
                const SizedBox(height: 16),
                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (tempSelectedDate != null) {
                        onDateSelected(tempSelectedDate!);
                        Get.back();
                      }
                    },
                    child: const Text('Pilih Tanggal'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.fieldLabel,
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showDatePicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.cardWhite,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: AppColors.textLightGray,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? DateFormat('dd MMM yyyy', 'id_ID').format(selectedDate!)
                        : hint,
                    style: selectedDate != null
                        ? AppTextStyles.bodyMedium
                        : AppTextStyles.hint,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
