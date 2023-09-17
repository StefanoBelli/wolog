import 'mappable_entity.dart';

class BodyPositioning implements MappableEntity {
  static const String nameKey = 'Name';
  static const String iconNameKey = 'IconName';
  static const String descriptionKey = 'Description';

  final String name;
  final String? iconName;
  final String? description;

  const BodyPositioning({
    required this.name,
    required this.iconName,
    required this.description
  });

  BodyPositioning.fromMap(final Map<String, Object?> m) :
    name = m[nameKey]! as String,
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
      iconNameKey : iconName,
      descriptionKey : description
    };
}

List<BodyPositioning> getBodyPositioningList(final List<Map<String, Object?>> l) 
  => List.generate(l.length, (final i) => BodyPositioning.fromMap(l[i]));