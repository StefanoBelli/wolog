import 'package:wolog/database/table/mappable_entity.dart';

class Session implements MappableEntity {
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
    dateTimestamp = m["DateTimestamp"] as int,
    exerciseName = m["ExerciseName"] as String,
    exerciseLeaningPositionName = m['ExerciseLeaningPositionName'] as String,
    exerciseLeaningPositionEquipmentName = m['ExerciseLeaningPositionEquipmentName'] as String,
    description = m["Description"] as String;

  @override
  List<String> getPrimaryKeyInMap() {
    return [ "DateTimestamp", "ExerciseName", "ExerciseLeaningPositionName", "ExerciseLeaningPositionEquipmentName" ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      "DateTimestamp" : dateTimestamp,
      "ExerciseName" : exerciseName,
      'ExerciseLeaningPositionName' : exerciseLeaningPositionName,
      'ExerciseLeaningPositionEquipmentName' : exerciseLeaningPositionEquipmentName,
      "Description" : description
    };
  }

}

List<Session> getSessionList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Session.fromMap(l[i]));