import 'package:flutter_test/flutter_test.dart';
import 'package:khddam_ma/main.dart';

void main() {
  testWidgets('KhddamApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KhddamApp());
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byType(KhddamApp), findsOneWidget);
  });
}
