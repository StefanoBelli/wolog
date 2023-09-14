import 'package:wolog/database/table/mappable_entity.dart';

class Performance implements MappableEntity {
  static const String sessionDateTimestampKey = "SessionDateTimestamp";
  static const String sessionExerciseNameKey = "SessionExerciseName";
  static const String sessionExerciseLeaningPositionNameKey = "SessionExerciseLeaningPositionName";
  static const String sessionExerciseLeaningPositionEquipmentNameKey = "SessionExerciseLeaningPositionEquipmentName";
  static const String setNoKey = "SetNo";
  static const String repsKey = "Reps";
  static const String weightKgKey = "WeightKg";
  static const String descriptionKey = "Description";

  final int sessionDateTimestamp;
  final String sessionExerciseName;
  final String sessionExerciseLeaningPositionName;
  final String? sessionExerciseLeaningPositionEquipmentName;
  final int setNo;
  final int reps;
  final double? weightKg;
  final String? description;

  const Performance({
    required this.sessionDateTimestamp,
    required this.sessionExerciseName,
    required this.sessionExerciseLeaningPositionName,
    required this.sessionExerciseLeaningPositionEquipmentName,
    required this.setNo,
    required this.reps,
    required this.weightKg,
    required this.description
  });

  Performance.fromMap(Map<String, Object?> m) :
    sessionDateTimestamp = m[sessionDateTimestampKey] as int,
    sessionExerciseName = m[sessionExerciseNameKey] as String,
    sessionExerciseLeaningPositionName = m[sessionExerciseLeaningPositionNameKey] as String,
    sessionExerciseLeaningPositionEquipmentName = m[sessionExerciseLeaningPositionEquipmentNameKey] as String,
    setNo = m[setNoKey] as int,
    reps = m[repsKey] as int,
    weightKg = m[weightKgKey] as double,
    description = m[descriptionKey] as String;

  @override
  List<String> getPrimaryKeyInMap() {
    return [ sessionDateTimestampKey, sessionExerciseNameKey, sessionExerciseLeaningPositionNameKey, sessionExerciseLeaningPositionEquipmentNameKey, setNoKey ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      sessionDateTimestampKey : sessionDateTimestamp,
      sessionExerciseNameKey : sessionExerciseName,
      sessionExerciseLeaningPositionNameKey : sessionExerciseLeaningPositionName,
      sessionExerciseLeaningPositionEquipmentNameKey : sessionExerciseLeaningPositionEquipmentName,
      setNoKey : setNo,
      repsKey : reps,
      weightKgKey : weightKg,
      descriptionKey : description
    };
  }
}

List<Performance> getPerformanceList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Performance.fromMap(l[i]));