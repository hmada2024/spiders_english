import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';

class DataBloc extends Cubit<List<Map<String, dynamic>>> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  DataBloc() : super([]);

  Future<void> fetchData(String tableName) async {
    try {
      Database db = await _dbHelper.database;
      List<Map<String, dynamic>> data = await db.query(tableName);
      emit(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      emit([]);
    }
  }
}
