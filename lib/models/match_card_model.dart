// models/match_card_model.dart

import 'dart:typed_data';

class MatchCard {
  final int id;
  final String value;
  final Uint8List? image;
  bool isFlipped;
  bool isMatched;

  MatchCard({
    required this.id,
    required this.value,
    this.image,
    this.isFlipped = false,
    this.isMatched = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchCard &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          value == other.value &&
          image == other.image;

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ image.hashCode;
}
