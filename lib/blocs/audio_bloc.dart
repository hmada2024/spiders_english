// blocs/audio_bloc.dart
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'audio_event.dart';
import 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final audio.AudioPlayer _audioPlayer = audio.AudioPlayer();

  AudioBloc() : super(AudioInitial()) {
    on<PlayPronunciationEvent>(_onPlayAudio);
    on<StopAudioEvent>(_onStopAudio);
  }

  Future<void> _onPlayAudio(
      PlayPronunciationEvent event, Emitter<AudioState> emit) async {
    debugPrint('AudioBloc: Received PlayPronunciationEvent');
    try {
      if (event.audioData.isEmpty) {
        debugPrint('AudioBloc: Audio data is empty, cannot play.');
        return;
      }
      await _audioPlayer.stop(); // Stop any currently playing audio
      await _audioPlayer.play(audio.BytesSource(event.audioData));
      emit(AudioPlaying());
      debugPrint('AudioBloc: Audio playback started.');
    } catch (e) {
      debugPrint("AudioBloc: Error playing audio: $e");
    }
  }

  Future<void> _onStopAudio(
      StopAudioEvent event, Emitter<AudioState> emit) async {
    debugPrint('AudioBloc: Received StopAudioEvent');
    await _audioPlayer.stop();
    emit(AudioStopped());
    debugPrint('AudioBloc: Audio playback stopped.');
  }

  @override
  Future<void> close() {
    debugPrint('AudioBloc closed.');
    _audioPlayer.dispose();
    return super.close();
  }
}
