import 'package:wolog/database/table/mappable_entity.dart';

class Session implements MappableEntity {
  static const String dateTimestampKey = "DateTimestamp";
  static const String exerciseNameKey = "ExerciseName";
  static const String exerciseLeaningPositionNameKey = "ExerciseLeaningPositionName";
  static const String exerciseLeaningPositionEquipmentNameKey = "ExerciseLeaningPositionEquipmentName";
  static const String descriptionKey = "Description";
  
  final int dateTimestamp;
  final String exerciseName;
  final String exerciseLeaningPositionName;
  final String? exerciseLeaningPositionEquipmentName;
  final String? description;

  const Session({
    required this.dateTimestamp,
    required this.exerciseName,
    required this.exerciseLeaningPositionName,
    required this.exerciseLeaningPositionEquipmentName,
    required this.description
  });

  Session.fromMap(Map<String,Object?> m) :
    dateTimestamp = m[dateTimestampKey] as int,
    exerciseName = m[exerciseNameKey]as String,
    exerciseLeaningPositionName = m[exerciseLeaningPositionNameKey] as String,
    exerciseLeaningPositionEquipmentName = m[exerciseLeaningPositionEquipmentNameKey] as String,
    description = m[descriptionKey] as String;

  @override
  List<String> getPrimaryKeyInMap() {
    return [ dateTimestampKey, exerciseNameKey, exerciseLeaningPositionNameKey, exerciseLeaningPositionEquipmentNameKey ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      dateTimestampKey : dateTimestamp,
      exerciseNameKey : exerciseName,
      exerciseLeaningPositionNameKey : exerciseLeaningPositionName,
      exerciseLeaningPositionEquipmentNameKey : exerciseLeaningPositionEquipmentName,
      descriptionKey : description
    };
  }

}

List<Session> getSessionList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Session.fromMap(l[i]));