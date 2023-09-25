import 'package:tuple/tuple.dart';

import '../model/exercise.dart';

abstract class EditExerciseStrategy {
  String getEditLabel();
  String? getIconName();
  String? getName();
  String? getBodyPositioningName();
  String? getDescription();
  String? getEquipmentName();
  List<Tuple2<String?, String>> getExerciseMuscleInvolvement();
  void setIconName(final String? name);
  void setName(final String name);
  void setBodyPositioningName(final String name);
  void setDescription(final String? description);
  void setEquipmentName(final String? name);
  void addMuscleInvolvement(final Tuple2<String?, String> pair);
  void delMuscleInvolvement(final Tuple2<String?, String> pair);
  void apply();
}

class AddExerciseStrategy implements EditExerciseStrategy {
  String? name;
  String? bodyPositioningName;
  String? equipmentName;
  String? iconName;
  String? description;
  List<Tuple2<String?, String>>? pair;

  @override
  void addMuscleInvolvement(final Tuple2<String?, String> pair) {
    // TODO: implement addMuscleInvolvement
  }

  @override
  void apply() {
    // TODO: implement apply
  }

  @override
  void delMuscleInvolvement(final Tuple2<String?, String> pair) {
    // TODO: implement delMuscleInvolvement
  }

  @override
  String? getBodyPositioningName() {
    // TODO: implement getBodyPositioningName
    throw UnimplementedError();
  }

  @override
  String? getDescription() {
    // TODO: implement getDescription
    throw UnimplementedError();
  }

  @override
  String getEditLabel() {
    // TODO: implement getEditLabel
    throw UnimplementedError();
  }

  @override
  String? getEquipmentName() {
    // TODO: implement getEquipmentName
    throw UnimplementedError();
  }

  @override
  List<Tuple2<String?, String>> getExerciseMuscleInvolvement() {
    // TODO: implement getExerciseMuscleInvolvement
    throw UnimplementedError();
  }

  @override
  String? getIconName() {
    // TODO: implement getIconName
    throw UnimplementedError();
  }

  @override
  String? getName() {
    // TODO: implement getName
    throw UnimplementedError();
  }

  @override
  void setBodyPositioningName(final String name) {
    // TODO: implement setBodyPositioningName
  }

  @override
  void setDescription(final String? description) {
    // TODO: implement setDescription
  }

  @override
  void setEquipmentName(final String? name) {
    // TODO: implement setEquipmentName
  }

  @override
  void setIconName(final String? name) {
    // TODO: implement setIconName
  }

  @override
  void setName(final String name) {
    // TODO: implement setName
  }

}

class ChangeExerciseStrategy implements EditExerciseStrategy {
  final ExerciseModel _existingExerciseModel;
  final ExerciseModel _changedExerciseModel;

  ChangeExerciseStrategy(final ExerciseModel exerciseModel) :
    _existingExerciseModel = exerciseModel,
    _changedExerciseModel = exerciseModel;

  @override
  void addMuscleInvolvement(final Tuple2<String?, String> pair) {
    // TODO: implement addMuscleInvolvement
  }

  @override
  void apply() {
    // TODO: implement apply
  }

  @override
  void delMuscleInvolvement(final Tuple2<String?, String> pair) {
    // TODO: implement delMuscleInvolvement
  }

  @override
  String? getBodyPositioningName() {
    // TODO: implement getBodyPositioningName
    throw UnimplementedError();
  }

  @override
  String? getDescription() {
    // TODO: implement getDescription
    throw UnimplementedError();
  }

  @override
  String getEditLabel() {
    // TODO: implement getEditLabel
    throw UnimplementedError();
  }

  @override
  String? getEquipmentName() {
    // TODO: implement getEquipmentName
    throw UnimplementedError();
  }

  @override
  List<Tuple2<String?, String>> getExerciseMuscleInvolvement() {
    // TODO: implement getExerciseMuscleInvolvement
    throw UnimplementedError();
  }

  @override
  String? getIconName() {
    // TODO: implement getIconName
    throw UnimplementedError();
  }

  @override
  String? getName() {
    // TODO: implement getName
    throw UnimplementedError();
  }

  @override
  void setBodyPositioningName(final String name) {
    // TODO: implement setBodyPositioningName
  }

  @override
  void setDescription(final String? description) {
    // TODO: implement setDescription
  }

  @override
  void setEquipmentName(final String? name) {
    // TODO: implement setEquipmentName
  }

  @override
  void setIconName(final String? name) {
    // TODO: implement setIconName
  }

  @override
  void setName(final String name) {
    // TODO: implement setName
  }

}