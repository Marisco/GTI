import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormatarCPF extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + '.');
      if (newValue.selection.end >= 3) selectionIndex++;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '.');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 10) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 9)+'-');
      if (newValue.selection.end >= 9) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(9, usedSubstringIndex = 10));
      if (newValue.selection.end >= 10) selectionIndex++;
    }    
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}