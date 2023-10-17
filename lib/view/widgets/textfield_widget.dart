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

  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.color,
      this.isReadOnly = false,
      this.keyboardType,
      this.validator,
      this.autoFocus = false,
      this.enabled = true,
      this.onEditingComplete,
      this.onTapOutside,
      this.focusNode,
      this.inputFormatter});

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
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        readOnly: isReadOnly,
        decoration: InputDecoration(
          border: getOutlinedBorder(),
          enabledBorder: getEnabledBorder(color),
          focusedBorder: getFocusedBorder(color),
          errorBorder: getErrorBorder(),

          // errorStyle: const TextStyle(fontSize: 8),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          floatingLabelStyle: TextStyle(color: color),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 10),
          hintText: hintText,
          labelText: hintText,
        ),
      ),
    );
  }
}

OutlineInputBorder getOutlinedBorder() => const OutlineInputBorder();

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
