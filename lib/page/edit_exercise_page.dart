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
  final _nameEditingController = TextEditingController();
  final _descriptionEditingController = TextEditingController();
  final _equipmentDropdownController = TextEditingController();
  final _bodyPositioningDropdownController = TextEditingController();

  var _equipments = <EquipmentModel>[];
  var _allMuscles = <MuscleModel>[];
  var _bodyPositionings = <BodyPositioningModel>[];
  var _musclesInvolved = <Tuple2<String, String?>>[];

  @override
  void initState() {
    super.initState();

    final exerciseName = widget._strategy.getName();
    final description = widget._strategy.getDescription();
    final equipmentName = widget._strategy.getEquipmentName();
    final bodyPositioningName = widget._strategy.getBodyPositioningName();

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

    if(equipmentName != null) {
      _equipmentDropdownController.text = equipmentName;
    }

    if(bodyPositioningName != null) {
      _bodyPositioningDropdownController.text = bodyPositioningName;
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
    WillPopScope(
        child:
          Scaffold(
            appBar: AppBar(
              title: Text('${widget._strategy.getEditLabel()} exercise'),
              actions: [
                IconButton(
                  onPressed: () {}, //TODO
                  icon: const Icon(Icons.edit),
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
                    Flexible(
                        fit: FlexFit.tight,
                        child: TextField(
                            controller: _nameEditingController,
                            decoration: const InputDecoration(
                              hintText: 'Enter exercise name...')))
                  ],
                ),
                const Text('Body positioning'),
                Row(
                  children: [
                    DropdownMenu(
                      enabled: _bodyPositionings.isNotEmpty,
                      enableSearch: false,
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
                      enabled: _equipments.isNotEmpty,
                      enableSearch: false,
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
                const Text('Description'),
                TextField(
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Enter description here...',
                  ),
                  keyboardType: TextInputType.text,
                  controller: _descriptionEditingController
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
                if(_allMuscles.isNotEmpty)
                  Expanded(
                    child: _TwoStepSelector(
                        allMuscles: _allMuscles,
                        initiallyInvolvedMuscles: _musclesInvolved,
                        onAdd: (final t) =>
                            widget._strategy.addMuscleInvolvement(t),
                        onDel: (final t) =>
                            widget._strategy.delMuscleInvolvement(t)
                    )
                  )
                else
                  const Expanded(
                    child: Center(
                        child: Text('No muscles')
                    )
                  )
              ]
            )
          ),
        onWillPop: () async => true
    );
}

class _TwoStepSelector extends StatefulWidget {
  final List<MuscleModel> _allMuscles;
  final List<Tuple2<String,String?>> _changes;
  final void Function(Tuple2<String, String?>) _onAdd;
  final void Function(Tuple2<String, String?>) _onDel;

  const _TwoStepSelector({
    required final List<MuscleModel> allMuscles,
    required final List<Tuple2<String, String?>> initiallyInvolvedMuscles,
    required final void Function(Tuple2<String, String?>) onAdd,
    required final void Function(Tuple2<String, String?>) onDel
  }) :
        _onDel = onDel,
        _onAdd = onAdd,
        _changes = initiallyInvolvedMuscles,
        _allMuscles = allMuscles;

  @override
  State<StatefulWidget> createState() =>
      _TwoStepSelectorState();
}

class _TwoStepSelectorState extends State<_TwoStepSelector> {
  late Widget Function() _builder;
  int _muscleIndex = -1;

  @override
  void initState() {
    super.initState();
    _builder = _buildMain;
  }

  Widget _buildParts() {
    final totalLen = widget._allMuscles[_muscleIndex].muscleParts!.length + 1;
    return ListView.builder(
        itemCount: totalLen,
        itemBuilder: (final _, final index) {
          if(index == totalLen - 1) {
            return ListTile(
              leading: const Icon(Icons.arrow_back_rounded, size: 15),
              title: const Text('Go back'),
              onTap: () => setState(() => _builder = _buildMain),
            );
          }

          var hasChecked = false;
          for(final t in widget._changes) {
            if(
                    t.item1 == widget._allMuscles[_muscleIndex].name &&
                    t.item2 == widget._allMuscles[_muscleIndex].muscleParts![index].name
            ) {
              hasChecked = true;
              break;
            }
          }

          return ListTile(
            leading: Row(
              children: [
                Checkbox(
                  value: hasChecked,
                  onChanged: (final b) {
                    final t = Tuple2(
                        widget._allMuscles[_muscleIndex].name,
                        widget._allMuscles[_muscleIndex].muscleParts![index].name);
                    if(b!) {
                      widget._changes.add(t);
                      widget._onAdd(t);
                    } else {
                      widget._changes.remove(t);
                      widget._onDel(t);
                    }
                  },
                ),
                buildIconFromName(
                    widget._allMuscles[_muscleIndex].muscleParts![index].iconName,
                    sqSize: 15),
              ],
            ),
            title:
              Text(widget._allMuscles[_muscleIndex].muscleParts![index].name),
          );
        }
    );
  }

  Widget _buildMain() =>
      ListView.builder(
        itemCount: widget._allMuscles.length,
        itemBuilder: (final _, final index) {
          var hasChecked = false;
          for(final t in widget._changes) {
            if(t.item1 == widget._allMuscles[index].name) {
              hasChecked = true;
              break;
            }
          }

          var hasParts = false;

          if(widget._allMuscles[index].muscleParts != null) {
            hasParts = widget._allMuscles[index].muscleParts!.isNotEmpty;
          }

          return ListTile(
              leading:
                Row(
                  children: [
                    Checkbox(
                        value: hasChecked,
                        onChanged: (final b) =>
                          setState(() {
                            final t = Tuple2(widget._allMuscles[index].name, null);
                            if(b!) {
                              widget._changes.add(t);
                              widget._onAdd(t);
                            } else {
                              widget._changes.remove(t);
                              widget._onDel(t);
                              for(final st in widget._changes) {
                                if(st.item1 == widget._allMuscles[index].name) {
                                  widget._changes.remove(st);
                                  widget._onDel(st);
                                }
                              }
                            }
                          })),
                    buildIconFromName(
                        widget._allMuscles[index].iconName,
                        sqSize: 15)
                  ],
                ),
              title:
                Text('${widget._allMuscles[index].name}: '
                    "${widget._allMuscles[index].upperBody ? 'upper' : 'lower'}, "
                    "${widget._allMuscles[index].frontal ? 'frontal' : 'posterior'}"),
              subtitle:
                hasParts ? const Text('Parts available') : null,
              onTap:
                hasChecked && hasParts ?
                    () => setState(() {
                      _builder = _buildParts;
                      _muscleIndex = index;
                    }) : null
          );
        }
      );

  @override
  Widget build(final BuildContext _) =>
      _builder();
}