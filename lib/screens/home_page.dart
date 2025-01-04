// screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:learn_box_english/constants/constants.dart';
import 'package:learn_box_english/screens/adjectives_page.dart';
import 'package:learn_box_english/screens/nouns_page.dart';
import 'package:learn_box_english/screens/verb_conjugations_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.7;
    final buttonPadding = EdgeInsets.symmetric(vertical: screenWidth * 0.02);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: buttonPadding,
                child: SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NounsPage()),
                      );
                    },
                    child: const Text('Nouns'),
                  ),
                ),
              ),
              Padding(
                padding: buttonPadding,
                child: SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdjectivesPage()),
                      );
                    },
                    child: const Text('Adjectives'),
                  ),
                ),
              ),
              Padding(
                padding: buttonPadding,
                child: SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerbConjugationsPage()),
                      );
                    },
                    child: const Text('Verb Conjugations'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
