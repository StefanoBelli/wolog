import 'package:wolog/database/table/mappable_entity.dart';

class Session implements MappableEntity {
  final int dateTimestamp;
  final String exerciseName;
  final String? description;

  const Session({
    required this.dateTimestamp,
    required this.exerciseName,
    required this.description
  });

  Session.fromMap(Map<String,Object?> m) :
    dateTimestamp = m["DateTimestamp"] as int,
    exerciseName = m["ExerciseName"] as String,
    description = m["Description"] as String;

  @override
  List<String> getPrimaryKeyInMap() {
    return [ "DateTimestamp", "ExerciseName" ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      "DateTimestamp" : dateTimestamp,
      "ExerciseName" : exerciseName,
      "Description" : description
    };
  }

}

List<Session> getSessionList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Session.fromMap(l[i]));