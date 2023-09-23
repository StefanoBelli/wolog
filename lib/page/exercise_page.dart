import 'package:flutter/material.dart';

import '../database/table/exercise.dart';
import '../repository/exercise.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<StatefulWidget> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<StatefulWidget> {
  var _exs = <Exercise>[];

  @override
  void initState() {
    super.initState();
    _refreshExs();
  }

  void _refreshExs() {
    ExerciseRepository().fetchAll().then((final l) {
      setState(() {
        _exs = l;
      });
    });
  }

  Widget _getBody() {
    if(_exs.isEmpty) {
      return const Center(
        child: Text('No items')
      );
    } else {
      return ListView.builder(
        itemCount: _exs.length,
        itemBuilder: (final _, final index) => null);
    }
  }

  @override
  Widget build(final BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: const Text('Exercises')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: _getBody() 
    );
}