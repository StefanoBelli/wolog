import 'mappable_entity.dart';

class Exercise implements MappableEntity {
  static const String nameKey = 'Name';
  static const String equipmentNameKey = 'EquipmentName';
  static const String bodyPositioningNameKey = 'BodyPositioningName';
  static const String iconNameKey = 'IconName';
  static const String descriptionKey = 'Description';
  
  final String name;
  final String? equipmentName;
  final String bodyPositioningName;
  final String? iconName;
  final String? description;

  const Exercise({
    required this.name,
    required this.equipmentName,
    required this.bodyPositioningName,
    required this.iconName,
    required this.description
  });

  Exercise.fromMap(final Map<String, Object?> m) :
    name = m[nameKey]! as String,
    equipmentName = m[equipmentNameKey] as String?,
    bodyPositioningName = m[bodyPositioningNameKey]! as String,
    iconName = m[iconNameKey] as String?,
    description = m[descriptionKey] as String?;
   
  @override
  List<String> getPrimaryKeyInMap() => 
    [ 
      nameKey, 
      equipmentNameKey, 
      bodyPositioningNameKey 
    ];
  
  @override
  Map<String, Object?> toMap() => 
    {
      nameKey : name,
      equipmentNameKey : equipmentName,
      bodyPositioningNameKey : bodyPositioningName,
      iconNameKey : iconName,
      descriptionKey : description
    };
}

List<Exercise> getExerciseList(final List<Map<String, Object?>> l) 
  => List.generate(l.length, (final i) => Exercise.fromMap(l[i]));
