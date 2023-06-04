import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onTap;
  final Color backgroundTextColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.textButton,
    required this.onTap,
    required this.backgroundTextColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(backgroundTextColor),
        ),
        onPressed: onTap,
        child: Text(
          textButton,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
