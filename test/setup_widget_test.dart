import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wolog/page/setup.dart';

void main() {
  setUp(() {
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('Ensure all required elements are there', (final tester) async {
    await tester.pumpWidget(const MaterialApp(home: NoDbFoundPage())); 
    expect(find.text('No database found'), findsOneWidget);
    expect(find.text('Create new database'), findsOneWidget);
    expect(find.text('Import existing database...'), findsOneWidget);
  });
}