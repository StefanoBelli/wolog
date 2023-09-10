import 'package:wolog/database/table/mappable_entity.dart';

class ExerciseMuscleInvolvement implements MappableEntity {
  final String? musclePartName;
  final String muscleName;
  final String exerciseName;
  final String? description;

  const ExerciseMuscleInvolvement({
    required this.musclePartName,
    required this.muscleName,
    required this.exerciseName,
    required this.description
  });

  ExerciseMuscleInvolvement.fromMap(Map<String, Object?> map) :
    musclePartName = map['MusclePartName'] as String,
    muscleName = map['MuscleName'] as String,
    exerciseName = map['ExerciseName'] as String,
    description = map['Description'] as String;
  
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

List<ExerciseMuscleInvolvement> getExerciseMuscleInvolvementList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => ExerciseMuscleInvolvement.fromMap(l[i]));
