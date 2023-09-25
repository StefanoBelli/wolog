import 'package:flutter/material.dart';

import 'edit_exercise_strategy.dart';
import 'util/icon.dart';

class EditExercisePage extends StatefulWidget {
  final EditExerciseStrategy _strategy;
  const EditExercisePage(final EditExerciseStrategy strategy, {super.key}) : 
    _strategy = strategy;

  @override
  State<StatefulWidget> createState() => _EditExercisePageState();
}

class _EditExercisePageState extends State<EditExercisePage> {
  final nameEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final exerciseName = widget._strategy.getName();
    if(exerciseName != null) {
      nameEditingController.text = exerciseName;
    }
  }
      
  @override
  Widget build(final BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('${widget._strategy.getEditLabel()} exercise')
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: buildIconFromName(widget._strategy.getIconName()),),
              Column(
                children: [
                  const Text('Name'),
                  TextField(
                    controller: nameEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Enter exercise name...'
                    )
                  )
                ],)
            ],),
            const Text('Body positioning'),
            Row(
              children: [
                const DropdownMenu(
                  dropdownMenuEntries: []),
                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(Icons.add))
              ],),
            const Text('Equipment'),
            Row(
              children: [
                const DropdownMenu(
                  dropdownMenuEntries: []),
                IconButton(
                  onPressed: (){}, 
                  icon: const Icon(Icons.add))
              ],),
            Row(
              children: [
                const Text('Involved muscles'),
                IconButton(
                  icon: const Icon(Icons.add), 
                  onPressed: () {},)
              ],),
            ListView.builder(
              itemCount: 0,
              itemBuilder: (final _, final index) => null
            )
        ],)
    );
}