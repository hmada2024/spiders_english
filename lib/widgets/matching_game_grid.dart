// lib/widgets/matching_game_grid.dart
import 'package:flutter/material.dart';
import 'package:learn_box_english/models/match_card_model.dart';
import 'package:learn_box_english/widgets/match_card_widget.dart';

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
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.8,
      ),
      itemCount: matchCards.length,
      itemBuilder: (context, index) {
        final card = matchCards[index];
        return MatchCardWidget(
          // استخدام الـ MatchCardWidget هنا
          card: card,
          onTap: () => onCardTap(card),
        );
      },
    );
  }
}
