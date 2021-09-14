import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalWidgets {
  GlobalWidgets._();
  static final globalWidgets = GlobalWidgets._();

  presentSnackBar({
    BuildContext context,
    String text = '',
    Color backgroundColor,
    int duration = 3000,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: backgroundColor,
        duration: Duration(milliseconds: duration),
      ),
    );
  }
}
