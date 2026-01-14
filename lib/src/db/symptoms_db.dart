import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:asthma_diary/src/config/constants.dart' as constants;

part 'symptoms_db.g.dart';

class Symptoms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symptom => text().named('symptom').unique()();
}

class Logs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get symptomId => integer().references(Symptoms, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Symptoms, Logs])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'asthma_diary',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await _seed(this);
    },
  );

  Future<void> _seed(AppDatabase db) async {
    final existing = await select(symptoms).get();
    if (existing.isNotEmpty) return;

    final symptomsToInsert = constants.symptoms
        .map((symptom) => SymptomsCompanion.insert(symptom: symptom))
        .toList();

    await batch((b) {
      b.insertAll(db.symptoms, symptomsToInsert);
    });
  }
}
