import 'package:flutter/material.dart';

import '../model/exercise.dart';
import '../repository.dart';
import 'util/icon.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<StatefulWidget> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<StatefulWidget> {
  var _exs = <ExerciseModel>[];

  @override
  void initState() {
    super.initState();
    _refreshExs();
  }

  void _refreshExs() {
    Repository().fetchAllExercises().then((final l) {
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
        itemBuilder: (final _, final index) {
          var eqDesc = _exs[index].bodyPositioningName;
          if(_exs[index].equipmentName != null) {
            eqDesc += ', ${_exs[index].bodyPositioningName}';
          }

          return Card(
            child: SizedBox(
              width: 300,
              height: 100,
              child: Row(
                children: [
                  buildIconFromName(_exs[index].iconName),
                  Column(
                    children: [
                      Text(_exs[index].name),
                      Text(eqDesc),
                      Text(_exs[index].description ?? 'No description provided')
                    ],),
                  IconButton(
                    onPressed: () {},  
                    icon: const Icon(Icons.arrow_forward),)
                ],
              )));
        }
      );
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