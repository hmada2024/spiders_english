// widgets/data_loader.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataLoader<B extends StateStreamableSource<S>, S, T>
    extends StatefulWidget {
  final BlocWidgetSelector<S, List<T>> dataSelector;
  final Widget Function(BuildContext, List<T>) builder;

  const DataLoader({
    super.key,
    required this.dataSelector,
    required this.builder,
  });

  @override
  State<DataLoader<B, S, T>> createState() => _DataLoaderState<B, S, T>();
}

class _DataLoaderState<B extends StateStreamableSource<S>, S, T>
    extends State<DataLoader<B, S, T>> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        final data = widget.dataSelector(state);
        if (data.isEmpty) {
          // Simplified condition: only check for empty list
          return const Center(child: Text('No data found'));
        } else {
          return widget.builder(context, data);
        }
      },
    );
  }
}
