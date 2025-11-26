import 'package:flutter_test/flutter_test.dart';
import 'package:realtodo/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ThemetoggleServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
