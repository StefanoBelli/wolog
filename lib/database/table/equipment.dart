import 'mappable_entity.dart';

class Equipment implements MappableEntity {
  final String name;
  final String iconName;
  final String description;

  const Equipment({
    required this.name,
    required this.iconName,
    required this.description
  });
  
  @override
  Map<String, Object?> toMap() {
    return {
      'Name' : name,
      'IconName' : iconName,
      'Description' : description
    };
  }
  
  @override
  List<int> getPrimaryKeyIndexesInMap() {
    return [ 0 ];
  }

}