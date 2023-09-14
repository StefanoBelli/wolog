import 'package:wolog/database/table/mappable_entity.dart';

class Session implements MappableEntity {
  static const String dateTimestampKey = "DateTimestamp";
  static const String exerciseNameKey = "ExerciseName";
  static const String exerciseEquipmentNameKey = "ExerciseEquipmentName";
  static const String exerciseBodyPositioningNameKey = "ExerciseBodyPositioningName";
  static const String descriptionKey = "Description";
  
  final int dateTimestamp;
  final String exerciseName;
  final String? exerciseEquipmentName;
  final String exerciseBodyPositioningName;
  final String? description;

  const Session({
    required this.dateTimestamp,
    required this.exerciseName,
    required this.exerciseEquipmentName,
    required this.exerciseBodyPositioningName,
    required this.description
  });

  Session.fromMap(Map<String,Object?> m) :
    dateTimestamp = m[dateTimestampKey] as int,
    exerciseName = m[exerciseNameKey]as String,
    exerciseEquipmentName = m[exerciseEquipmentNameKey] as String,
    exerciseBodyPositioningName = m[exerciseBodyPositioningNameKey] as String,
    description = m[descriptionKey] as String;

  @override
  List<String> getPrimaryKeyInMap() {
    return [ dateTimestampKey, exerciseNameKey, exerciseEquipmentNameKey, exerciseBodyPositioningNameKey ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      dateTimestampKey : dateTimestamp,
      exerciseNameKey : exerciseName,
      exerciseEquipmentNameKey : exerciseEquipmentName,
      exerciseBodyPositioningNameKey : exerciseBodyPositioningName,
      descriptionKey : description
    };
  }

}

List<Session> getSessionList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Session.fromMap(l[i]));