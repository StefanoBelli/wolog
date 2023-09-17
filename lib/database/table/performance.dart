import 'mappable_entity.dart';

class Performance implements MappableEntity {
  static const String sessionDateTimestampKey = 'SessionDateTimestamp';
  static const String sessionExerciseNameKey = 'SessionExerciseName';
  static const String sessionExerciseEquipmentNameKey = 'SessionExerciseEquipmentName';
  static const String sessionExerciseBodyPositioningNameKey = 'SessionExerciseBodyPositioningName';
  static const String setNoKey = 'SetNo';
  static const String repsKey = 'Reps';
  static const String weightKgKey = 'WeightKg';
  static const String descriptionKey = 'Description';

  final int sessionDateTimestamp;
  final String sessionExerciseName;
  final String? sessionExerciseEquipmentName;
  final String sessionExerciseBodyPositioningName;
  final int setNo;
  final int reps;
  final double? weightKg;
  final String? description;

  const Performance({
    required this.sessionDateTimestamp,
    required this.sessionExerciseName,
    required this.sessionExerciseEquipmentName,
    required this.sessionExerciseBodyPositioningName,
    required this.setNo,
    required this.reps,
    required this.weightKg,
    required this.description
  });

  Performance.fromMap(final Map<String, Object?> m) :
    sessionDateTimestamp = m[sessionDateTimestampKey]! as int,
    sessionExerciseName = m[sessionExerciseNameKey]! as String,
    sessionExerciseEquipmentName = m[sessionExerciseEquipmentNameKey] as String?,
    sessionExerciseBodyPositioningName = m[sessionExerciseBodyPositioningNameKey]! as String,
    setNo = m[setNoKey]! as int,
    reps = m[repsKey]! as int,
    weightKg = m[weightKgKey] as double?,
    description = m[descriptionKey] as String?;

  @override
  List<String> getPrimaryKeyInMap() => 
    [ 
      sessionDateTimestampKey, 
      sessionExerciseNameKey, 
      sessionExerciseEquipmentNameKey, 
      sessionExerciseBodyPositioningNameKey, 
      setNoKey 
    ];

  @override
  Map<String, Object?> toMap() => 
    {
      sessionDateTimestampKey : sessionDateTimestamp,
      sessionExerciseNameKey : sessionExerciseName,
      sessionExerciseEquipmentNameKey : sessionExerciseEquipmentName,
      sessionExerciseBodyPositioningNameKey : sessionExerciseBodyPositioningName,
      setNoKey : setNo,
      repsKey : reps,
      weightKgKey : weightKg,
      descriptionKey : description
    };
}

List<Performance> getPerformanceList(final List<Map<String, Object?>> l) 
  => List.generate(l.length, (final i) => Performance.fromMap(l[i]));