import 'mappable_entity.dart';

class Muscle implements MappableEntity {
  final String name;
  final bool frontal;
  final bool upperBody;
  final String? iconName;
  final String? description;

  const Muscle({
    required this.name,
    required this.frontal,
    required this.upperBody,
    required this.iconName,
    required this.description
  });

  Muscle.fromMap(Map<String, Object?> map) :
    name = map['Name'] as String,
    frontal = map['Frontal'] as bool,
    upperBody = map['UpperBody'] as bool,
    iconName = map['IconName'] as String,
    description = map['Description'] as String;

  
  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'Frontal' : frontal,
      'UpperBody' : upperBody,
      'IconName' : iconName,
      'Description' : description
    };
  }
  
  @override
  List<String> getPrimaryKeyInMap() {
    return [ 'Name' ];
  }
}

List<Muscle> getMuscleList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Muscle.fromMap(l[i]));