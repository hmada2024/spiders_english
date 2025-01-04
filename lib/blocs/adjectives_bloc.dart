// blocs/adjectives_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/adjective_model.dart';

// Adjective Events
abstract class AdjectivesEvent {}

class LoadAdjectives extends AdjectivesEvent {}

// Adjective States
abstract class AdjectivesState {}

class AdjectivesInitial extends AdjectivesState {}

class AdjectivesLoading extends AdjectivesState {}

class AdjectivesLoaded extends AdjectivesState {
  final List<AdjectiveModel> adjectives;
  AdjectivesLoaded(this.adjectives);
}

class AdjectivesError extends AdjectivesState {
  final String message;
  AdjectivesError(this.message);
}

class AdjectivesBloc extends Bloc<AdjectivesEvent, AdjectivesState> {
  final DatabaseHelper _databaseHelper;

  AdjectivesBloc(this._databaseHelper) : super(AdjectivesInitial()) {
    on<LoadAdjectives>(_onLoadAdjectives);
  }

  Future<void> _onLoadAdjectives(
      LoadAdjectives event, Emitter<AdjectivesState> emit) async {
    emit(AdjectivesLoading());
    try {
      final adjectivesData = await _databaseHelper.getAdjectives();
      final adjectives =
          adjectivesData.map((data) => AdjectiveModel.fromJson(data)).toList();
      emit(AdjectivesLoaded(adjectives));
    } catch (e) {
      emit(AdjectivesError('Could not load adjectives: $e'));
    }
  }
}
