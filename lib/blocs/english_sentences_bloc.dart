// blocs/english_sentences_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/english_sentence_model.dart';

// English Sentences Events
abstract class EnglishSentencesEvent {}

class LoadSentences extends EnglishSentencesEvent {}

// English Sentences States
abstract class EnglishSentencesState {}

class EnglishSentencesInitial extends EnglishSentencesState {}

class EnglishSentencesLoading extends EnglishSentencesState {}

class EnglishSentencesLoaded extends EnglishSentencesState {
  final List<EnglishSentenceModel> sentences;
  EnglishSentencesLoaded(this.sentences);
}

class EnglishSentencesError extends EnglishSentencesState {
  final String message;
  EnglishSentencesError(this.message);
}

class EnglishSentencesBloc
    extends Bloc<EnglishSentencesEvent, EnglishSentencesState> {
  final DatabaseHelper _databaseHelper;

  EnglishSentencesBloc(this._databaseHelper)
      : super(EnglishSentencesInitial()) {
    on<LoadSentences>(_onLoadSentences);
  }

  Future<void> _onLoadSentences(
      LoadSentences event, Emitter<EnglishSentencesState> emit) async {
    emit(EnglishSentencesLoading());
    try {
      final sentencesData = await _databaseHelper
          .getEnglishSentences(); // تأكد من وجود هذه الطريقة في DatabaseHelper
      final sentences = sentencesData
          .map((data) => EnglishSentenceModel.fromJson(data))
          .toList();
      emit(EnglishSentencesLoaded(sentences));
    } catch (e) {
      emit(EnglishSentencesError('Could not load sentences: $e'));
    }
  }
}
