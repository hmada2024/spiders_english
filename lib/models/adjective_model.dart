// models/adjective_model.dart
import 'dart:typed_data';
import 'package:learn_box_english/constants/constants.dart';

class AdjectiveModel {
  final int id;
  final String mainAdj;
  final String example;
  final String reverseAdj;
  final String revExample;
  final Uint8List? audio;

  AdjectiveModel({
    required this.id,
    required this.mainAdj,
    required this.example,
    required this.reverseAdj,
    required this.revExample,
    this.audio,
  });

  factory AdjectiveModel.fromJson(Map<String, dynamic> json) {
    return AdjectiveModel(
      id: json[AppConstants.idColumn] as int,
      mainAdj: json[AppConstants.mainAdjColumn] ?? "Exist is NULL",
      example: json[AppConstants.exampleColumn] ?? "Exist is NULL",
      reverseAdj: json[AppConstants.reverseAdjColumn] ?? "Exist is NULL",
      revExample: json[AppConstants.revExampleColumn] ?? "Exist is NULL",
      audio: json[AppConstants.audioColumn] as Uint8List?,
    );
  }
}
