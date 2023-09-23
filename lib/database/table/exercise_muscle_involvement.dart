import 'mappable_table.dart';

class ExerciseMuscleInvolvement implements MappableTable {
  static const String musclePartNameKey = 'MusclePartName';
  static const String muscleNameKey = 'MuscleName';
  static const String exerciseNameKey = 'ExerciseName';
  static const String exerciseEquipmentNameKey = 'ExerciseEquipmentName';
  static const String exerciseBodyPositioningNameKey = 'ExerciseBodyPositioningName';
  static const String descriptionKey = 'Description';

  final String? musclePartName;
  final String muscleName;
  final String exerciseName;
  final String? exerciseEquipmentName;
  final String exerciseBodyPositioningName;
  final String? description;

  const ExerciseMuscleInvolvement({
    required this.musclePartName,
    required this.muscleName,
    required this.exerciseName,
    required this.exerciseEquipmentName,
    required this.exerciseBodyPositioningName,
    required this.description
  });

  ExerciseMuscleInvolvement.fromMap(final Map<String, Object?> m) :
    musclePartName = m[musclePartNameKey] as String?,
    muscleName = m[muscleNameKey]! as String,
    exerciseName = m[exerciseNameKey]! as String,
    exerciseEquipmentName = m[exerciseEquipmentNameKey] as String?,
    exerciseBodyPositioningName = m[exerciseBodyPositioningNameKey]! as String,
    description = m[descriptionKey] as String?;
    
  @override
  List<String> getPrimaryKeyInMap() => 
    [ 
      musclePartNameKey, 
      muscleNameKey, 
      exerciseNameKey, 
      exerciseEquipmentNameKey, 
      exerciseBodyPositioningNameKey 
    ];

  @override
  Map<String, Object?> toMap() => 
    {
      musclePartNameKey : musclePartName,
      muscleNameKey : muscleName,
      exerciseNameKey : exerciseName,
      exerciseEquipmentNameKey : exerciseEquipmentName,
      exerciseBodyPositioningNameKey : exerciseBodyPositioningName,
      descriptionKey : description
    };
}

List<ExerciseMuscleInvolvement> getExerciseMuscleInvolvementList(final List<Map<String, Object?>> l) 
  => List.generate(l.length, (final i) => ExerciseMuscleInvolvement.fromMap(l[i]));
