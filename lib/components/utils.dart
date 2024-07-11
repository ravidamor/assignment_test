
import 'package:flutter/material.dart';

class Utils {
  static void mySnackBar(
  BuildContext context,
      {
    String title = "",
    String msg = "",
    double? maxWidth,
    Duration duration = const Duration(milliseconds: 1100),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(title),duration: const Duration(seconds: 1),),
    );
  }
}


