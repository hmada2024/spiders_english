// lib/widgets/matching_game/match_card_widget.dart
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
        elevation: card.isFlipped ? 6.0 : 4.0,
        color: card.isFlipped ? Colors.amber[100] : Colors.blueGrey[50],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: card.isFlipped
              ? Center(
                  child: card.image != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.memory(card.image!),
                        )
                      : Text(
                          card.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                )
              : const Center(
                  child: Text('?',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
        ),
      ),
    );
  }
}
