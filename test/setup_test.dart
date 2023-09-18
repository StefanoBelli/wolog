import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wolog/main.dart';
import 'package:wolog/page/setup.dart';

void main() {
  setUp(() {
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('test', (final tester) async {
    await tester.pumpWidget(const WologApp());
    expect(find.text('anything'), findsNothing);
  });

  testWidgets('test2', (final tester) async {
    await tester.pumpWidget(const MaterialApp(home: NoDbFoundPage()));
    expect(find.text('No database found'), findsOneWidget);
  });
}