// models/noun_model.dart
import 'dart:typed_data';
import 'package:learn_box_english/constants/constants.dart';

class NounModel {
  final int id;
  final String name;
  final Uint8List? image;
  final Uint8List? audio;
  final String category;

  NounModel({
    required this.id,
    required this.name,
    this.image,
    this.audio,
    required this.category,
  });

  factory NounModel.fromJson(Map<String, dynamic> json) {
    return NounModel(
      id: json[AppConstants.idColumn] as int,
      name: json[AppConstants.nameColumn] ?? "Exist is NULL",
      image: json[AppConstants.imageColumn] as Uint8List?,
      audio: json[AppConstants.audioColumn] as Uint8List?,
      category: json[AppConstants.categoryColumn] ?? "Exist is NULL",
    );
  }
}
