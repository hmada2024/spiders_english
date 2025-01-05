// lib/widgets/matching_game_controls.dart
import 'package:flutter/material.dart';

class MatchingGameControls extends StatelessWidget {
  final String? selectedCategory;
  final List<String> availableCategories;
  final Function(String?) onCategoryChanged;
  final VoidCallback? onRefresh;

  const MatchingGameControls({
    super.key,
    required this.selectedCategory,
    required this.availableCategories,
    required this.onCategoryChanged,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: selectedCategory,
              hint: const Text('اختر الفئة'),
              isExpanded: true,
              items: availableCategories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: onCategoryChanged,
            ),
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(
            onPressed: availableCategories.isNotEmpty ? onRefresh : null,
            child: const Text('تغيير العناصر'),
          ),
        ],
      ),
    );
  }
}
