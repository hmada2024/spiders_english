// screens/nouns_page.dart
import 'package:flutter/material.dart';
import 'package:learn_box_english/constants/constants.dart';
import 'package:learn_box_english/models/noun_model.dart';
import 'package:learn_box_english/widgets/audio_player_widget.dart';
import 'package:learn_box_english/widgets/data_loader.dart';

class NounsPage extends StatelessWidget {
  const NounsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouns'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DataLoader<NounModel>(
          tableName: AppConstants.nounsTable,
          fetchData: (dbHelper) => dbHelper.getNouns(),
          fromJson: NounModel.fromJson,
          builder: (context, nouns) {
            return ListView.builder(
              itemCount: nouns.length,
              itemBuilder: (context, index) {
                final noun = nouns[index];
                return Card(
                  child: ListTile(
                    leading: noun.image != null
                        ? Image.memory(noun.image!, width: 50, height: 50)
                        : const Icon(Icons.image_not_supported),
                    title: Text(noun.name),
                    subtitle: Text(noun.category),
                    trailing: AudioPlayerWidget(audioData: noun.audio),
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
