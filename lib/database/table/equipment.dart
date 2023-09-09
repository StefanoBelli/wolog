import 'entity.dart';

class Equipment implements Entity {
  final String name;
  final String iconName;
  final String description;

  const Equipment({
    required this.name,
    required this.iconName,
    required this.description
  });
  
  @override
  Map toMap() {
    return {
      'Name' : name,
      'IconName' : iconName,
      'Description' : description
    };
  }

}