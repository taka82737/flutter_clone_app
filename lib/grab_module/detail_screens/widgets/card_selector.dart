import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardSelector extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final dynamic selectedValue;
  final Function(dynamic) onSelect;
  final String displayKey;
  final Axis direction;

  const CardSelector({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelect,
    required this.displayKey,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final isSelected = selectedValue == item[displayKey];
            return _buildCard(item, isSelected);
          },
        ),
      );
    } else {
      return Column(
        children: items.map((item) {
          final isSelected = selectedValue == item[displayKey];
          return _buildCard(item, isSelected);
        }).toList(),
      );
    }
  }

  Widget _buildCard(Map<String, dynamic> item, bool isSelected) {
    return GestureDetector(
      onTap: () => onSelect(item[displayKey]),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.green.withOpacity(0.1) : Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              item[displayKey].toString(),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
