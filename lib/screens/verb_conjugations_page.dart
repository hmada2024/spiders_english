// screens/verb_conjugations_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/verb_conjugations_bloc.dart';
import 'package:learn_box_english/database/database_helper.dart';
import 'package:learn_box_english/models/verb_conjugation_model.dart';
import 'package:learn_box_english/widgets/common/data_loader.dart';
import 'package:learn_box_english/blocs/audio_bloc.dart';
import 'package:learn_box_english/blocs/audio_event.dart';

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
              return [];
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
                          // الفعل في الصيغة الأساسية
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (verb.basePronunciation != null &&
                                        verb.basePronunciation!.isNotEmpty) {
                                      context.read<AudioBloc>().add(
                                            PlayPronunciationEvent(
                                                verb.basePronunciation!),
                                          );
                                      print(
                                          'Playing base pronunciation for: ${verb.baseForm}');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Audio not available.')),
                                      );
                                      print(
                                          'Base pronunciation is null or empty for: ${verb.baseForm}');
                                    }
                                  },
                                  child: Text(
                                    verb.baseForm,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Text('(${verb.translation})',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600)),
                              ],
                            ),
                          ),

                          // الفعل في الماضي
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (verb.pastPronunciation != null &&
                                    verb.pastPronunciation!.isNotEmpty) {
                                  context.read<AudioBloc>().add(
                                        PlayPronunciationEvent(
                                            verb.pastPronunciation!),
                                      );
                                  print(
                                      'Playing past pronunciation for: ${verb.pastForm}');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Audio not available.')),
                                  );
                                  print(
                                      'Past pronunciation is null or empty for: ${verb.pastForm}');
                                }
                              },
                              child: Center(
                                child: Text(
                                  verb.pastForm,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // الفعل في الماضي التام
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (verb.ppPronunciation != null &&
                                    verb.ppPronunciation!.isNotEmpty) {
                                  context.read<AudioBloc>().add(
                                        PlayPronunciationEvent(
                                            verb.ppPronunciation!),
                                      );
                                  print(
                                      'Playing past participle pronunciation for: ${verb.pPForm}');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Audio not available.')),
                                  );
                                  print(
                                      'Past participle pronunciation is null or empty for: ${verb.pPForm}');
                                }
                              },
                              child: Center(
                                child: Text(
                                  verb.pPForm,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
