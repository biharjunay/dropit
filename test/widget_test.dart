import 'package:flutter_test/flutter_test.dart';

import 'package:app_ar/main.dart';

void main() {
  testWidgets('opens the 3D model catalog', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('DROP '), findsOneWidget);
    expect(find.text('Scan'), findsOneWidget);
    expect(find.text('Daftar'), findsOneWidget);
    expect(find.text('Petunjuk'), findsOneWidget);

    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    expect(find.text('Daftar Model'), findsOneWidget);
    expect(find.text('Jalan'), findsOneWidget);
    expect(find.text('Lamp Post'), findsOneWidget);
    expect(find.text('Mobil'), findsOneWidget);
    expect(find.text('Pohon'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Rumah'), 200);
    expect(find.text('Rumah'), findsOneWidget);
  });
}
