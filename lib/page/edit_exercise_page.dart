import 'package:flutter/material.dart';

import '../model/exercise.dart';

class EditExercisePage extends StatefulWidget {
  final ExerciseModel? _exerciseModel;
  const EditExercisePage({final ExerciseModel? exerciseModel, super.key}) : 
    _exerciseModel = exerciseModel;

  @override
  State<StatefulWidget> createState() => _EditExercisePageState();
}

class _EditExercisePageState extends State<StatefulWidget> {

  @override
  Widget build(final BuildContext context) =>
    Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('add new exercise'),));
}