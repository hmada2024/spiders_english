// blocs/audio_event.dart
import 'dart:typed_data';

abstract class AudioEvent {}

class PlayAudioEvent extends AudioEvent {
  final Uint8List audioData;
  PlayAudioEvent(this.audioData);
}

class StopAudioEvent extends AudioEvent {}

// New event for direct playAudio call
class PlayAudioDirectlyEvent extends AudioEvent {
  final Uint8List audioData;
  PlayAudioDirectlyEvent(this.audioData);
}
