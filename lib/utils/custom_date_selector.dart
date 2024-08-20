import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateRangePicker extends StatefulWidget {
  const CustomDateRangePicker({super.key});

  @override
  _CustomDateRangePickerState createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  final DateFormat _dateFormat = DateFormat('MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            _buildCalendar(),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Text(
          _startDate != null ? _dateFormat.format(_startDate!) : _dateFormat.format(DateTime.now()),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 48), // To center the title
      ],
    );
  }

  Widget _buildCalendar() {
    return CalendarDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      onDateChanged: (DateTime date) {
        setState(() {
          if (_startDate == null || (_startDate != null && _endDate != null)) {
            _startDate = date;
            _endDate = null;
          } else if (_startDate != null && _endDate == null) {
            if (date.isAfter(_startDate!)) {
              _endDate = date;
            } else {
              _endDate = _startDate;
              _startDate = date;
            }
          }
        });
      },
      selectableDayPredicate: (date) {
        if (_startDate != null && _endDate != null) {
          return date.isAfter(_startDate!) && date.isBefore(_endDate!);
        }
        return true;
      },
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop([_startDate, _endDate]);
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 60.0),
          child: Text('Confirm', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
