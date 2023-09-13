import 'package:wolog/database/table/mappable_entity.dart';

class Performance implements MappableEntity {
  final int setId;
  final int sessionDateTimestamp;
  final int sessionExerciseName;
  final int reps;
  final double? weightKg;
  final String? description;

  const Performance({
    required this.setId,
    required this.sessionDateTimestamp,
    required this.sessionExerciseName,
    required this.reps,
    required this.weightKg,
    required this.description
  });

  Performance.fromMap(Map<String, Object?> m) :
    setId = m["SetId"] as int,
    sessionDateTimestamp = m["SessionDateTimestamp"] as int,
    sessionExerciseName = m["SessionExerciseName"] as int,
    reps = m["Reps"] as int,
    weightKg = m["WeightKg"] as double,
    description = m["Description"] as String;

  @override
  List<String> getPrimaryKeyInMap() {
    return [ "SetId", "SessionDateTimestamp", "SessionExerciseName" ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      "SetId" : setId,
      "SessionDateTimestamp" : sessionDateTimestamp,
      "SessionExerciseName" : sessionExerciseName,
      "Reps" : reps,
      "WeightKg" : weightKg,
      "Description" : description
    };
  }
}

List<Performance> getPerformanceList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Performance.fromMap(l[i]));