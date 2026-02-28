abstract interface class AppAudioPlayer {
  Future<void> preload();

  Future<void> playChime();

  Future<void> dispose();
}
