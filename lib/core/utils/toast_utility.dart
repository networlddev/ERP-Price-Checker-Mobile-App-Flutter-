import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtility {
  static Color color = Colors.green;
  static show(String message, ToastType toastType) {
    if (toastType == ToastType.success) {
      color = Colors.green;
    } else {
      color = Colors.red;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

enum ToastType { success, error }
