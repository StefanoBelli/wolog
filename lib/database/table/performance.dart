import 'package:wolog/database/table/mappable_entity.dart';

class Performance implements MappableEntity {
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
    sessionDateTimestamp = m["SessionDateTimestamp"] as int,
    sessionExerciseName = m["SessionExerciseName"] as String,
    sessionExerciseLeaningPositionName = m["SessionExerciseLeaningPositionName"] as String,
    sessionExerciseLeaningPositionEquipmentName = m["SessionExerciseLeaningPositionEquipmentName"] as String,
    setNo = m["SetNo"] as int,
    reps = m["Reps"] as int,
    weightKg = m["WeightKg"] as double,
    description = m["Description"] as String;

  @override
  List<String> getPrimaryKeyInMap() {
    return [ "SessionDateTimestamp", "SessionExerciseName", "SessionExerciseLeaningPositionName", "SessionExerciseLeaningPositionEquipmentName", "SetNo" ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      "SessionDateTimestamp" : sessionDateTimestamp,
      "SessionExerciseName" : sessionExerciseName,
      "SessionExerciseLeaningPositionName" : sessionExerciseLeaningPositionName,
      "SessionExerciseLeaningPositionEquipmentName" : sessionExerciseLeaningPositionEquipmentName,
      "SetNo" : setNo,
      "Reps" : reps,
      "WeightKg" : weightKg,
      "Description" : description
    };
  }
}

List<Performance> getPerformanceList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Performance.fromMap(l[i]));