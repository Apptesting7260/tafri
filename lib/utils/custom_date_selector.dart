// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:plusone/utils/size.dart';
//
// class CustomDateRangePicker extends StatefulWidget {
//   const CustomDateRangePicker({super.key});
//
//   @override
//   _CustomDateRangePickerState createState() => _CustomDateRangePickerState();
// }
//
// class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
//   DateTime? _startDate;
//   DateTime? _endDate;
//   final DateFormat _dateFormat = DateFormat('MMMM yyyy');
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 16,bottom: 30,right: 10,left: 10),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildHeader(),
//             _buildCalendar(),
//             _buildConfirmButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         Text(
//           _startDate != null ? _dateFormat.format(_startDate!) : _dateFormat.format(DateTime.now()),
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(width: 48), // To center the title
//       ],
//     );
//   }
//
//   Widget _buildCalendar() {
//     return CalendarDatePicker(
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//       onDateChanged: (DateTime date) {
//         setState(() {
//           if (_startDate == null || (_startDate != null && _endDate != null)) {
//             _startDate = date;
//             _endDate = null;
//           } else if (_startDate != null && _endDate == null) {
//             if (date.isAfter(_startDate!)) {
//               _endDate = date;
//             } else {
//               _endDate = _startDate;
//               _startDate = date;
//             }
//           }
//         });
//       },
//       selectableDayPredicate: (date) {
//         if (_startDate != null && _endDate != null) {
//           return date.isAfter(_startDate!) && date.isBefore(_endDate!);
//         }
//         return true;
//       },
//     );
//   }
//
//   Widget _buildConfirmButton() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.black,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(100),
//           ),
//           padding: const EdgeInsets.all(15)
//         ),
//         onPressed: () {
//           Navigator.of(context).pop([_startDate, _endDate]);
//         },
//         child: const Center(child: Text('Confirm', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/size.dart';

class CustomDateRangePicker extends StatefulWidget {
  final DateTime? date;

  const CustomDateRangePicker({super.key, this.date});

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    selectedDate = widget.date ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Top Bar with Cross Icon and Month-Year Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 25,
                      )),

                  Text(
                    "${_getMonthName(selectedDate!.month)} ${selectedDate!.year}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(), // Placeholder for symmetry
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),

            // Days of the Week
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["M", "T", "W", "T", "F", "S", "S"]
                    .map((day) => Text(
                          day,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Divider(
                color: clrBlacke.withOpacity(0.1),
                thickness: 1,
              ),
            ),

            // Calendar Dates
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildCalendar(),
            ),

            // Confirm Button
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Center(
                    child: Text('Confirm',
                        style: TextStyle(
                            color: clrWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))),
                onPressed: () {
                  Get.back(result: selectedDate);
                  // Navigator.of(context).pop(selectedDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    int daysInMonth =
        DateUtils.getDaysInMonth(selectedDate!.year, selectedDate!.month);
    int firstDayOffset =
        DateTime(selectedDate!.year, selectedDate!.month, 1).weekday % 7;
    DateTime today = DateTime.now();
    DateTime todayDateOnly = DateTime(
        today.year, today.month, today.day); // Only the date, no time component

    List<Widget> dateWidgets = [];

    // Empty containers for days before the 1st of the month
    for (int i = 0; i < firstDayOffset; i++) {
      dateWidgets.add(Container());
    }

    // Date widgets
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime currentDate =
          DateTime(selectedDate!.year, selectedDate!.month, i);
      bool isSelected = i == selectedDate!.day;
      bool isPastDate = currentDate.isBefore(todayDateOnly);

      dateWidgets.add(
        GestureDetector(
          onTap: !isPastDate
              ? () {
                  setState(() {
                    selectedDate = currentDate;
                  });
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? clrYellow : Colors.transparent,
              shape: BoxShape.circle,
            ),
            margin: isSelected ? const EdgeInsets.all(5.0) : EdgeInsets.zero,
            alignment: Alignment.center,
            child: Text(
              '$i',
              style: TextStyle(
                  color: isPastDate
                      ? clrGrey
                      : (isSelected ? clrBlacke : Colors.grey[800]),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: dateWidgets,
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }
}
