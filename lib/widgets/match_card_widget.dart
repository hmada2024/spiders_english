// lib/widgets/match_card_widget.dart
import 'package:flutter/material.dart';
import 'package:learn_box_english/models/match_card_model.dart';

class MatchCardWidget extends StatelessWidget {
  final MatchCard card;
  final VoidCallback onTap;

  const MatchCardWidget({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        color: card.isFlipped ? Colors.amber[100] : null,
        child: Center(
          child: card.isFlipped
              ? card.image != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.memory(card.image!),
                    )
                  : Text(
                      card.value,
                      textAlign: TextAlign.center,
                    )
              : const Text('?', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
