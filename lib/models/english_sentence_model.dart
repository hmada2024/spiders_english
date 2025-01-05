// models/english_sentence_model.dart
import 'package:learn_box_english/constants/constants.dart';

class EnglishSentenceModel {
  final int id;
  final String sentence;
  final String answer;
  final String translation;

  EnglishSentenceModel({
    required this.id,
    required this.sentence,
    required this.answer,
    required this.translation,
  });

  factory EnglishSentenceModel.fromJson(Map<String, dynamic> json) {
    return EnglishSentenceModel(
      id: json[AppConstants.idColumn] as int,
      sentence: json[AppConstants.sentenceColumn] ?? "Exist is NULL",
      answer: json[AppConstants.answerColumn] ?? "Exist is NULL",
      translation:
          json[AppConstants.sentenceTranslationColumn] ?? "Exist is NULL",
    );
  }
}
