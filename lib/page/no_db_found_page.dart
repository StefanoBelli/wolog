import 'package:flutter/material.dart';

import '../util.dart';
import 'util/push_exercise_page.dart';
import 'import_existing_db_page.dart';

class NoDbFoundPage extends StatelessWidget {
  const NoDbFoundPage({super.key});

  @override
  Widget build(final BuildContext context) =>
    Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              const Text(
                'No database found', 
                style: TextStyle(fontSize: 30)
              ),
              TextButton(
                onPressed: () => pushExercisePage(
                  context,
                  onErrorHook: () => showAppBlockingDialog(
                    context, 
                    'App is blocked, restart.', 
                    'SQL DDL is wrong somewhere, '
                    'please report this bug. Data is cleared.')),
                child: const Text('Create new database')
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (final _) => const ImportExistingDbPage())),
                child: const Text('Import existing database...')
              )
            ])));
}