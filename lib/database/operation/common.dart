import '../table/mappable_entity.dart';

String getWhereClause(final MappableEntity mappableEntity) {
  final whereClauseBuffer = StringBuffer();
  final primaryKey = mappableEntity.getPrimaryKeyInMap();

  for(final key in primaryKey) {
    whereClauseBuffer.write('$key = ? AND ');
  }

  return whereClauseBuffer.toString()
            .substring(0, whereClauseBuffer.length - 5);
}

List<Object?> getWhereArgs(final MappableEntity mappableEntity) {
  final primaryKey = mappableEntity.getPrimaryKeyInMap();
  final m = mappableEntity.toMap();
  
  final whereArgs = <Object?>[];

  for(final key in primaryKey) {
    whereArgs.add(m[key]);
  }

  return whereArgs;
}