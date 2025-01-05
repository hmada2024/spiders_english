// screens/games/matching_game_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/nouns_bloc.dart';
import 'package:learn_box_english/models/noun_model.dart';
import 'package:learn_box_english/models/match_card_model.dart';
import 'package:learn_box_english/widgets/matching_game/matching_game_controls.dart';
import 'package:learn_box_english/widgets/matching_game/matching_game_grid.dart';

class MatchingGamePage extends StatefulWidget {
  const MatchingGamePage({super.key});

  @override
  State<MatchingGamePage> createState() => _MatchingGamePageState();
}

class _MatchingGamePageState extends State<MatchingGamePage> {
  List<MatchCard> matchCards = [];
  List<MatchCard?> selectedCards = [null, null];
  int score = 0;
  String? _selectedCategory;
  List<String> availableCategories = [];
  int numberOfCards = 20;
  int rows = 5;
  int columns = 4;

  void _populateCategories(List<NounModel> nouns) {
    final categories = nouns.map((noun) => noun.category).toSet().toList();
    // استخدم SchedulerBinding لتأخير استدعاء setState لما بعد البناء
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          availableCategories = categories;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final controlsHeight = screenHeight * 0.1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Game'),
      ),
      body: BlocBuilder<NounsBloc, NounsState>(
        builder: (context, state) {
          if (state is NounsLoaded) {
            if (availableCategories.isEmpty) {
              _populateCategories(state.nouns);
            }
            return Column(
              children: [
                SizedBox(
                  height: controlsHeight,
                  child: MatchingGameControls(
                    selectedCategory: _selectedCategory,
                    availableCategories: availableCategories,
                    onCategoryChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                        _generateCards(state.nouns);
                      });
                    },
                    onRefresh: availableCategories.isNotEmpty
                        ? () => _generateCards(state.nouns, refresh: true)
                        : null,
                  ),
                ),
                Expanded(
                  child: MatchingGameGrid(
                    matchCards: matchCards,
                    onCardTap: _selectCard,
                    columns: columns,
                  ),
                ),
              ],
            );
          } else if (state is NounsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NounsError) {
            return Center(child: Text('Error loading nouns: ${state.message}'));
          } else {
            return const Center(child: Text('لا يوجد بيانات'));
          }
        },
      ),
    );
  }

  void _generateCards(List<NounModel> allNouns, {bool refresh = false}) {
    if (_selectedCategory == null) return;

    final filteredNouns =
        allNouns.where((noun) => noun.category == _selectedCategory).toList();

    if (filteredNouns.isEmpty) {
      if (mounted) {
        setState(() {
          matchCards = [];
        });
      }
      return;
    }

    filteredNouns.shuffle();
    List<NounModel> selectedNouns;
    if (filteredNouns.length <= numberOfCards / 2) {
      selectedNouns = filteredNouns;
    } else {
      selectedNouns = filteredNouns.sublist(0, numberOfCards ~/ 2);
    }

    List<MatchCard> cards = [];
    for (var noun in selectedNouns) {
      cards.add(MatchCard(id: noun.id * 2, value: noun.name, image: null));
      cards.add(
          MatchCard(id: noun.id * 2 + 1, value: noun.name, image: noun.image));
    }

    cards.shuffle();
    if (mounted) {
      setState(() {
        matchCards = cards;
        selectedCards = [null, null];
      });
    }
  }

  void _selectCard(MatchCard card) {
    if (!card.isFlipped && !card.isMatched && mounted) {
      setState(() {
        if (selectedCards[0] == null) {
          selectedCards[0] = card;
          selectedCards[0]!.isFlipped = true;
        } else if (selectedCards[1] == null) {
          selectedCards[1] = card;
          selectedCards[1]!.isFlipped = true;
          if (selectedCards[0]!.value == selectedCards[1]!.value &&
              selectedCards[0]!.id != selectedCards[1]!.id) {
            score++;
            selectedCards[0]!.isMatched = true;
            selectedCards[1]!.isMatched = true;
            selectedCards = [null, null];
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم العثور على تطابق!')),
            );
          } else {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                setState(() {
                  selectedCards[0]!.isFlipped = false;
                  selectedCards[1]!.isFlipped = false;
                  selectedCards = [null, null];
                });
              }
            });
          }
        }
      });
    }
  }
}
