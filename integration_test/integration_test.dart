import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app_test.dart' as app_test;
import 'currency_selection_test.dart' as currency_selection_test;
import 'end_to_end_test.dart' as end_to_end_test;
import 'error_handling_test.dart' as error_handling_test;
import 'p2p_quote_flow_test.dart' as p2p_quote_flow_test;
import 'theme_and_localization_test.dart' as theme_and_localization_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Tests', () {
    app_test.main();
    p2p_quote_flow_test.main();
    currency_selection_test.main();
    theme_and_localization_test.main();
    error_handling_test.main();
    end_to_end_test.main();
  });
}
