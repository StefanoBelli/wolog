import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolog/page/no_db_found_page.dart';

void main() {
  testWidgets('Ensure all required elements are there', (final tester) async {
    await tester.pumpWidget(const MaterialApp(home: NoDbFoundPage())); 
    expect(find.text('No database found'), findsOneWidget);
    expect(find.text('Create new database'), findsOneWidget);
    expect(find.text('Import existing database...'), findsOneWidget);
  });
}