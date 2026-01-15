import 'package:asthma_diary/src/components/buttons.dart';
import 'package:asthma_diary/src/controllers/selection_controller.dart';
import 'package:asthma_diary/src/db/symptoms_db.dart';
import 'package:asthma_diary/src/theme/colors.dart';
import 'package:asthma_diary/src/theme/text_styles.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: symptoms.length,
          itemBuilder: (context, index) => SelectableButtonTile<Symptom>(
            item: symptoms[index],
            label: symptoms[index].symptom,
            controller: _controller,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Row(
          spacing: 16,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 48),
                child: PrimaryButton3D(
                  label: 'Save',
                  onPressed: () {},
                  color: Colors.redAccent,
                ),
              ),
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 48),
                child: PrimaryButton3D(
                  label: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectableButtonTile<T> extends StatelessWidget {
  final T item;
  final String label;
  final SelectionController<T> controller;

  const SelectableButtonTile({
    super.key,
    required this.item,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<T>>(
      valueListenable: controller.selectedItems,
      builder: (context, selectedItems, child) {
        final isSelected = selectedItems.contains(item);

        return GestureDetector(
          onTap: () => controller.toggle(item),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.18) // slightly stronger
                  : AppColors.surface, // off-white instead of pure white
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: 1.5, // slightly thicker for clarity
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.20)
                      : Colors.black.withOpacity(0.08),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),

            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: isSelected
                          ? Icon(
                              Icons.check_circle,
                              key: const ValueKey('checked'),
                              color: AppColors.primary,
                            )
                          : Icon(
                              Icons.check_circle_outline,
                              key: const ValueKey('unchecked'),
                              color: AppColors.mutedText,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Severity slider
                if (isSelected)
                  ValueListenableBuilder<Map<T, int>>(
                    valueListenable: controller.severityMap,
                    builder: (context, severityMap, child) {
                      final severity = severityMap[item] ?? 3;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: AppColors.primary,
                              inactiveTrackColor: AppColors.border,
                              thumbColor: AppColors.white, // dark thumb
                              overlayColor: AppColors.primary.withOpacity(0.2),
                              trackHeight: 4,
                            ),
                            child: Slider(
                              min: 1,
                              max: 5,
                              divisions: 4,
                              value: severity.toDouble(),
                              onChanged: (value) =>
                                  controller.setSeverity(item, value.toInt()),
                            ),
                          ),
                          Text(
                            'Severity: $severity',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.mutedText,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
