import 'package:flutter/material.dart';
import '../general/colors.dart';

class ItemFilterWidget extends StatelessWidget {
  String text;
  bool isSelected;

  ItemFilterWidget({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: Chip(
        label: Text(
          text,
          style: TextStyle(
              color: !isSelected ? Colors.white : KBrandSecondaryColor),
        ),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        backgroundColor: isSelected ? Colors.white : KBrandSecondaryColor,
      ),
    );
  }
}
