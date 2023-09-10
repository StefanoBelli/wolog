import 'package:wolog/database/table/mappable_entity.dart';

class ExerciseMuscleInvolvement implements MappableEntity {
  final String musclePartName;
  final String muscleName;
  final String exerciseName;
  final String description;

  const ExerciseMuscleInvolvement({
    required this.musclePartName,
    required this.muscleName,
    required this.exerciseName,
    required this.description
  });
  
  @override
  Map<String, Object?> toMap() {
    return {
      'MusclePartName' : musclePartName,
      'MuscleName' : muscleName,
      'ExerciseName' : exerciseName,
      'Description' : description
    };
  }
  
  @override
  List<int> getPrimaryKeyIndexesInMap() {
    return [ 0, 1, 2 ];
  }
}