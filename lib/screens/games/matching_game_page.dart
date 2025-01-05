// screens/games/matching_game_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/nouns_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/noun_model.dart';
import 'package:learn_box_english/widgets/data_loader.dart';

class MatchingGamePage extends StatefulWidget {
  const MatchingGamePage({super.key});

  @override
  State<MatchingGamePage> createState() => _MatchingGamePageState();
}

class _MatchingGamePageState extends State<MatchingGamePage> {
  List<NounModel> nouns = [];
  List<NounModel?> selectedNouns = [null, null];
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Game'),
      ),
      body: BlocProvider(
        create: (context) => NounsBloc(DatabaseHelper())..add(LoadNouns()),
        child: DataLoader<NounsBloc, NounsState, NounModel>(
          dataSelector: (state) {
            if (state is NounsLoaded) {
              nouns = state.nouns;
              nouns.shuffle(); // خلط الأسماء
              return nouns;
            }
            return [];
          },
          builder: (context, data) {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount: nouns.length,
              itemBuilder: (context, index) {
                final noun = nouns[index];
                return GestureDetector(
                  onTap: () {
                    _selectNoun(noun);
                  },
                  child: Card(
                    elevation: 4.0,
                    child: Center(
                      child: Text(
                        selectedNouns.contains(noun) ? noun.name : '?',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _selectNoun(NounModel noun) {
    setState(() {
      if (selectedNouns[0] == null) {
        selectedNouns[0] = noun;
      } else if (selectedNouns[1] == null) {
        selectedNouns[1] = noun;
        if (selectedNouns[0]!.name == selectedNouns[1]!.name &&
            selectedNouns[0]!.id != selectedNouns[1]!.id) {
          score++;
          selectedNouns = [null, null];
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Match found!')),
          );
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              selectedNouns = [null, null];
            });
          });
        }
      }
    });
  }
}
