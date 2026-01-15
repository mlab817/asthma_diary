import 'package:asthma_diary/src/components/primary_button.dart';
import 'package:asthma_diary/src/pages/add_symptom_page.dart';
import 'package:asthma_diary/src/pages/settings_page.dart';
import 'package:asthma_diary/src/theme/colors.dart';
import 'package:asthma_diary/src/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'My Asthma Diary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          DashboardPage(pageController: _pageController),
          AddSymptomPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(LucideIcons.house), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.plus), label: 'Add'),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final PageController pageController;
  const DashboardPage({super.key, required this.pageController});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  final DateTime firstDay = DateTime(2026, 1, 1);
  final DateTime lastDay = DateTime(2026, 12, 31);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        spacing: 16.0,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 4.0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weekly Average',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            '0 entries this week',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF99a1af),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // icon
                    CircleAvatar(
                      backgroundColor: AppColors.bgPrimary,
                      radius: 32,
                      child: Icon(
                        LucideIcons.trendingUp,
                        color: AppColors.primary,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                focusedDay: _focusedDay,
                firstDay: firstDay,
                lastDay: lastDay,
                sixWeekMonthsEnforced: true,
                availableCalendarFormats: {CalendarFormat.month: 'Month'},
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  leftChevronIcon: Icon(
                    LucideIcons.chevronLeft,
                    color: AppColors.primary,
                  ),
                  rightChevronIcon: Icon(
                    LucideIcons.chevronRight,
                    color: AppColors.primary,
                  ),
                ),
                onDaySelected: (DateTime day, DateTime focusedDay) {
                  setState(() {
                    _selectedDay = day;
                    _focusedDay = day;
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                  todayDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary.withOpacity(0.5),
                  ),
                  defaultDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.surface,
                  ),
                  weekendDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.surface,
                  ),
                  outsideDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.surface,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Log Today\'s Symptoms',
              onPressed: () {
                widget.pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
