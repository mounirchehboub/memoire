import 'package:flutter/material.dart';

import '../../constants.dart';

class CatContianer extends StatelessWidget {
  const CatContianer(
      {super.key,
      required this.width,
      required this.categoryText,
      required this.onTap,
      required this.isSelected});

  final double width;
  final String categoryText;
  final void Function()? onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.04),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 40,
          width: categoryText.length * 15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isSelected ? Colors.black : buttonGrey),
          child: Center(
            child: Text(
              categoryText,
              textAlign: TextAlign.center,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
