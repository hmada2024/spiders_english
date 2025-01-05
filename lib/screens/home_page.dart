// screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/nouns_bloc.dart';
import 'package:learn_box_english/constants/constants.dart';
import 'package:learn_box_english/screens/adjectives_page.dart';
import 'package:learn_box_english/screens/nouns_page.dart';
import 'package:learn_box_english/screens/settings_page.dart';
import 'package:learn_box_english/screens/verb_conjugations_page.dart';
import 'package:learn_box_english/screens/games/matching_game_page.dart';
import 'package:learn_box_english/screens/games/fill_blanks_game_page.dart';
import 'package:learn_box_english/screens/games/multiple_choice_game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHomePageButton(
              context: context,
              title: 'Nouns',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NounsPage()),
              ),
            ),
            _buildHomePageButton(
              context: context,
              title: 'Adjectives',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdjectivesPage()),
              ),
            ),
            _buildHomePageButton(
              context: context,
              title: 'Verb Conjugations',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VerbConjugationsPage()),
              ),
            ),
            _buildHomePageButton(
              context: context,
              title: 'Matching Game',
              onPressed: () {
                BlocProvider.of<NounsBloc>(context).add(LoadNouns());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MatchingGamePage()),
                );
              },
            ),
            _buildHomePageButton(
              context: context,
              title: 'Fill in the Blanks',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FillBlanksGamePage()),
              ),
            ),
            _buildHomePageButton(
              context: context,
              title: 'Multiple Choice Quiz',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MultipleChoiceGamePage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomePageButton({
    required BuildContext context,
    required String title,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
