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
  final Uint8List? audioBlob;

  VerbConjugationModel({
    required this.id,
    required this.baseForm,
    required this.translation,
    required this.pastForm,
    required this.pPForm,
    required this.verbType,
    this.audioBlob,
  });

  factory VerbConjugationModel.fromJson(Map<String, dynamic> json) {
    return VerbConjugationModel(
      id: json[AppConstants.idColumn] as int,
      baseForm: json[AppConstants.baseFormColumn] ?? "Exist is NULL",
      translation: json[AppConstants.translationColumn] ?? "Exist is NULL",
      pastForm: json[AppConstants.pastFormColumn] ?? "Exist is NULL",
      pPForm: json[AppConstants.pPFormColumn] ?? "Exist is NULL",
      verbType: json[AppConstants.verbTypeColumn] ?? "Exist is NULL",
      audioBlob: json[AppConstants.audioBlobColumn] as Uint8List?,
    );
  }
}
