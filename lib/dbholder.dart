import 'package:sqflite/sqflite.dart';

class DbHolder {
  static DbHolder? _instance;

  DbHolder._();

  static DbHolder? getInstance() => _instance ??= DbHolder._();
  
  Database? database;
}