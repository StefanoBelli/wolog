import 'package:flutter/material.dart';

import 'exercise.dart';
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
                onPressed: () => pushExercisePage(context),
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