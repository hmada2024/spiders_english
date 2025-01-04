// blocs/audio_state.dart
abstract class AudioState {}

class AudioInitial extends AudioState {}

class AudioPlaying extends AudioState {}

class AudioStopped extends AudioState {}
