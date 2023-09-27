import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../model/body_positioning.dart';
import '../model/equipment.dart';
import '../model/muscle.dart';
import '../repository.dart';
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
  final descriptionEditingController = TextEditingController();

  var equipments = <EquipmentModel>[];
  var allMuscles = <MuscleModel>[];
  var bodyPositionings = <BodyPositioningModel>[];
  var musclesInvolved = null;

  @override
  void initState() {
    super.initState();
    final exerciseName = widget._strategy.getName();
    final description = widget._strategy.getDescription();

    if(exerciseName != null) {
      Repository().fetchMusclesInvolvedInExerciseByName(
          exerciseName,
          widget._strategy.getEquipmentName(),
          widget._strategy.getBodyPositioningName()!)
            .then((final l) => setState(() => musclesInvolved = l));
      nameEditingController.text = exerciseName;
    }

    if(description != null) {
      descriptionEditingController.text = description;
    }

    Repository().fetchAllEquipments()
        .then((final l) => setState(() => equipments = l));

    Repository().fetchAllMuscles()
        .then((final l) => setState(() => allMuscles = l));

    Repository().fetchAllBodyPositionings()
        .then((final l) => setState(() => bodyPositionings = l));
  }
      
  @override
  Widget build(final BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('${widget._strategy.getEditLabel()} exercise'),
        actions: [ IconButton(
          onPressed: () {},
          icon: widget._strategy.getApplyActionIcon(),)],
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
            ),
            const Text('Description'),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter description here...',
              ),
              keyboardType: TextInputType.text,
              controller: descriptionEditingController
            )
        ],)
    );
}