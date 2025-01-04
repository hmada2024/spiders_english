// widgets/audio_player_widget.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_box_english/blocs/audio_bloc.dart';
import 'package:learn_box_english/blocs/audio_event.dart'; // Import AudioEvent

class AudioPlayerWidget extends StatelessWidget {
  final Uint8List? audioData;

  const AudioPlayerWidget({super.key, this.audioData});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.volume_up),
      onPressed: () {
        if (audioData != null && audioData!.isNotEmpty) {
          context
              .read<AudioBloc>()
              .add(PlayPronunciationEvent(audioData!)); // Dispatch event
        } else {
          debugPrint('Audio data is null or empty, cannot play.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Audio not available.')),
          );
        }
      },
    );
  }
}
