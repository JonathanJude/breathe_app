import 'package:breathe_app/core/audio/audio_player.dart';

class StubAudioPlayer implements AppAudioPlayer {
  @override
  Future<void> dispose() async {}

  @override
  Future<void> playChime() async {}

  @override
  Future<void> preload() async {}
}
