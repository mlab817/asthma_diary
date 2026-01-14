import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  final DateTime firstDay = DateTime(2026, 1, 1);
  final DateTime lastDay = DateTime(2026, 12, 31);

  String get _selectedDayText => _selectedDay == null
      ? 'No day selected'
      : DateFormat('MMM dd, yyyy').format(_selectedDay!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: Text(
          'My Asthma Diary',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            sixWeekMonthsEnforced: true,
            availableCalendarFormats: {CalendarFormat.month: 'Month'},
            onDaySelected: (DateTime day, DateTime focusedDay) {
              setState(() {
                _selectedDay = day;
                _focusedDay = day;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$_selectedDayText: Listed symptoms',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_symptom'),
        tooltip: 'Add symptom',
        child: const Icon(Icons.add),
      ),
    );
  }
}
