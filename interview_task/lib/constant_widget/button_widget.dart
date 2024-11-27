import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onTap;
  final Size size;
  final double? textSize;
  final double? borderRadius;
  final Widget? titleWidget;

  const ButtonWidget({
    super.key,
    required this.title,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onTap,
    this.textSize,
    this.borderRadius = 12,
    this.titleWidget,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all<Size>(size),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
          elevation: WidgetStateProperty.all<double>(0),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
              side: BorderSide(color: buttonColor),
            ),
          ),
        ),
        onPressed: onTap,
        child: titleWidget ??
            Text(title,
                style: TextStyle(
                  fontSize: textSize ?? 16,
                  fontWeight: FontWeight.w600,
                  color: buttonTextColor,
                )));
  }
}
