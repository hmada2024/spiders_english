// screens/games/fill_blanks_game_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/english_sentences_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/english_sentence_model.dart';
import 'package:learn_box_english/widgets/data_loader.dart';

class FillBlanksGamePage extends StatefulWidget {
  const FillBlanksGamePage({super.key});

  @override
  State<FillBlanksGamePage> createState() => _FillBlanksGamePageState();
}

class _FillBlanksGamePageState extends State<FillBlanksGamePage> {
  final TextEditingController _controller = TextEditingController();
  EnglishSentenceModel? currentSentence;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill in the Blanks'),
      ),
      body: BlocProvider(
        create: (context) => EnglishSentencesBloc(DatabaseHelper())
          ..add(LoadSentences()), // افترضنا وجود هذا الحدث
        child: DataLoader<EnglishSentencesBloc, EnglishSentencesState,
            EnglishSentenceModel>(
          dataSelector: (state) {
            if (state is EnglishSentencesLoaded) {
              // اختيار جملة عشوائية
              if (state.sentences.isNotEmpty) {
                currentSentence = (state.sentences..shuffle()).first;
                return [currentSentence!]; // يجب إرجاع قائمة
              }
            }
            return [];
          },
          builder: (context, sentences) {
            if (currentSentence == null) {
              return const Center(child: Text('Loading sentences...'));
            }
            final words = currentSentence!.sentence.split(' ');
            final blankIndex =
                words.indexWhere((word) => word == currentSentence!.answer);
            final maskedWords = List<String>.from(words);
            if (blankIndex != -1) {
              maskedWords[blankIndex] = '_____';
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(maskedWords.join(' '),
                      style: const TextStyle(fontSize: 22.0)),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter the missing word',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      _checkAnswer();
                    },
                    child: const Text('Check Answer'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _checkAnswer() {
    if (currentSentence != null &&
        _controller.text.trim() == currentSentence!.answer.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correct!')),
      );
      // يمكنك هنا الانتقال إلى جملة أخرى أو تحديث النتيجة
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect. Try again!')),
      );
    }
    _controller.clear();
  }
}
