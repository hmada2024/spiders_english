// screens/verb_conjugations_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/verb_conjugations_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/verb_conjugation_model.dart';
import 'package:learn_box_english/widgets/common/audio_player_widget.dart';
import 'package:learn_box_english/widgets/common/data_loader.dart';

class VerbConjugationsPage extends StatelessWidget {
  const VerbConjugationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verb Conjugations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider(
          create: (context) =>
              VerbConjugationsBloc(DatabaseHelper())..add(LoadVerbs()),
          child: DataLoader<VerbConjugationsBloc, VerbConjugationsState,
              VerbConjugationModel>(
            dataSelector: (state) {
              if (state is VerbsLoaded) {
                return state.verbs;
              }
              return []; // Corrected: Return an empty list by default
            },
            builder: (context, verbs) {
              return ListView.separated(
                itemCount: verbs.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  final verb = verbs[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(verb.baseForm,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0)),
                                Text('(${verb.translation})',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(child: Text(verb.pastForm)),
                          ),
                          Expanded(
                            child: Center(child: Text(verb.pPForm)),
                          ),
                          SizedBox(
                              width: 40,
                              child:
                                  AudioPlayerWidget(audioData: verb.audioBlob)),
                        ],
                      ),
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
