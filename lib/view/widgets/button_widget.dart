import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Widget buttonTextWidget;
  final bool isEnabled;
  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonTextWidget,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : (){},
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? Colors.blue : Colors.grey.withOpacity(0.7),
        foregroundColor: isEnabled ? Colors.white : Colors.grey.withOpacity(0.7),
        textStyle: TextStyle(
          fontSize: 14,
          color: isEnabled ? Colors.white : Colors.grey,
        ),
      ),
      child: buttonTextWidget,
    );
  }
}
