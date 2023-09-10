import 'package:wolog/database/table/mappable_entity.dart';

class Performance implements MappableEntity {
  final String exerciseName;
  final int timestamp;
  final int sets;
  final int reps;
  final String? description;

  const Performance({
    required this.exerciseName,
    required this.timestamp,
    required this.sets,
    required this.reps,
    required this.description
  });

  Performance.fromMap(Map<String, Object?> map) : 
    exerciseName = map['ExerciseName'] as String,
    timestamp = map['Timestamp'] as int,
    sets = map['Sets'] as int,
    reps = map['Reps'] as int,
    description = map['Description'] as String;
  
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

List<Performance> getPerformanceList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Performance.fromMap(l[i]));