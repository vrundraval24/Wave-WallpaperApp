import 'package:flutter/material.dart';
import 'package:wave/Constants/colors.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.categoryName, required this.isSelected});

  final String categoryName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: isSelected ? Colors.black : Colors.black.withAlpha(10),
      borderRadius: const BorderRadius.all(Radius.circular(5))),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: Text(categoryName, style: TextStyle(color: isSelected? Colors.white : Colors.black),),
    );
  }
}
