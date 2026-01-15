import 'package:asthma_diary/src/pages/add_symptom_page.dart';
import 'package:asthma_diary/src/pages/home_page.dart';
import 'package:asthma_diary/src/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String title = 'My Asthma Diary';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      darkTheme: appTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/add_symptom': (context) => const AddSymptomPage(),
      },
    );
  }
}
