import 'package:asthma_diary/src/app.dart';
import 'package:asthma_diary/src/db/symptoms_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();

  runApp(
    Provider<AppDatabase>(
      create: (context) => db,
      child: const MyApp(),
      dispose: (context, database) => database.close(),
    ),
  );
}
