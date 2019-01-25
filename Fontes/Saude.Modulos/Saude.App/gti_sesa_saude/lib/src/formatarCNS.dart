import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormatarCNS extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + '-');
      if (newValue.selection.end >= 3) selectionIndex++;
    }
    if (newTextLength >= 8) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 7) + '-');
      if (newValue.selection.end >= 7) selectionIndex++;
    }
    if (newTextLength >= 12) {
      newText.write(newValue.text.substring(7, usedSubstringIndex = 11) + '-');
      if (newValue.selection.end >= 11) selectionIndex++;
    }
    if (newTextLength >= 15) {
      newText.write(newValue.text.substring(11, usedSubstringIndex = 15));
      if (newValue.selection.end >= 15) selectionIndex++;
    }
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
