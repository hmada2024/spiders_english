// lib/widgets/matching_game_grid.dart
import 'package:flutter/material.dart';
import 'package:learn_box_english/models/match_card_model.dart';
import 'package:learn_box_english/widgets/matching_game/match_card_widget.dart'; // مسار معدل

class MatchingGameGrid extends StatelessWidget {
  final List<MatchCard> matchCards;
  final Function(MatchCard) onCardTap;
  final int columns;

  const MatchingGameGrid({
    super.key,
    required this.matchCards,
    required this.onCardTap,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.75,
      ),
      itemCount: matchCards.length,
      itemBuilder: (context, index) {
        final card = matchCards[index];
        return MatchCardWidget(
          card: card,
          onTap: () => onCardTap(card),
        );
      },
    );
  }
}
