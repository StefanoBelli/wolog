import '../table/mappable_table.dart';

String getWhereClause(final MappableTable mappableEntity) {
  final whereClauseBuffer = StringBuffer();
  final primaryKey = mappableEntity.getPrimaryKeyInMap();
  final m = mappableEntity.toMap();

  for(final key in primaryKey) {
    whereClauseBuffer.write(m[key] != null ? '$key = ? AND ' : '$key IS NULL AND ');
  }

  return whereClauseBuffer.toString()
            .substring(0, whereClauseBuffer.length - 5);
}

List<Object?> getWhereArgs(final MappableTable mappableEntity) {
  final primaryKey = mappableEntity.getPrimaryKeyInMap();
  final m = mappableEntity.toMap();
  
  final whereArgs = <Object?>[];

  for(final key in primaryKey) {
    if(m[key] != null) {
      whereArgs.add(m[key]);
    }
  }

  return whereArgs;
}