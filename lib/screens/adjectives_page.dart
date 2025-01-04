// screens/adjectives_page.dart
import 'package:flutter/material.dart';
import 'package:learn_box_english/constants/constants.dart';
import 'package:learn_box_english/models/adjective_model.dart';
import 'package:learn_box_english/widgets/audio_player_widget.dart';
import 'package:learn_box_english/widgets/data_loader.dart';

class AdjectivesPage extends StatelessWidget {
  const AdjectivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adjectives'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataLoader<AdjectiveModel>(
          tableName: AppConstants.adjectivesTable,
          fetchData: (dbHelper) => dbHelper.getAdjectives(),
          fromJson: AdjectiveModel.fromJson,
          builder: (context, adjectives) {
            return ListView.builder(
              itemCount: adjectives.length,
              itemBuilder: (context, index) {
                final adjective = adjectives[index];
                return Card(
                  child: ListTile(
                    title: Text(adjective.mainAdj),
                    subtitle: Text(adjective.example),
                    trailing: AudioPlayerWidget(audioData: adjective.audio),
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
