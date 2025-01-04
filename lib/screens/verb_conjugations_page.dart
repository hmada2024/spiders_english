// screens/verb_conjugations_page.dart
import 'package:flutter/material.dart';
import 'package:learn_box_english/constants/constants.dart';
import 'package:learn_box_english/models/verb_conjugation_model.dart';
import 'package:learn_box_english/widgets/audio_player_widget.dart';
import 'package:learn_box_english/widgets/data_loader.dart';

class VerbConjugationsPage extends StatelessWidget {
  const VerbConjugationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verb Conjugations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataLoader<VerbConjugationModel>(
          tableName: AppConstants.verbConjugationsTable,
          fetchData: (dbHelper) => dbHelper.getVerbConjugations(),
          fromJson: VerbConjugationModel.fromJson,
          builder: (context, verbs) {
            return ListView.builder(
              itemCount: verbs.length,
              itemBuilder: (context, index) {
                final verb = verbs[index];
                return Card(
                  child: ListTile(
                    title: Text(verb.baseForm),
                    subtitle: Text(
                        'Past: ${verb.pastForm}, Past Participle: ${verb.pPForm}'),
                    trailing: AudioPlayerWidget(audioData: verb.audioBlob),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
