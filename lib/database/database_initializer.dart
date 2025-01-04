// database/database_initializer.dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void initializeDatabase() {
  sqfliteFfiInit(); // Initialize sqflite for Windows
  databaseFactory = databaseFactoryFfi; // Set databaseFactory to use FFI
}
