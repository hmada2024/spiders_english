// blocs/audio_event.dart
import 'dart:typed_data';

abstract class AudioEvent {}

class PlayPronunciationEvent extends AudioEvent {
  final Uint8List audioData;
  PlayPronunciationEvent(this.audioData);
}

class StopAudioEvent extends AudioEvent {}
