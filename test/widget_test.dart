import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Widget test harness smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Sahara Test Harness')),
        ),
      ),
    );

    expect(find.text('Sahara Test Harness'), findsOneWidget);
  });
}
