import 'package:wolog/database/table/mappable_entity.dart';

class ExerciseMuscleInvolvement implements MappableEntity {
  static const String musclePartNameKey = "MusclePartName";
  static const String muscleNameKey = "MuscleName";
  static const String exerciseNameKey = "ExerciseName";
  static const String exerciseLeaningPositionNameKey = "ExerciseLeaningPositionName";
  static const String exerciseLeaningPositionEquipmentNameKey = "ExerciseLeaningPositionEquipmentName";
  static const String descriptionKey = "Description";

  final String? musclePartName;
  final String muscleName;
  final String exerciseName;
  final String exerciseLeaningPositionName;
  final String? exerciseLeaningPositionEquipmentName;
  final String? description;

  const ExerciseMuscleInvolvement({
    required this.musclePartName,
    required this.muscleName,
    required this.exerciseName,
    required this.exerciseLeaningPositionName,
    required this.exerciseLeaningPositionEquipmentName,
    required this.description
  });

  ExerciseMuscleInvolvement.fromMap(Map<String, Object?> m) :
    musclePartName = m[musclePartNameKey] as String,
    muscleName = m[muscleNameKey] as String,
    exerciseName = m[exerciseNameKey] as String,
    exerciseLeaningPositionName = m[exerciseLeaningPositionNameKey] as String,
    exerciseLeaningPositionEquipmentName = m[exerciseLeaningPositionEquipmentNameKey] as String,
    description = m[descriptionKey] as String;
    
  @override
  List<String> getPrimaryKeyInMap() {
    return [ musclePartNameKey, muscleNameKey, exerciseNameKey, exerciseLeaningPositionNameKey, exerciseLeaningPositionEquipmentNameKey ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      musclePartNameKey : musclePartName,
      muscleNameKey : muscleName,
      exerciseNameKey : exerciseName,
      exerciseLeaningPositionNameKey : exerciseLeaningPositionName,
      exerciseLeaningPositionEquipmentNameKey : exerciseLeaningPositionEquipmentName,
      descriptionKey : description
    };
  }
}

List<ExerciseMuscleInvolvement> getExerciseMuscleInvolvementList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => ExerciseMuscleInvolvement.fromMap(l[i]));
