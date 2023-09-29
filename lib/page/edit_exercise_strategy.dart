import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';

import '../model/exercise.dart';

abstract class EditExerciseStrategy {
  String getEditLabel();
  Icon getApplyActionIcon();
  String? getIconName();
  String? getName();
  String? getBodyPositioningName();
  String? getDescription();
  String? getEquipmentName();
  void setIconName(final String? name);
  void setName(final String name);
  void setBodyPositioningName(final String name);
  void setDescription(final String? description);
  void setEquipmentName(final String? name);
  void addMuscleInvolvement(final Tuple2<String, String?> pair);
  void delMuscleInvolvement(final Tuple2<String, String?> pair);
  void apply();
}

class AddExerciseStrategy implements EditExerciseStrategy {
  String? _name;
  String? _bodyPositioningName;
  String? _equipmentName;
  String? _iconName;
  String? _description;
  List<Tuple2<String, String?>>? _pairs;

  @override
  void apply() {
    // TODO: implement apply
  }

  @override
  void addMuscleInvolvement(final Tuple2<String, String?> pair) {
    if(_pairs == null) {
      _pairs = [ pair ];
      return;
    }

    _pairs!.add(pair);
  }

  @override
  void delMuscleInvolvement(final Tuple2<String, String?> pair) {
    for(var i = 0; i < _pairs!.length; ++i) {
      if(pair == _pairs![i]) {
        _pairs!.removeAt(i);
        return;
      }
    }
  }

  @override
  String? getBodyPositioningName() =>
      null;

  @override
  String? getDescription() =>
      null;

  @override
  String getEditLabel() =>
      'Add new';

  @override
  String? getEquipmentName() =>
      null;

  @override
  String? getIconName() =>
      null;

  @override
  String? getName() =>
      null;

  @override
  void setBodyPositioningName(final String name) =>
      _bodyPositioningName = name;

  @override
  void setDescription(final String? description) =>
      _description = description;

  @override
  void setEquipmentName(final String? name) =>
      _equipmentName = name;

  @override
  void setIconName(final String? name) =>
      _iconName = name;

  @override
  void setName(final String name) =>
      _name = name;

  @override
  Icon getApplyActionIcon() =>
      const Icon(Icons.add);

}

class ChangeExerciseStrategy implements EditExerciseStrategy {
  final ExerciseModel _existingExerciseModel;
  final ExerciseModel _changedExerciseModel;
  final _miToAdd = <Tuple2<String, String?>>[];
  final _miToDel = <Tuple2<String, String?>>[];

  ChangeExerciseStrategy(final ExerciseModel exerciseModel) :
    _existingExerciseModel = exerciseModel,
    _changedExerciseModel = exerciseModel;

  @override
  void apply() {
    // TODO: implement apply
  }

  @override
  void addMuscleInvolvement(final Tuple2<String, String?> pair) {
    for(var i = 0; i < _miToDel.length; ++i) {
      if(_miToDel[i] == pair) {
        _miToDel.removeAt(i);
        return;
      }
    }

    _miToAdd.add(pair);
  }

  @override
  void delMuscleInvolvement(final Tuple2<String, String?> pair) {
    for(var i = 0; i < _miToAdd.length; ++i) {
      if(_miToAdd[i] == pair) {
        _miToAdd.removeAt(i);
        return;
      }
    }

    _miToDel.add(pair);
  }

  @override
  String? getBodyPositioningName() =>
      _existingExerciseModel.bodyPositioningName;

  @override
  String? getDescription() =>
      _existingExerciseModel.description;

  @override
  String getEditLabel() =>
      'Edit';

  @override
  String? getEquipmentName() =>
      _existingExerciseModel.equipmentName;

  @override
  String? getIconName() =>
      _existingExerciseModel.iconName;

  @override
  String? getName() =>
      _existingExerciseModel.name;

  @override
  void setBodyPositioningName(final String name) =>
      _changedExerciseModel.bodyPositioningName = name;

  @override
  void setDescription(final String? description) =>
      _changedExerciseModel.description = description;

  @override
  void setEquipmentName(final String? name) =>
      _changedExerciseModel.equipmentName = name;

  @override
  void setIconName(final String? name) =>
      _changedExerciseModel.iconName = name;

  @override
  void setName(final String name) =>
      _changedExerciseModel.name = name;

  @override
  Icon getApplyActionIcon() =>
      const Icon(Icons.edit);

}