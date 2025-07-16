import 'package:flutter/services.dart';

class CommaToDecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(',', '.');
    return newValue.copyWith(text: newText);
  }
}
