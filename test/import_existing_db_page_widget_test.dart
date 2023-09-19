import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wolog/page/import_existing_db_page.dart';
import 'package:http/http.dart' as http;

import 'import_existing_db_page_widget_test.mocks.dart';

@GenerateMocks([http.Request, http.StreamedResponse, FilePicker])
void main() {
  testWidgets('Ensure all required elements are there', (final tester) async {
    await tester.pumpWidget(const MaterialApp(home: ImportExistingDbPage()));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byKey(const Key('radio-importdb-1')), findsOneWidget);
    expect(find.byKey(const Key('radio-importdb-2')), findsOneWidget);
    expect(find.byKey(const Key('radio-importdb-1')), findsOneWidget);
    expect(find.text('Import existing database'), findsOneWidget);
    expect(find.text('Get wolog reccomended database'), findsOneWidget);
    expect(find.text('Get user-customized database (using HTTPS)'), findsOneWidget);
    expect(find.text('Copy user-customized database from internal storage'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });
}