// database/database_helper.dart
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:learn_box_english/constants/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, AppConstants.databaseName);

    if (!await databaseExists(path)) {
      ByteData data =
          await rootBundle.load('assets/${AppConstants.databaseName}');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getAdjectives() async {
    Database db = await database;
    return await db.query(AppConstants.adjectivesTable);
  }

  Future<List<Map<String, dynamic>>> getNouns() async {
    Database db = await database;
    return await db.query(AppConstants.nounsTable);
  }

  Future<List<Map<String, dynamic>>> getVerbConjugations() async {
    Database db = await database;
    return await db.query(AppConstants.verbConjugationsTable);
  }
}
