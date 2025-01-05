// screens/games/multiple_choice_game_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/nouns_bloc.dart'; // يمكنك تغيير البلوك حسب نوع الأسئلة
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/noun_model.dart'; // يمكنك تغيير النموذج حسب نوع الأسئلة
import 'package:learn_box_english/widgets/data_loader.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Choice Quiz'),
      ),
      body: BlocProvider(
        create: (context) => NounsBloc(DatabaseHelper())..add(LoadNouns()),
        child: DataLoader<NounsBloc, NounsState, NounModel>(
          dataSelector: (state) {
            if (state is NounsLoaded) {
              if (state.nouns.isNotEmpty) {
                final random = Random();
                currentNoun = state.nouns[random.nextInt(state.nouns.length)];
                choices = _generateChoices(currentNoun!, state.nouns);
                selectedAnswer = null;
                answerCorrect = false;
                return [currentNoun!];
              }
            }
            return [];
          },
          builder: (context, data) {
            if (currentNoun == null) {
              return const Center(child: Text('Loading question...'));
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('What is the meaning of "${currentNoun!.name}"?',
                      style: const TextStyle(fontSize: 20.0)),
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
                            ? 'Correct!'
                            : 'Incorrect. The answer is ${currentNoun!.category}', // يمكنك تعديل الإجابة الصحيحة هنا
                        style: TextStyle(
                            color: answerCorrect ? Colors.green : Colors.red),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: const Text('Next Question'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<String> _generateChoices(
      NounModel correctNoun, List<NounModel> allNouns) {
    final random = Random();
    List<String> options = [
      correctNoun.category
    ]; // يمكنك تعديل هذا ليكون المعنى أو الترجمة
    while (options.length < 4) {
      final option =
          allNouns[random.nextInt(allNouns.length)].category; // يمكنك تعديل هذا
      if (!options.contains(option)) {
        options.add(option);
      }
    }
    options.shuffle();
    return options;
  }

  void _checkAnswer() {
    setState(() {
      answerCorrect =
          selectedAnswer == currentNoun!.category; // يمكنك تعديل هذا
    });
  }

  void _nextQuestion() {
    setState(() {
      currentNoun = null; // لإعادة تحميل السؤال التالي
    });
  }
}
