// screens/adjectives_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/adjectives_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/adjective_model.dart';
import 'package:learn_box_english/widgets/common/audio_player_widget.dart';
import 'package:learn_box_english/widgets/common/data_loader.dart';

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
        child: BlocProvider(
          create: (context) =>
              AdjectivesBloc(DatabaseHelper())..add(LoadAdjectives()),
          child: DataLoader<AdjectivesBloc, AdjectivesState, AdjectiveModel>(
            dataSelector: (state) {
              if (state is AdjectivesLoaded) {
                return state.adjectives;
              }
              return []; // Return an empty list by default
            },
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
      ),
    );
  }
}
