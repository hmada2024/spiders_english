// models/verb_conjugation_model.dart
import 'dart:typed_data';
import 'package:learn_box_english/constants/constants.dart';

class VerbConjugationModel {
  final int id;
  final String baseForm;
  final String translation;
  final String pastForm;
  final String pPForm;
  final String verbType;
  final Uint8List? basePronunciation; // تم التحديث من audioBlob
  final Uint8List? pastPronunciation; // تمت الإضافة
  final Uint8List? ppPronunciation; // تمت الإضافة

  VerbConjugationModel({
    required this.id,
    required this.baseForm,
    required this.translation,
    required this.pastForm,
    required this.pPForm,
    required this.verbType,
    this.basePronunciation,
    this.pastPronunciation,
    this.ppPronunciation,
  });

  factory VerbConjugationModel.fromJson(Map<String, dynamic> json) {
    return VerbConjugationModel(
      id: json[AppConstants.idColumn] as int,
      baseForm: json[AppConstants.baseFormColumn] ?? "Exist is NULL",
      translation: json[AppConstants.translationColumn] ?? "Exist is NULL",
      pastForm: json[AppConstants.pastFormColumn] ?? "Exist is NULL",
      pPForm: json[AppConstants.pPFormColumn] ?? "Exist is NULL",
      verbType: json[AppConstants.verbTypeColumn] ?? "Exist is NULL",
      basePronunciation: json[AppConstants.basePronunciationColumn]
          as Uint8List?, // تم التحديث
      pastPronunciation: json[AppConstants.pastPronunciationColumn]
          as Uint8List?, // تمت الإضافة
      ppPronunciation:
          json[AppConstants.ppPronunciationColumn] as Uint8List?, // تمت الإضافة
    );
  }
}
