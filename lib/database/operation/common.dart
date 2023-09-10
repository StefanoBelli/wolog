import 'package:wolog/database/table/mappable_entity.dart';

String getWhereClause(MappableEntity mappableEntity) {
  String whereClause = "";
  List<String> primaryKey = mappableEntity.getPrimaryKeyInMap();

  for(final key in primaryKey) {
    whereClause += "$key = ? AND ";
  }

  return whereClause.substring(0, whereClause.length - 5);
}

List<Object?> getWhereArgs(MappableEntity mappableEntity) {
  List<String> primaryKey = mappableEntity.getPrimaryKeyInMap();
  Map<String, Object?> m = mappableEntity.toMap();
  
  List<Object?> whereArgs = [];

  for(final key in primaryKey) {
    whereArgs.add(m[key]);
  }

  return whereArgs;
}