import 'package:asthma_diary/src/controllers/selection_controller.dart';
import 'package:asthma_diary/src/db/symptoms_db.dart';
import 'package:asthma_diary/src/extensions/extensions.dart';
import 'package:asthma_diary/src/widgets/selectable_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Symptom {
  final int id;
  final String symptom;
  Symptom({required this.id, required this.symptom});
}

class AddSymptomPage extends StatefulWidget {
  const AddSymptomPage({super.key});

  @override
  State<AddSymptomPage> createState() => _AddSymptomPageState();
}

class _AddSymptomPageState extends State<AddSymptomPage> {
  final SelectionController<Symptom> _controller =
      SelectionController<Symptom>();
  List<Symptom> symptoms = [];

  Future<void> _save() async {
    final db = context.read<AppDatabase>();

    for (var symptom in _controller.selectedItems.value) {
      db.managers.logs.create((o) => o(symptomId: symptom.id));
    }
  }

  Future<void> init() async {
    final db = context.read<AppDatabase>();
    // Use the manager API to get all rows
    final rows = await db.select(db.symptoms).get();

    // Extract just the string
    setState(() {
      symptoms = rows
          .map((e) => Symptom(id: e.id, symptom: e.symptom))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.selectedItems.addListener(() {
      print(_controller.selectedItems.value);
    });
    init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Symptom'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: symptoms
              .map(
                (symptom) => SelectableChip<Symptom>(
                  item: symptom,
                  label: symptom.symptom,
                  controller: _controller,
                ),
              )
              .toList(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(32),
        child: Row(
          spacing: 32,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    context.theme.colorScheme.primary,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    context.theme.colorScheme.onPrimary,
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                  ),
                  padding: WidgetStateProperty.all(EdgeInsetsGeometry.all(16)),
                ),
                child: Text('Save'),
              ),
            ),
            Expanded(
              child: ElevatedButton(onPressed: () {}, child: Text('Cancel')),
            ),
          ],
        ),
      ),
    );
  }
}
