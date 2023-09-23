import 'mappable_table.dart';

class MusclePart implements MappableTable {
  static const String nameKey = 'Name';
  static const String muscleNameKey = 'MuscleName';
  static const String iconNameKey = 'IconName';
  static const String descriptionKey = 'Description';

  final String? name;
  final String muscleName;
  final String? iconName;
  final String? description;

  const MusclePart({
    required this.name,
    required this.muscleName,
    required this.iconName,
    required this.description
  });

  MusclePart.fromMap(final Map<String, Object?> m) :
    name = m[nameKey] as String?,
    muscleName = m[muscleNameKey]! as String,
    iconName = m[iconNameKey] as String?,
    description = m[descriptionKey] as String?;
    
  @override
  List<String> getPrimaryKeyInMap() => 
    [ 
      nameKey, 
      muscleNameKey 
    ];
  
  @override
  Map<String, Object?> toMap() => 
    {
      nameKey : name,
      muscleNameKey : muscleName,
      iconNameKey : iconName,
      descriptionKey : description
    };
}

List<MusclePart> getMusclePartList(final List<Map<String, Object?>> l) 
  => List.generate(l.length, (final i) => MusclePart.fromMap(l[i]));
