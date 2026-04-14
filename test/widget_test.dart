import 'package:flutter_test/flutter_test.dart';
import 'package:lottery_app/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Check if app loads
    expect(find.byType(MyApp), findsOneWidget);
  });
}
