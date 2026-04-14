import 'package:flutter_test/flutter_test.dart';
import 'package:lottery_app/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // If app crashes, test fails automatically
    expect(true, true);
  });
}
