import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolog/page/import_existing_db_page.dart';


bool _getSemFlag(final WidgetTester t, final SemanticsFlag flg, final Finder f) => 
  t.getSemantics(f).getSemanticsData().hasFlag(flg);

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

  testWidgets('Check UI behaviour when tapping on radio buttons, while not importing a database', (final tester) async {
    await tester.pumpWidget(const MaterialApp(home: ImportExistingDbPage()));

    final allRadios = find.byWidgetPredicate((final w) => w is Radio); 
    final textButton = find.byType(TextButton);

    expect(_getSemFlag(tester, SemanticsFlag.isChecked, allRadios.at(0)), true);
    expect(_getSemFlag(tester, SemanticsFlag.isChecked, allRadios.at(1)), false);
    expect(_getSemFlag(tester, SemanticsFlag.isChecked, allRadios.at(2)), false);
    
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, false);
    
    expect(_getSemFlag(tester, SemanticsFlag.isEnabled, textButton), true);

    await tester.tap(allRadios.at(1));
    await tester.pump();
    
    expect(_getSemFlag(tester, SemanticsFlag.isChecked, allRadios.at(0)), false);
    expect(_getSemFlag(tester, SemanticsFlag.isChecked, allRadios.at(1)), true);
    expect(_getSemFlag(tester, SemanticsFlag.isChecked, allRadios.at(2)), false);
    
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, true);
    
    expect(_getSemFlag(tester, SemanticsFlag.isEnabled, textButton), true);

    await tester.tap(allRadios.at(2));
    await tester.pump();
    
    expect(_getSemFlag(tester, SemanticsFlag.isChecked, allRadios.at(0)), false);
    expect(_getSemFlag(tester, SemanticsFlag.isChecked, allRadios.at(1)), false);
    expect(_getSemFlag(tester, SemanticsFlag.isChecked, allRadios.at(2)), true);
    
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, false);
    
    expect(_getSemFlag(tester, SemanticsFlag.isEnabled, textButton), true);
  });
}