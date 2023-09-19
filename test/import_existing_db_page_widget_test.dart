import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolog/page/import_existing_db_page.dart';


void main() {
  testWidgets('Ensure all required elements are there', (final tester) async {
    await tester.pumpWidget(const MaterialApp(home: ImportExistingDbPage()));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byWidgetPredicate((final w) => w is Radio), findsNWidgets(3));
    expect(find.text('Import existing database'), findsOneWidget);
    expect(find.text('Get wolog reccomended database'), findsOneWidget);
    expect(find.text('Type custom URL'), findsOneWidget);
    expect(find.text('Get user-customized database (using HTTPS)'), findsOneWidget);
    expect(find.text('Copy user-customized database from internal storage'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });
}