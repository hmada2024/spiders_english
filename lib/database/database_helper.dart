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
  static final Map<String, List<Map<String, dynamic>>> _cachedData = {};
  static bool _isCacheEnabled = false;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static void enableCache() {
    _isCacheEnabled = true;
  }

  static void disableCache() {
    _isCacheEnabled = false;
    _cachedData.clear();
  }

  static Future<void> cacheDatabase(Database db) async {
    _cachedData[AppConstants.adjectivesTable] =
        await db.query(AppConstants.adjectivesTable);
    _cachedData[AppConstants.nounsTable] =
        await db.query(AppConstants.nounsTable);
    _cachedData[AppConstants.verbConjugationsTable] =
        await db.query(AppConstants.verbConjugationsTable);
    // Add other tables as needed
  }

  static void clearCache() {
    _cachedData.clear();
  }

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
    if (_isCacheEnabled &&
        _cachedData.containsKey(AppConstants.adjectivesTable)) {
      return _cachedData[AppConstants.adjectivesTable]!;
    }
    Database db = await database;
    return await db.query(AppConstants.adjectivesTable);
  }

  Future<List<Map<String, dynamic>>> getNouns() async {
    if (_isCacheEnabled && _cachedData.containsKey(AppConstants.nounsTable)) {
      return _cachedData[AppConstants.nounsTable]!;
    }
    Database db = await database;
    return await db.query(AppConstants.nounsTable);
  }

  Future<List<Map<String, dynamic>>> getVerbConjugations() async {
    if (_isCacheEnabled &&
        _cachedData.containsKey(AppConstants.verbConjugationsTable)) {
      return _cachedData[AppConstants.verbConjugationsTable]!;
    }
    Database db = await database;
    return await db.query(AppConstants.verbConjugationsTable);
  }
}
