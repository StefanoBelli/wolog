import 'package:wolog/database/table/mappable_entity.dart';

class Icon implements MappableEntity {
  static const String nameKey = "Name";
  static const String filenameKey = "Filename";
  static const String descriptionKey = "Description";

  final String name;
  final String filename;
  final String? description;

  const Icon({
    required this.name,
    required this.filename,
    required this.description
  });

  Icon.fromMap(Map<String, Object?> m) :
    name = m[nameKey] as String,
    filename = m[filenameKey] as String,
    description = m[descriptionKey] as String;
    
  @override
  List<String> getPrimaryKeyInMap() {
    return [ nameKey ];
  }

  @override
  Map<String, Object?> toMap() {
    return {
      nameKey : name,
      filenameKey : filename,
      descriptionKey : description
    };
  }
}

List<Icon> getIconList(List<Map<String, Object?>> l) 
  => List.generate(l.length, (i) => Icon.fromMap(l[i]));
