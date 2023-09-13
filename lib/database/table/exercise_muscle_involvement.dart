import 'package:wolog/database/table/mappable_entity.dart';

class ExerciseMuscleInvolvement implements MappableEntity {
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
    musclePartName = m['MusclePartName'] as String,
    muscleName = m['MuscleName'] as String,
    exerciseName = m['ExerciseName'] as String,
    exerciseLeaningPositionName = m['ExerciseLeaningPositionName'] as String,
    exerciseLeaningPositionEquipmentName = m['ExerciseLeaningPositionEquipmentName'] as String,
    description = m['Description'] as String;
    
  @override
  List<String> getPrimaryKeyInMap() {
    return [ 'MusclePartName', 'MuscleName', 'ExerciseName', 'ExerciseLeaningPositionName', 'ExerciseLeaningPositionEquipmentName' ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'MusclePartName' : musclePartName,
      'MuscleName' : muscleName,
      'ExerciseName' : exerciseName,
      'ExerciseLeaningPositionName' : exerciseLeaningPositionName,
      'ExerciseLeaningPositionEquipmentName' : exerciseLeaningPositionEquipmentName,
      'Description' : description
    };
  }
}

List<ExerciseMuscleInvolvement> getExerciseMuscleInvolvementList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => ExerciseMuscleInvolvement.fromMap(l[i]));
