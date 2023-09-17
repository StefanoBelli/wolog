import 'mappable_entity.dart';

class Muscle implements MappableEntity {
  static const String nameKey = 'Name';
  static const String frontalKey = 'Frontal';
  static const String upperBodyKey = 'UpperBody';
  static const String iconNameKey = 'IconName';
  static const String descriptionKey = 'Description';

  final String name;
  final int frontal;
  final int upperBody;
  final String? iconName;
  final String? description;

  const Muscle({
    required this.name,
    required this.frontal,
    required this.upperBody,
    required this.iconName,
    required this.description
  });

  Muscle.fromMap(final Map<String, Object?> m) :
    name = m[nameKey]! as String,
    frontal = m[frontalKey]! as int,
    upperBody = m[upperBodyKey]! as int,
    iconName = m[iconNameKey] as String?,
    description = m[descriptionKey] as String?;

  @override
  List<String> getPrimaryKeyInMap() => 
    [ 
      nameKey 
    ];

  @override
  Map<String, Object?> toMap() => 
    {
      nameKey : name,
      frontalKey : frontal,
      upperBodyKey : upperBody,
      iconNameKey : iconName,
      descriptionKey : description
    };
}

List<Muscle> getMuscleList(final List<Map<String, Object?>> l) 
  => List.generate(l.length, (final i) => Muscle.fromMap(l[i]));