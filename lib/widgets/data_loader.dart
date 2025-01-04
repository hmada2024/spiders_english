// widgets/data_loader.dart
import 'package:flutter/material.dart';
import 'package:learn_box_english/database/database_helper.dart';

class DataLoader<T> extends StatefulWidget {
  final String tableName;
  final Future<List<Map<String, dynamic>>> Function(DatabaseHelper) fetchData;
  final Widget Function(BuildContext, List<T>) builder;
  final T Function(Map<String, dynamic>) fromJson;

  const DataLoader({
    super.key,
    required this.tableName,
    required this.fetchData,
    required this.builder,
    required this.fromJson,
  });

  @override
  State<DataLoader<T>> createState() => _DataLoaderState<T>();
}

class _DataLoaderState<T> extends State<DataLoader<T>> {
  late Future<List<T>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();
  }

  Future<List<T>> _loadData() async {
    debugPrint('DataLoader: Loading data from ${widget.tableName}');
    final rawData = await widget.fetchData(DatabaseHelper());
    debugPrint('DataLoader: Raw data fetched - ${rawData.length} items');
    return rawData.map((json) {
      debugPrint('DataLoader: Processing item - $json');
      return widget.fromJson(json);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data found'));
        } else {
          return widget.builder(context, snapshot.data!);
        }
      },
    );
  }
}
