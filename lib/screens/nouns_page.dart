// screens/nouns_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/nouns_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/noun_model.dart';
import 'package:learn_box_english/widgets/common/audio_player_widget.dart';
import 'package:learn_box_english/widgets/common/data_loader.dart';

class NounsPage extends StatelessWidget {
  const NounsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouns'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider(
          create: (context) => NounsBloc(DatabaseHelper())..add(LoadNouns()),
          child: DataLoader<NounsBloc, NounsState, NounModel>(
            dataSelector: (state) {
              if (state is NounsLoaded) {
                return state.nouns;
              }
              return []; // Return an empty list by default
            },
            builder: (context, nouns) {
              return ListView.separated(
                itemCount: nouns.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  final noun = nouns[index];
                  return Card(
                    child: ListTile(
                      leading: noun.image != null
                          ? Image.memory(noun.image!, width: 50, height: 50)
                          : const Icon(Icons.image_not_supported),
                      title: Text(noun.name),
                      subtitle: Text(noun.category,
                          style: TextStyle(color: Colors.grey.shade600)),
                      trailing: AudioPlayerWidget(audioData: noun.audio),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
