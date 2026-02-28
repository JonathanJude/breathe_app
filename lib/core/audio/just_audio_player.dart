import 'package:breathe_app/core/audio/audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AppJustAudioPlayer implements AppAudioPlayer {
  AppJustAudioPlayer({AudioPlayer? player}) : _player = player ?? AudioPlayer();

  static const String _chimeAssetPath = 'assets/audio/chime-sound.mp3';

  final AudioPlayer _player;
  bool _isPreloaded = false;
  bool _isWebPrimed = false;

  @override
  Future<void> preload() async {
    if (!_isPreloaded) {
      await _player.setAsset(_chimeAssetPath);
      _isPreloaded = true;
    }

    if (kIsWeb && !_isWebPrimed) {
      await _primeWebAudioContext();
    }
  }

  @override
  Future<void> playChime() async {
    try {
      await preload();
      if (_player.playing) {
        await _player.stop();
      }

      await _player.seek(Duration.zero);
      await _player.play();
    } on Exception {
      // Keep breathing flow running if audio is not available on a device.
    }
  }

  @override
  Future<void> dispose() => _player.dispose();

  Future<void> _primeWebAudioContext() async {
    final previousVolume = _player.volume;
    await _player.setVolume(0);
    await _player.play();
    await _player.pause();
    await _player.seek(Duration.zero);
    await _player.setVolume(previousVolume);
    _isWebPrimed = true;
  }
}
