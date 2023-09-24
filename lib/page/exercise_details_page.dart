import 'package:flutter/material.dart';

import '../model/exercise.dart';

class ExerciseDetailsPage extends StatefulWidget {
  final ExerciseModel _exerciseModel;
  const ExerciseDetailsPage(final ExerciseModel exerciseModel, {super.key}) : 
    _exerciseModel = exerciseModel; 

  @override
  State<StatefulWidget> createState() => _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> {

  @override
  Widget build(final BuildContext context) =>
    Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(widget._exerciseModel.name)));
}