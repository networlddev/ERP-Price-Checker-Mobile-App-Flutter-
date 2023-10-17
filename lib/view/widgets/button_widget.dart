import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Widget buttonTextWidget;
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonTextWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white
          )),
      child: buttonTextWidget,
    );
  }
}