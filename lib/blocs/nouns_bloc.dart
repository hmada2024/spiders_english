// blocs/nouns_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/noun_model.dart';

// Noun Events
abstract class NounsEvent {}

class LoadNouns extends NounsEvent {}

// Noun States
abstract class NounsState {}

class NounsInitial extends NounsState {}

class NounsLoading extends NounsState {}

class NounsLoaded extends NounsState {
  final List<NounModel> nouns;
  NounsLoaded(this.nouns);
}

class NounsError extends NounsState {
  final String message;
  NounsError(this.message);
}

class NounsBloc extends Bloc<NounsEvent, NounsState> {
  final DatabaseHelper _databaseHelper;

  NounsBloc(this._databaseHelper) : super(NounsInitial()) {
    on<LoadNouns>(_onLoadNouns);
  }

  Future<void> _onLoadNouns(LoadNouns event, Emitter<NounsState> emit) async {
    emit(NounsLoading());
    try {
      final nounsData = await _databaseHelper.getNouns();
      final nouns = nounsData.map((data) => NounModel.fromJson(data)).toList();
      emit(NounsLoaded(nouns));
    } catch (e) {
      emit(NounsError('Could not load nouns: $e'));
    }
  }
}
