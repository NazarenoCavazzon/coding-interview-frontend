import 'package:flutter_test/flutter_test.dart';

import 'src/helpers/formatters_test.dart' as formatters_test;
import 'src/helpers/layout_test.dart' as layout_test;

void main() {
  group('UI Package Tests', () {
    group('Helpers', () {
      formatters_test.main();
      layout_test.main();
    });
  });
}
