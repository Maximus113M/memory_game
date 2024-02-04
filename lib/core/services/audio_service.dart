import 'package:audioplayers/audioplayers.dart';
import 'package:memory_game/core/utils/utils.dart';

class AudioService {
  final musicPlayer = AudioPlayer();
  final foundSound = AudioPlayer();
  final winGameSound = AudioPlayer();
  static final AudioService _instance = AudioService._();
  AudioService._();
  factory AudioService() {
    return _instance;
  }

  void playFoundSound() async {
    await foundSound.play(AssetSource(AppAssets.foundCards),
        mode: PlayerMode.mediaPlayer);
  }

  void playWinningSound() async {
    await winGameSound.play(AssetSource(AppAssets.winGame),
        mode: PlayerMode.mediaPlayer);
  }

  void playGameMusic() async {
    musicPlayer.setReleaseMode(ReleaseMode.loop);
    musicPlayer.play(
      AssetSource(AppAssets.gameMusic2),
      mode: PlayerMode.mediaPlayer,
      volume: 0.25,
    );
  }

  void pauseMusic() {
    musicPlayer.pause();
  }

  void quitAllSounds() {
    musicPlayer.stop();
    foundSound.stop();
    winGameSound.stop();
  }

  void disableMusic() {
    musicPlayer.stop();
  }

  void disableSounds() {
    foundSound.stop();
    winGameSound.stop();
  }
}
