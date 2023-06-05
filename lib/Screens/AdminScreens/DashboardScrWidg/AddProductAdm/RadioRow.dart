import 'package:flutter/material.dart';

class RowRadioButton extends StatelessWidget {
  const RowRadioButton({
    super.key,
    required this.width,
    required this.selectedNew,
    required this.text,
    required this.onChanged,
  });
  final String text;
  final double width;
  final int selectedNew;
  final void Function(int?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.black87, fontSize: 18),
          ),
        ),
        SizedBox(
          width: width * 0.15,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        Radio(
            value: 1,
            groupValue: selectedNew,
            activeColor: Colors.orange,
            onChanged: onChanged),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            "No",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        Radio(
          value: 2,
          groupValue: selectedNew,
          activeColor: Colors.orange,
          onChanged: onChanged,
        )
      ],
    );
  }
}
