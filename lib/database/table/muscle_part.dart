import 'package:wolog/database/table/mappable_entity.dart';

class MusclePart implements MappableEntity {
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

  MusclePart.fromMap(Map<String, Object?> map) :
    name = map['Name'] as String,
    muscleName = map['MuscleName'] as String,
    iconName = map['IconName'] as String,
    description = map['Description'] as String;
  
  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'MuscleName' : muscleName,
      'IconName' : iconName,
      'Description' : description
    };
  }
  
  @override
  List<int> getPrimaryKeyIndexesInMap() {
    return [ 0, 1 ];
  }
}

List<MusclePart> getMusclePartList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => MusclePart.fromMap(l[i]));
