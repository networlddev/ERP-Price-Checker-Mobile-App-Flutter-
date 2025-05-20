import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? color;
  final bool isReadOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final bool autoFocus;
  final bool enabled;
  final ValueChanged? onTapOutside;
  final FocusNode? focusNode;
  final TextInputFormatter? inputFormatter;
  final Color textColor;
  final void Function(String)? onChanged;
  final Color? cursorColor;
  final void Function()? onTap;
  final Color? hintColor;
  final bool filled;
  final Color? fillColor;

  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.color = Colors.blue,
      this.hintColor ,
      this.isReadOnly = false,
      this.keyboardType,
      this.validator,
      this.autoFocus = false,
      this.enabled = true,
      this.onEditingComplete,
      this.onTapOutside,
      this.filled = true,
      this.fillColor = Colors.white,
      this.focusNode,
      this.inputFormatter,
      this.textColor = Colors.black,
      this.onChanged,
      this.cursorColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        expands: false,
        maxLines: null,
        validator: validator,
        inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
        keyboardType: keyboardType,
        autofocus: autoFocus,
        enabled: enabled,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        cursorColor: cursorColor,
        onTap: onTap,
        style: TextStyle(color: textColor),
        // onTapOutside: (event) {
        //   FocusManager.instance.primaryFocus?.unfocus();
        // },
        onChanged: onChanged,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          border: getOutlinedBorder(fillColor),
          enabledBorder: getEnabledBorder(fillColor),
          focusedBorder: getFocusedBorder(color),
          
          errorBorder: getErrorBorder(),
          disabledBorder: getDisabledBorder(),
          fillColor: fillColor,

          // errorStyle: const TextStyle(fontSize: 8),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          filled: filled,
          
          floatingLabelStyle: TextStyle(color: color),
          hintStyle:  TextStyle(color: hintColor, fontSize: 10),
          hintText: hintText,
          labelText: hintText,
          labelStyle: TextStyle(color: hintColor, fontSize: 14),
        ),
      ),
    );
  }
}

OutlineInputBorder getOutlinedBorder(Color? color) => OutlineInputBorder(
        borderSide: BorderSide(
      color: color ?? const Color(0xFF000000),
    ));

OutlineInputBorder getEnabledBorder(Color? color) => OutlineInputBorder(
        borderSide: BorderSide(
      color: color ?? const Color(0xFF000000),
    ));

OutlineInputBorder getFocusedBorder(Color? color) => OutlineInputBorder(
        borderSide: BorderSide(
      color: color ?? const Color(0xFF000000),
    ));

OutlineInputBorder getErrorBorder() => const OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.red,
    ));

OutlineInputBorder getDisabledBorder() => OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)));
