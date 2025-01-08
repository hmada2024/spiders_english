// blocs/verb_conjugations_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/verb_conjugation_model.dart';

// Verb Conjugation Events
abstract class VerbConjugationsEvent {}

class LoadVerbs extends VerbConjugationsEvent {}

// Verb Conjugation States
abstract class VerbConjugationsState {}

class VerbConjugationsInitial extends VerbConjugationsState {}

class VerbConjugationsLoading extends VerbConjugationsState {}

class VerbsLoaded extends VerbConjugationsState {
  final List<VerbConjugationModel> verbs;
  VerbsLoaded(this.verbs);
}

class VerbConjugationsError extends VerbConjugationsState {
  final String message;
  VerbConjugationsError(this.message);
}

class VerbConjugationsBloc
    extends Bloc<VerbConjugationsEvent, VerbConjugationsState> {
  final DatabaseHelper _databaseHelper;

  VerbConjugationsBloc(this._databaseHelper)
      : super(VerbConjugationsInitial()) {
    on<LoadVerbs>(_onLoadVerbs);
  }

  Future<void> _onLoadVerbs(
      LoadVerbs event, Emitter<VerbConjugationsState> emit) async {
    print('VerbConjugationsBloc: Received LoadVerbs event');
    emit(VerbConjugationsLoading());
    try {
      final verbsData = await _databaseHelper.getVerbConjugations();
      print(
          'VerbConjugationsBloc: Number of verbsData fetched: ${verbsData.length}');
      final verbs =
          verbsData.map((data) => VerbConjugationModel.fromJson(data)).toList();
      print('VerbConjugationsBloc: Number of verbs mapped: ${verbs.length}');
      if (verbs.isNotEmpty) {
        print(
            'VerbConjugationsBloc: basePronunciation of the first verb: ${verbs.first.basePronunciation?.length}');
      }
      emit(VerbsLoaded(verbs));
    } catch (e) {
      emit(VerbConjugationsError('Could not load verb conjugations: $e'));
    }
  }
}
