import 'package:flutter/material.dart';

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
  final _nameEditingController = TextEditingController();
  final _descriptionEditingController = TextEditingController();

  var _equipments = <EquipmentModel>[];
  var _allMuscles = <MuscleModel>[];
  var _bodyPositionings = <BodyPositioningModel>[];
  var _musclesInvolved;

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
            .then((final l) => setState(() => _musclesInvolved = l));
      _nameEditingController.text = exerciseName;
    }

    if(description != null) {
      _descriptionEditingController.text = description;
    }

    Repository().fetchAllEquipments()
        .then((final l) => setState(() => _equipments = l));

    Repository().fetchAllMuscles()
        .then((final l) => setState(() => _allMuscles = l));

    Repository().fetchAllBodyPositionings()
        .then((final l) => setState(() => _bodyPositionings = l));
  }
      
  @override
  Widget build(final BuildContext context) =>
    Scaffold(
      appBar: AppBar(
        title: Text('${widget._strategy.getEditLabel()} exercise'),
        actions: [
          IconButton(
            onPressed: () {}, //TODO
            icon: widget._strategy.getApplyActionIcon(),
          )
        ],
      ),
      body: Column(
        children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {}, //TODO
                  icon: buildIconFromName(widget._strategy.getIconName()),),
                Column(
                  children: [
                    const Text('Name'),
                    TextField(
                      controller: _nameEditingController,
                      decoration: const InputDecoration(
                        labelText: 'Enter exercise name...'))
                  ],
                )
              ],
            ),
            const Text('Body positioning'),
            Row(
              children: [
                DropdownMenu(
                  onSelected: (final e) {}, //TODO
                  dropdownMenuEntries: [
                    for(var i = 0; i < _bodyPositionings.length; ++i)
                      DropdownMenuEntry(
                          value: i,
                          label: _bodyPositionings[i].name)
                  ]
                ),
                IconButton(
                  onPressed: (){}, //TODO
                  icon: const Icon(Icons.add))
              ],
            ),
            const Text('Equipment'),
            Row(
              children: [
                DropdownMenu(
                  onSelected: (final e) {}, //TODO
                  dropdownMenuEntries: [
                    for(var i = 0; i < _equipments.length; ++i)
                      DropdownMenuEntry(
                          value: i,
                          label: _equipments[i].name)
                  ]
                ),
                IconButton(
                  onPressed: () {}, //TODO
                  icon: const Icon(Icons.add))
              ],
            ),
            Row(
              children: [
                const Text('Involved muscles'),
                IconButton(
                  icon: const Icon(Icons.add), 
                  onPressed: () {}, //TODO
                )
              ],
            ),
            ListView.builder(
              itemCount: _allMuscles.length,
              itemBuilder: (final _, final index) {
                final muscleParts = _allMuscles[index].muscleParts;
                ListView? lvChildren;

                if(muscleParts != null) {
                  lvChildren = ListView(
                      children: <Widget>[
                        for(var i = 0; i < muscleParts.length; ++i)
                          ListTile(
                              leading: Checkbox(
                                value: false, //TODO
                                onChanged: (final c) {}, //TODO
                              ),
                              title: Text(muscleParts[i].name))
                      ]
                  );
                }

                return Row(
                    children: [
                      ListTile(
                          leading: Checkbox(
                            value: false, //TODO
                            onChanged: (final c) {}, //TODO
                          ),
                          title: Text(_allMuscles[index].name)
                      ),
                      if(lvChildren != null) lvChildren
                    ]
                );
              }
            ),
            const Text('Description'),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter description here...',
              ),
              keyboardType: TextInputType.text,
              controller: _descriptionEditingController
            )
        ]
      )
    );
}