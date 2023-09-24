import 'package:flutter/material.dart';

class AddNewExercisePage extends StatefulWidget {
  const AddNewExercisePage({super.key});

  @override
  State<StatefulWidget> createState() => _AddNewExercisePageState();
}

class _AddNewExercisePageState extends State<StatefulWidget> {

  @override
  Widget build(final BuildContext context) =>
    Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("add new exercise"),));
}