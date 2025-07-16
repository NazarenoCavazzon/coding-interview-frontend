import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/helpers/formatters.dart';

void main() {
  group('CommaToDecimalFormatter', () {
    late CommaToDecimalFormatter formatter;

    setUp(() {
      formatter = CommaToDecimalFormatter();
    });

    test('replaces comma with period', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1,5');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals('1.5'));
    });

    test('replaces multiple commas with periods', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1,5,3');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals('1.5.3'));
    });

    test('preserves text without commas', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '123.45');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals('123.45'));
    });

    test('handles empty text', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue.empty;

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals(''));
    });

    test('handles text with only commas', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: ',,,');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals('...'));
    });

    test('preserves selection when replacing commas', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(
        text: '1,5',
        selection: TextSelection.collapsed(offset: 3),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals('1.5'));
      expect(
        result.selection,
        equals(const TextSelection.collapsed(offset: 3)),
      );
    });

    test('preserves composing when replacing commas', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(
        text: '1,5',
        composing: TextRange(start: 0, end: 3),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals('1.5'));
      expect(result.composing, equals(const TextRange(start: 0, end: 3)));
    });

    test('handles mixed content with commas', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: 'abc,123,def');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals('abc.123.def'));
    });

    test('handles decimal number with comma', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '123,456');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals('123.456'));
    });

    test('preserves other TextEditingValue properties', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(
        text: '1,5',
        selection: TextSelection.collapsed(offset: 2),
        composing: TextRange(start: 0, end: 2),
      );

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, equals('1.5'));
      expect(result.selection, equals(newValue.selection));
      expect(result.composing, equals(newValue.composing));
    });
  });
}
