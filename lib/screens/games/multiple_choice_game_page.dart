// screens/games/multiple_choice_game_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/nouns_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/noun_model.dart';
import 'dart:math';

class MultipleChoiceGamePage extends StatefulWidget {
  const MultipleChoiceGamePage({super.key});

  @override
  State<MultipleChoiceGamePage> createState() => _MultipleChoiceGamePageState();
}

class _MultipleChoiceGamePageState extends State<MultipleChoiceGamePage> {
  NounModel? currentNoun;
  List<String> choices = [];
  String? selectedAnswer;
  bool answerCorrect = false;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Choice Quiz'),
      ),
      body: BlocProvider(
        create: (context) => NounsBloc(DatabaseHelper())..add(LoadNouns()),
        child: BlocBuilder<NounsBloc, NounsState>(
          builder: (context, state) {
            if (state is NounsLoaded) {
              if (state.nouns.isNotEmpty) {
                final random = Random();
                currentNoun = state.nouns[random.nextInt(state.nouns.length)];
                choices = _generateChoices(currentNoun!, state.nouns);
                selectedAnswer = null;
                answerCorrect = false;
              }
              return _buildQuizBody();
            } else if (state is NounsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NounsError) {
              return Center(
                  child: Text('Error loading nouns: ${state.message}'));
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildQuizBody() {
    if (currentNoun == null) {
      return const Center(child: Text('Loading question...'));
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'What is the meaning of "${currentNoun!.name}"?',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          ...choices.map((choice) => RadioListTile<String>(
                title: Text(choice),
                value: choice,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    selectedAnswer = value;
                  });
                },
              )),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: selectedAnswer != null ? _checkAnswer : null,
            child: const Text('Submit Answer'),
          ),
          if (selectedAnswer != null)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                answerCorrect
                    ? 'Correct! 🎉'
                    : 'Incorrect. The correct answer is ${currentNoun!.category}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: answerCorrect ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: _nextQuestion,
            child: const Text('Next Question'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text('Score: $score',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  List<String> _generateChoices(
      NounModel correctNoun, List<NounModel> allNouns) {
    final random = Random();
    List<String> options = [correctNoun.category];
    while (options.length < 4) {
      final option = allNouns[random.nextInt(allNouns.length)].category;
      if (!options.contains(option)) {
        options.add(option);
      }
    }
    options.shuffle();
    return options;
  }

  void _checkAnswer() {
    setState(() {
      answerCorrect = selectedAnswer == currentNoun!.category;
      if (answerCorrect) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    // إعادة تحميل الأسماء لضمان الحصول على اسم جديد
    context.read<NounsBloc>().add(LoadNouns());
    setState(() {
      currentNoun = null;
      selectedAnswer = null;
      answerCorrect = false;
    });
  }
}
