
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHolder {
  static DbHolder? _instance;

  DbHolder._();

  static DbHolder? getInstance() => _instance ??= DbHolder._();
  
  Database? database;
}