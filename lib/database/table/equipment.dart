import 'mappable_entity.dart';

class Equipment implements MappableEntity {
  final String name;
  final String? iconName;
  final String? description;

  const Equipment({
    required this.name,
    required this.iconName,
    required this.description
  });

  Equipment.fromMap(Map<String, Object?> map) :
    name = map['Name'] as String,
    iconName = map['IconName'] as String,
    description = map['Description'] as String;

  
  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'IconName' : iconName,
      'Description' : description
    };
  }
  
  @override
  List<String> getPrimaryKeyInMap() {
    return [ 'Name' ];
  }
}

List<Equipment> getEquipmentList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Equipment.fromMap(l[i]));
