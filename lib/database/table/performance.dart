import 'package:wolog/database/table/mappable_entity.dart';

class Performance implements MappableEntity {
  final String exerciseName;
  final int timestamp;
  final int sets;
  final int reps;
  final String description;

  const Performance({
    required this.exerciseName,
    required this.timestamp,
    required this.sets,
    required this.reps,
    required this.description
  });
  
  @override
  Map<String, Object?> toMap() {
    return {
      'ExerciseName' : exerciseName,
      'Timestamp' : timestamp,
      'Sets' : sets,
      'Reps' : reps,
      'Description' : description
    };
  }
  
  @override
  List<int> getPrimaryKeyIndexesInMap() {
    return [ 0, 1 ];
  }
}