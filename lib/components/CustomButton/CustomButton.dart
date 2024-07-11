import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../my_theme.dart';

/// CustomButton

class CustomButton extends StatelessWidget {
  final String buttonText;
  final bool isSubmitting;
  final double width;
  final double height;
  final Color buttonColor;
  final TextStyle textStyle;
  final VoidCallback? onTap;

  const CustomButton({
    key,
    required this.buttonText,
    required this.onTap,
    required this.width,
    required this.height,
    required this.buttonColor,
    required this.textStyle,
    this.isSubmitting = false, // Provide a default value for isSubmitting

    // required this.isSubmitting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? onTap! : () {},
      // Use onTap if it's not null, otherwise provide an empty function
      //onTap: onTap
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
        ),
        child: isSubmitting
            ? SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  backgroundColor: MyTheme.cyan_with_light_sea_green,
                  strokeWidth: 3.5,
                  color: Colors.white,
                ),
              )
            : Text(
                buttonText,
                style: textStyle,
              ),
      ),
    );
  }
}
