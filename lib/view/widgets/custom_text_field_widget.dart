import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnChanged = Function(String)?;

class NoKeyboardEditableText extends EditableText {
  NoKeyboardEditableText({
    required TextEditingController controller,
    required TextStyle style,
    required Color cursorColor,
    bool autofocus = true,
    Color? selectionColor,
    OnChanged onChanged,
  }) : super(
          controller: controller,
          focusNode: NoKeyboardEditableTextFocusNode(),
          style: style,
          cursorColor: cursorColor,
          autofocus: autofocus,
          selectionColor: selectionColor,
          backgroundCursorColor: Colors.black,
          onChanged: onChanged,
          keyboardType: TextInputType.multiline,
          
          // autofillClient: autofillClient.autofill(newEditingValue)
        );

  @override
  EditableTextState createState() {
    return NoKeyboardEditableTextState();
  }
}

class NoKeyboardEditableTextState extends EditableTextState {
  @override
  void requestKeyboard() {
    super.requestKeyboard();
    //hide keyboard
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevents keyboard from showing on first focus
    return false;
  }
}


class NoKeyboardEditableTex extends EditableText {
  NoKeyboardEditableTex({
    required TextEditingController controller,
    required TextStyle style,
    required Color cursorColor,
    bool autofocus = true,
    Color? selectionColor,
    OnChanged onChanged,
  }) : super(
          controller: controller,
          focusNode: NoKeyboardEditableTextFocusNod(),
          style: style,
          cursorColor: cursorColor,
          autofocus: autofocus,
          selectionColor: selectionColor,
          backgroundCursorColor: Colors.black,
          onChanged: onChanged,
          keyboardType: TextInputType.multiline,
          
          // autofillClient: autofillClient.autofill(newEditingValue)
        );

  @override
  EditableTextState createState() {
    return NoKeyboardEditableTextStat();
  }
}

class NoKeyboardEditableTextStat extends EditableTextState {
  @override
  void requestKeyboard() {
    super.requestKeyboard();
    //hide keyboard
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class NoKeyboardEditableTextFocusNod extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevents keyboard from showing on first focus
    return false;
  }
}

