// lib/widgets/matching_game_controls.dart
import 'package:flutter/material.dart';

class MatchingGameControls extends StatelessWidget {
  final String? selectedCategory;
  final List<String> availableCategories;
  final Function(String?) onCategoryChanged;
  final VoidCallback? onRefresh; // تم التعديل هنا

  const MatchingGameControls({
    super.key,
    required this.selectedCategory,
    required this.availableCategories,
    required this.onCategoryChanged,
    this.onRefresh, // تم التعديل هنا
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton<String>(
            value: selectedCategory,
            hint: const Text('اختر الفئة'),
            items: availableCategories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: onCategoryChanged,
          ),
          ElevatedButton(
            onPressed: availableCategories.isNotEmpty
                ? onRefresh
                : null, // تم التعديل هنا
            child: const Text('تغيير العناصر'),
          ),
        ],
      ),
    );
  }
}
